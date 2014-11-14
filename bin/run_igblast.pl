#!/usr/bin/env perl
use Moose;
use feature "say";
use FindBin;
use lib "$FindBin::Bin/../lib";
use AntibodyDB::Schema;
use File::Basename;
use Data::Printer class => { expand => 'all' };
use Bio::SeqIO;
use Bio::Moose::Run::IgBlastN;
use Bio::Moose::IgBlastIO;
use File::Temp;
use KiokuDB;

print "Connecting into database...\n";
my $schema = AntibodyDB::Schema->connect( 'dbi:mysql:dbname=biomanager', 'root', '', );
my $dir = KiokuDB->connect( 'dbi:mysql:dbname=biomanager', user => 'root', password => '',);

our $igblast_param_id;
our $organism_id;

my $organism = "mouse";

&create_fasta;

sub create_fasta {
    # Get files that are ABI and don't have sequences yet
    my $seq =
        $schema->resultset('Sequence')->search( 
            { 
                'putative_annotations.sequence_id' => { '-NOT' => undef }, 
                'organism_name' => { like => $organism },
#                'me.sequence_id' => 1514,
                'me.sequence_id' => 3683,


#                'me.sequence_id' => 2528,


#                'me.sequence_id' => 3534,
#                'me.sequence_id' => 138,
#                'me.sequence_id' => 1126,
#                'me.sequence_id' => 78,
#                'me.sequence_id' => 63,
#                'me.sequence_id' => 3534,
#                'me.sequence_id' => 3494,
#                'me.sequence_id' => 1991,
            },
            { join => ['putative_annotations', 'organism'] } );

    my $total = $seq->count;
    say $total;

    my $tmp_fasta = File::Temp->new(unlink => 0, DIR => '/tmp/fasta');
    my $out = Bio::SeqIO->new( -file => '>' . $tmp_fasta->filename, -format => 'fasta' );

    say $tmp_fasta->filename;
    say "writing fasta";
    while ( my $s = $seq->next ) {
        #say $s->sequence_name;
        my $obj = Bio::Seq->new( -id => $s->id, -seq => $s->get_column('sequence') );
        $out->write_seq($obj);
    }

    say "Running Igblast";
    run_igblast_db($tmp_fasta->filename);
    
}

sub run_igblast_db {
    my ($file)  = @_;

    my $igblast_db = $schema->resultset('IgblastParam')->search(
        { organism_name => {like => $organism } },
        {
            join => 'organism'
        }
    );

    my $param = $igblast_db->first;
    say $param->igblast_param_v_database;
    say $param->igblast_param_d_database;
    say $param->igblast_param_j_database;
    say $param->igblast_param_auxiliary_data;

    $igblast_param_id = $param->igblast_param_id;
    $organism_id = $param->organism_id;

    my $r = Bio::Moose::Run::IgBlastN->new(
        query          => $file,
        germline_db_V  => $param->igblast_param_v_database,
        germline_db_D  => $param->igblast_param_d_database,
        germline_db_J  => $param->igblast_param_j_database,
        auxiliary_data => $param->igblast_param_auxiliary_data,
        domain_system  => 'kabat',
        organism       => $organism
    );

    my $outfile = File::Temp->new(unlink => 0, DIR => '/tmp/igblast');
    say $outfile->filename;
    open( my $out, '>', $outfile->filename )
        || die "Cannot open/write file " . $outfile->filename . "!";
    say $out $r->out_as_string();
    close($out);

    parse_igblastn($outfile->filename);
}

sub run_igblast {
    my ($file)  = @_;

    my $M_db_path = '/work/bioinformatics/igblast/imgt';
    my $m       = Bio::Moose::Run::IgBlastN->new(
        query          => $file,
        germline_db_V  => "$M_db_path/database/mouse_gl_V",
        germline_db_D  => "$M_db_path/database/mouse_gl_D",
        germline_db_J  => "$M_db_path/database/mouse_gl_J",
        auxiliary_data => "$M_db_path/../optional_file/mouse_gl.aux",
        domain_system  => 'kabat',
        organism       => "mouse"
    );

    my $H_db_path = '/work/bioinformatics/igblast';
    my $h       = Bio::Moose::Run::IgBlastN->new(
        query          => $file,
        germline_db_V  => "$H_db_path/database/human_gl_V",
        germline_db_D  => "$H_db_path/database/human_gl_D",
        germline_db_J  => "$H_db_path/database/human_gl_J",
        auxiliary_data => "$H_db_path/optional_file/human_gl.aux",
        domain_system  => 'kabat',
        organism       => "mouse"
    );

    my $outfile = File::Temp->new(unlink => 0, DIR => '/tmp/igblast');
    say $outfile->filename;
    open( my $out, '>', $outfile->filename )
        || die "Cannot open/write file " . $outfile->filename . "!";
    say $out $h->out_as_string();
    close($out);

    parse_igblastn($outfile->filename);
}


sub parse_igblastn {
    my ( $igblast_file ) = @_;
    say "Parsing File";
    my $in = Bio::Moose::IgBlastIO->new(
        file   => $igblast_file,
        format => 'format4'
    );
    my $i =0;
    while ( my $feat = $in->next_feature ) {
        #       next unless $feat->is_reliable && !$feat->is_complete;
        next unless $feat->mismatches; 
        say $feat->query_id;
        my $seq = $schema->resultset('Sequence')->find( { sequence_id => $feat->query_id } );
        say $seq->sequence_name;
        say $feat->best_V;
        say $feat->best_D;
        say $feat->best_J;
        
        #add_object_to_database($feat);

        #p $feat if $seq->sequence_name eq 'Alex_2ndSORT_081414_G29-IgGWinner.ab1';
        say "chain: ".$feat->chain_type;
        say "is_reliable: ".$feat->is_reliable;
        say "is_complete: ".$feat->is_complete;
        say "is_almost_perfect: ".$feat->is_almost_perfect;
        say "is_perfect: ".$feat->is_perfect;
        say "CDR3 nt: ". $feat->infer_CDR3_nt;
        say "CDR3 aa: ". $feat->infer_CDR3_aa;
        say join "", @{ $feat->mismatches->{complete_germ} };
        $i++;
        #p $feat->mismatches;
        say $feat->igblast_block;
        #    p $feat;
        # die;
    }
    say "Total sequences: $i";
}


sub add_object_to_database {
    my ($feat) = @_;
    
    return unless $feat->chain_type;
    my $chain_rs =
        $schema->resultset('ChainType')->find( { chain_type_name => { 'like' => $feat->chain_type.'%' }} );

    unless ($chain_rs){
        $chain_rs =
        $schema->resultset('ChainType')->find( { chain_type_name => { 'like' => 'unknown%' }} );
    }

    die "cannont find ". $feat->chain_type .' in database' unless $chain_rs;

    my $putative_rs = $schema->resultset('PutativeAnnotation');

    my $already_present = $putative_rs->find( 
        { 
            igblast_param_id => $igblast_param_id, 
            sequence_id => $feat->query_id,
        } 
    );

    return if $already_present;

    my $has_mismatches = 0;
    $has_mismatches = 1 if $feat->mismatches;
    
    my %params = (
        chain_type_id                         => $chain_rs->id,
        igblast_param_id                      => $igblast_param_id,
        putative_annotation_putative_cdr3     => $feat->infer_CDR3_nt,
        putative_annotation_putative_cdr3_aa  => $feat->infer_CDR3_aa,
        sequence_id                           => $feat->query_id,
        organism_id                           => $organism_id,
        putative_annotation_is_reliable       => $feat->is_reliable,
        putative_annotation_is_complete       => $feat->is_complete,
        putative_annotation_is_almost_perfect => $feat->is_almost_perfect,
        putative_annotation_is_perfect        => $feat->is_perfect,
        putative_annotation_has_mismatches    => $has_mismatches,
    );

   # for rearrangement summary
    if ( $feat->rearrangement_summary ) {
        my %r_summary;
        my $summary = $feat->rearrangement_summary;
        my ($V, $D, $J);
        $V = $summary->top_V_match;
        $D = $summary->top_D_match;
        $J = $summary->top_J_match;

        # leaving only first
        $V =~ s/\,.*//g;
        $D =~ s/\,.*//g;
        $J =~ s/\,.*//g;

        %r_summary = (
            putative_annotation_productive => $summary->productive,
            putative_annotation_stop_codon => $summary->stop_codon,
            putative_annotation_best_v     => $V,
            putative_annotation_best_d     => $D,
            putative_annotation_best_j     => $J,
        );
        @params{keys %r_summary} = values %r_summary;
    }

    # for alignemnt summary
    if ( $feat->alignments ) {
        my %alns;
        my $aln = $feat->alignments;
        my @regions = (qw/FWR1 CDR1 FWR2 CDR2 FWR3/);
        
        foreach my $R (@regions) {
            my $r = lc($R);
            if ($aln->$R){
                $alns{ "putative_annotation_" . $r .'_mismatches'} = $aln->$R->mismatches;
                $alns{ "putative_annotation_" . $r .'_gaps'} = $aln->$R->gaps;
                my ($mismatches, $insertions, $deletions) = $feat->infer_aa_diff($R);
                $alns{ "putative_annotation_" . $r .'_mismatches_aa'} = $mismatches;
                $alns{ "putative_annotation_" . $r .'_insertions_aa'} = $insertions;
                $alns{ "putative_annotation_" . $r .'_deletions_aa'} = $deletions;
            }
        }
        @params{keys %alns} = values %alns;
    }

    # Rendered_alignment
    if ( $feat->alignments ) {
        my %alns;
        my $aln = $feat->alignments;
        my @regions = (qw/FWR1 CDR1 FWR2 CDR2 FWR3/);
        
        foreach my $R (@regions) {
            my $r = lc($R);
            
            if ($feat->rendered_alignment){
                my $render = $feat->rendered_alignment;
                if ($render->query){
                    my $q = $render->query;

                    $alns{ "putative_annotation_seq_nt"} = $q->sequence;
                    $alns{ "putative_annotation_seq_aa"} = $q->translation;
                    
                    my $predicate = 'has_'.$R;
 
                    if ($q->sub_regions_sequence){
                        my $sub = $q->sub_regions_sequence;
                       if ($sub->$predicate){
                            $alns{ "putative_annotation_" . $r } = $sub->$R;
                        }
                    }
                    if ($q->sub_regions_translation){
                        my $sub = $q->sub_regions_translation;
                        if ($sub->$predicate){
                            $alns{ "putative_annotation_" . $r."_aa" } = $sub->$R;
                        }
                    }
                }
            }
        }
        @params{keys %alns} = values %alns;
    }


    p %params;
    
    my $scope = $dir->new_scope;

    my $obj_id = $dir->store($feat);

    $putative_rs->create( { %params, object_id => $obj_id } );

}
