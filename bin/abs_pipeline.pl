#!/usr/bin/env perl
use Moose;
use feature qw(say);
use MooseX::Declare;
use Method::Signatures::Modifiers;
BEGIN { our $Log_Level = 'info' }
 
class MyApp is dirty {
    use MooseX::App qw(Color);
    use Log::Any::App '$log',
        -screen => { pattern_style => 'script_long' },
        -file => { path => 'logs/', level => 'debug' };

    has 'log' => (
        is            => 'ro',
        isa           => 'Object',
        required      => 1,
        default       => sub { return $log },
        documentation => 'Keep Log::Any::App object',
    );
}

class MyApp::ClusterAbs {
    extends 'MyApp'; # inherit log
    use FindBin;
    use lib "$FindBin::Bin/../lib";
    use MooseX::App::Command;    # important
    use MooseX::FileAttribute;
    use Bio::Moose::IgBlastIO;
    use String::Approx 'amatch';
    use String::Cluster::Hobohm;
    use Data::Printer;
    use Excel::Template::Plus::TT;
    use Excel::Writer::XLSX;
    use Storable qw(dclone);
    use Bio::Moose::IgBlastIO;
    use File::Temp;
    use KiokuDB;
    use AntibodyDB::Schema;
    #use Data::Printer class => { expand => 'all' };
    use Data::Printer;


    #use Data::Printer  deparse => 1, sort_keys => 1, class => {expand => 'all'};

    command_short_description q[This command is awesome];
    command_long_description q[This command is so awesome, yadda yadda yadda];

    
    has_file 'output_file' => (
        traits        => ['AppOption'],
        cmd_type      => 'option',
        cmd_aliases   => [qw(o)],
        required      => 1,
        documentation => q[Output file in xlsx format],
    );
 
    option 'cdr3_similarity' => (
        is          => 'rw',
        isa         => 'Num',
        cmd_aliases => 's',
        required    => 1,
        default     => 0.7
    );

    option 'use_light' =>(
        is => 'rw',
        isa => 'Bool'
    );

    has 'schema' => (
        is      => 'rw',
        isa     => 'Object',
        default => sub {
            my $schema = AntibodyDB::Schema->connect( 'dbi:mysql:dbname=biomanager', 'root', '', );
            return $schema;
        }
    );

    has 'kiokudb' => (
        is      => 'rw',
        isa     => 'Object',
        default => sub {
            my $dir =
                KiokuDB->connect( 'dbi:mysql:dbname=biomanager', user => 'root', password => '', );
            return $dir;
        }
    );


    method get_combo_from_db {
        my %combo;
        #$combo{id}{'H|L|L'};        
        my $sequence_rs = $self->schema->resultset('PutativeAnnotation')->search(
            { heavy_file_id => { '-NOT' => undef  } },
            {   join => { 'sequence_rel' => 'sequence_has_sequence_heavy_files' },
            }

        );

        #my $seq = $sequence_rs->search({});
        my $scope = $self->kiokudb->new_scope;
        
        my $i =1;
        while ( my $s = $sequence_rs->next ) {
            my $heavy_seq = $s->sequence_rel;
            #say $heavy_seq->get_column('sequence_name');
            my $heavy_has_light = $heavy_seq->sequence_has_sequence_heavy_files->first;
            my $light_seq =  $heavy_has_light->light_file;
            say join " => ",($heavy_seq->get_column('sequence_name'),$light_seq->get_column('sequence_name'));

            my $heavy_putative = $heavy_seq->putative_annotations->first;            
            my $light_putative = $light_seq->putative_annotations->first;
            $combo{$i}{H} = $self->kiokudb->lookup($heavy_putative->object_id);
            $combo{$i}{L}{kappa} = $self->kiokudb->lookup($light_putative->object_id);
            $i++;
        }

       $self->log->info("Total of sequences loaded:". scalar keys %combo);
       return \%combo;
    }


    method _filter_chain (Bio::Moose::IgBlast $chain) {
        my $key = 0;

        # Filter Heavy and Light chain without alignments with germline
        if ( $chain->rearrangement_summary ) {
            my $r = $chain->rearrangement_summary;

            # Getting (VDJ info)
=cut
            if (
                ( $r->top_V_match && $r->top_J_match )
                && (   $r->top_V_match ne 'N/A'
                    && $r->top_J_match ne 'N/A' )
              )
            {
=cut

            if (   ( $r->top_V_match )
                && ( $r->top_V_match ne 'N/A' ) )
            {

                # Getting Bio::Moose::IgBlast::RenderedAlignment object
                my $aln = $chain->rendered_alignment;
                if ($aln) {
                    if ( $chain->infer_CDR3_nt_length ne 'N/A' ) {
                        my @V = split ",", $r->top_V_match;
                        #my @J = split ",", $r->top_J_match;
                        #$key = "($V[0]!$J[0])";
                        $key = "($V[0])";
                    }
                }
            }
        }
        return $key;
    }


    method filter_abs ( HashRef $combo) {
        my %to_cluster;
        my %heavy_only;
        my %light_only;
        my %trash;
        my %count;

        foreach my $well ( sort { $a cmp $b } keys %{$combo} ) {
            my $chains = $combo->{$well};
            my $heavy  = $chains->{H};
            my $lambda = $chains->{L}{lambda};
            my $kappa  = $chains->{L}{kappa};

            my ( $key_heavy, $key_lambda, $key_kappa );
            $key_heavy = $self->_filter_chain($heavy) if $heavy;
            $key_lambda = $self->_filter_chain($lambda) if $lambda;
            $key_kappa = $self->_filter_chain($kappa) if $kappa;

            # skip sequences without heavy or light chain
            if ( $key_heavy && $key_kappa ) {
                my $key = "$key_heavy|$key_kappa";
                #my $key = "$key_heavy";
                $to_cluster{$key}{$well} = $combo->{$well};
                $count{to_cluster}++;
            }
            elsif ($key_heavy) {
#            if ($key_heavy) {
                $heavy_only{$key_heavy}{$well} = $combo->{$well};
                $count{heavy_only}++;
            }
            elsif ($key_lambda && $key_kappa) {
                my $key = "$key_lambda|$key_kappa";
                $light_only{$key}{$well} = $combo->{$well};
                $count{lambda_and_kappa_only}++;
            }
            elsif ($key_lambda && $key_kappa) {
                my $key = "$key_lambda|$key_kappa";
                $light_only{$key}{$well} = $combo->{$well};
                $count{lambda_and_kappa_only}++;
            }
            elsif ($key_lambda) {
                $light_only{$key_lambda}{$well} = $combo->{$well};
                $count{lambda_only}++;
            }
            elsif ($key_kappa) {
                $light_only{$key_kappa}{$well} = $combo->{$well};
                $count{kappa_only}++;
            }
            else {
                $trash{$well} = $combo->{$well};
                $count{trash}++;
            }

        }
        p %count;
        return {
            to_cluster => \%to_cluster,
            heavy_only => \%heavy_only,
            light_only => \%light_only,
            trash      => \%trash
        };
    }


    method clustering_both (HashRef $to_cluster) {
        my %clone;

        my $clusterer = String::Cluster::Hobohm->new( similarity => $self->cdr3_similarity );

        # Looking for CDR3
        foreach my $vj_key ( sort { $a cmp $b } keys %{$to_cluster} ) {
            my %aux;

            foreach
              my $well ( sort { $a cmp $b } keys %{ $to_cluster->{$vj_key} } )
            {
                my $h_cdr3 =
                  $to_cluster->{$vj_key}->{$well}->{H}
                  ->infer_CDR3_nt;
                my $l_cdr3 =
                  $to_cluster->{$vj_key}->{$well}->{L}->{kappa}
                  ->infer_CDR3_nt;

                $h_cdr3 =~ s/\|//g;
                $l_cdr3 =~ s/\|//g;

                my $cdr3_key = "($h_cdr3!$l_cdr3)";

                push @{ $aux{$cdr3_key} }, $to_cluster->{$vj_key}->{$well};

            }

            my @CDR3s  = keys %aux;
            my $groups = $clusterer->cluster( \@CDR3s );

            foreach my $g ( @{$groups} ) {
                my $cdr3 = ${ $g->[0] };
                foreach my $el ( @{$g} ) {
                    push @{ $clone{$vj_key}{$cdr3} }, @{ $aux{ ${$el} } };
                }
            }
        }
        return \%clone;

    }


    method _print_clones ($clone, $chain_type) {
        my $counter = 0;
        foreach my $vj_key ( sort { $a cmp $b } keys %{$clone} ) {
            foreach
              my $cdr3_key ( sort { $a cmp $b } keys %{ $clone->{$vj_key} } )
            {
                if ( scalar @{ $clone->{$vj_key}->{$cdr3_key} } > 0 ) {
                    $counter += scalar @{ $clone->{$vj_key}->{$cdr3_key} };

#my $i;
#say $k. $c;
#say join "\t", ( $i++, $_->[0]->{$chain_type}->query_id ) foreach @{ $clone->{$k}->{$c} };
                }
            }
        }
        #say "total of seqs $chain_type:" . $counter;
    }


    method clustering_single (HashRef $to_cluster, Str $chain_type) {
        my %clone;

        my $clusterer = String::Cluster::Hobohm->new( similarity => $self->cdr3_similarity );
        my $i = 0;

        # Looking for CDR3 in each VJ cluster
        my $sum   = 0;
        my $debug = 0;

        foreach my $vj_key ( sort { $a cmp $b } keys %{$to_cluster} ) {
            my %aux;

            # Group by CDR3
            foreach
              my $well ( sort { $a cmp $b } keys %{ $to_cluster->{$vj_key} } )
            {
                $i++;
                my $cdr3;
                if ( $chain_type =~ /H/ ){
                    $cdr3 = $to_cluster->{$vj_key}->{$well}->{H}
                  ->infer_CDR3_nt;
                }
                if ($chain_type =~ /L/){
                    my $lambda = $to_cluster->{$vj_key}->{$well}->{L}{lambda};
                    my $kappa = $to_cluster->{$vj_key}->{$well}->{L}{kappa};

                    if ($lambda){
                        $cdr3 .= $lambda->infer_CDR3_nt;   
                    }
                    if ($kappa){
                        $cdr3 .= $kappa->infer_CDR3_nt;   
                    }
                }
                #else {
                #    die "No H or L chain specified";
                # }

                $cdr3 =~ s/\|//g;
                my $cdr3_key = $cdr3;
                
                push @{ $aux{$cdr3_key} }, $to_cluster->{$vj_key}->{$well};
                delete $to_cluster->{$vj_key}->{$well};
            }

            $debug += scalar @{ $aux{$_} } foreach keys %aux;
            my @CDR3s  = sort {$a cmp $b } keys %aux;
            my $groups = $clusterer->cluster( \@CDR3s );

            foreach my $g ( @{$groups} ) {
                my $cdr3 = ${ $g->[0] };
                foreach my $el ( @{$g} ) {
                    push @{ $clone{$vj_key}{$cdr3} }, @{ $aux{ ${$el} } };
                    delete $aux{ ${$el} };
                }
                $sum += scalar @{ $clone{$vj_key}{$cdr3} };
            }
        }
        #say "Sum $chain_type: $sum";
        #say "Debug: $debug";

        $self->_print_clones( \%clone, $chain_type );
        #say "Well $chain_type: $i";
        return \%clone;
    }


    method combine_clones (HashRef :$both_clones, HashRef :$heavy_clones, HashRef :$light_clones) {

        my $clusterer = String::Cluster::Hobohm->new( similarity => $self->cdr3_similarity );
        if ($both_clones){
        foreach my $vj_k ( sort { $a cmp $b } keys %{$both_clones} ) {
            say $vj_k;
            my ( $Hvj, $Lvj ) = split /\|/, $vj_k;
            my $heavy_only = $heavy_clones->{$Hvj};
            my $light_only = $light_clones->{$Lvj};

            foreach my $cdr3_both ( sort { $a cmp $b }
                keys %{ $both_clones->{$vj_k} } )
            {
                my ( $h_cdr3, $l_cdr3 );
                ( $h_cdr3, $l_cdr3 ) = ( $1, $2 )
                  if $cdr3_both =~ /\((.*)\!.(.*)\)/;

                if ($heavy_only) {

                    # heavy
                    my @cdr3_heavy_only = keys %{$heavy_only};

                    # clustering
                    push @cdr3_heavy_only, $h_cdr3;
                    my $h_groups = $clusterer->cluster( \@cdr3_heavy_only );

                    foreach my $g ( @{$h_groups} ) {
                        my %hash = map { ${$_} => 1 } @{$g};

                        if ( $hash{$h_cdr3} ) {

                            foreach my $k ( keys %hash ) {

                                if ( $heavy_only->{$k} ) {
                                    push @{ $both_clones->{$vj_k}->{$cdr3_both}
                                      },
                                      @{ $heavy_only->{$k} };
                                    delete $heavy_only->{$k};
                                }

                            }
                        }
                    }

                }

                if ($light_only) {

                    # light
                    my @cdr3_light_only = keys %{$light_only};

                    # clustering
                    push @cdr3_light_only, $l_cdr3;
                    my $l_groups = $clusterer->cluster( \@cdr3_light_only );

                    foreach my $g ( @{$l_groups} ) {
                        my %hash = map { ${$_} => 1 } @{$g};

                        if ( $hash{$l_cdr3} ) {

                            foreach my $k ( keys %hash ) {

                                if ( $light_only->{$k} ) {
                                    push @{ $both_clones->{$vj_k}->{$cdr3_both}
                                      },
                                      @{ $light_only->{$k} };
                                    delete $light_only->{$k};

                                }
                            }
                        }

                    }
                }
            }
        }
        }
        return {
            both_chains => $both_clones,
            heavy_only  => $heavy_clones,
            light_only  => $light_clones
        };
    }


    # Only for heavy_chain
    method get_jitter_plot_info (HashRef $heavy_clusters, HashRef $aux, ArrayRef $order, ArrayRef $colors) {
        my $jitter_file = $self->output_file->stringify;
        $jitter_file =~ s/\.xls.*//g;
        $jitter_file .= ".csv";
        
        open( my $out, '>', $jitter_file );
        say $out join ",", (qw/ clone_id region nt_mismatches aa_mismatches mycolor/); 
        my @regions = (qw/ FWR1 CDR1 FWR2 CDR2 FWR3 /);
        my $clone_id = 0;

        foreach my $key ( @{$order} ) {
            $clone_id++;
            my $color = 'FFFFFFF';
            if ($aux->{$key} > 1){
                $color = shift @{$colors};
            }
            my ( $vdj_key, $cdr3_key ) = split /\_/, $key;
            $color = 'FFFFFF' if scalar @{ $heavy_clusters->{$vdj_key}->{$cdr3_key} } == 1;
            foreach my $well ( @{ $heavy_clusters->{$vdj_key}->{$cdr3_key} } ) {
                my $feature = $well->{H};
                my $aln = $feature->rendered_alignment;

                if ($aln) {
                    my $sub_r = $aln->query->sub_regions_sequence;
                    my $sub_t = $aln->query->sub_regions_translation;

                    # CDR3
                    #push @col,
                    #    (
                    #    $feature->infer_CDR3_nt, $feature->infer_CDR3_nt_length,
                    #    $feature->infer_CDR3_aa, $feature->infer_CDR3_aa_length
                    #    );
                    
                    my $nt_total=0;
                    my $aa_total=0;
                    foreach my $r (@regions) {
                        my $pred = "has_$r";
                        if ( $sub_r->$pred ) {
                            my ( $mismatches, $insertions, $deletions ) =
                                $feature->infer_aa_diff($r);
                            say $out join ",",
                                ( $clone_id, $r, $feature->alignments->$r->mismatches, $mismatches, "#$color" );
                            $nt_total += $feature->alignments->$r->mismatches;
                            $aa_total += $mismatches; 
                        }
                    }
                    say $out join ",",
                                ( $clone_id, 'Total', $nt_total, $aa_total, "#$color" );
                    

                }
            
            }
            if ( $aux->{$key} > 1 ) {
                push @{$colors}, $color;
            }
        }

        close($out);
    }

    method output_excel (HashRef $all_clusters, HashRef $trash) {
        my @ROWS    = (qw/best_V best_D best_J/);
        my @regions = (qw/ FWR1 CDR1 FWR2 CDR2 FWR3 /);

        #my @col_header = (qw/query_id/, @ROWS ,qw/CDR3_seq CDR3_length FWR1 gaps mismatches CDR1 gaps mismatches FWR2 gaps mismatches CDR2 gaps mismatches FRW3 gaps mismatches/);
        my @col_header = (
            qw/query_id productive stop-codon/, @ROWS,
           qw/CDR3_nt CDR3_nt_length CDR3_aa CDR3_aa_length FWR1 gaps mismatches aa_mismatches aa_insertions aa_deletions FWR1_aa CDR1 gaps mismatches aa_mismatches aa_insertions aa_deletions CDR1_aa FWR2 gaps mismatches aa_mismatches aa_insertions aa_deletions FWR2_aa CDR2 gaps mismatches aa_mismatches aa_insertions aa_deletions CDR2_aa FRW3 gaps mismatches aa_mismatches aa_insertions aa_deletions FRW3_aa total_nt_mismatches nt_sequence total_aa_mismatches aa_sequence nt_matches_seq/

        );
        
        my @final_header;

        foreach my $chain (qw/heavy lambda kappa/) {
            push @final_header, $_.'_'.$chain foreach @col_header;
        }

        @final_header = ( 'clone_id','n_sequences',@final_header);

        my %aux;
        my %aux_order;
        my %filtered; # remove sequences with stop codon from analysis
        my $copy_all_clusters =  dclone($all_clusters);
        my %aux_copy;

        foreach my $type ( sort { $a cmp $b }  keys %{$all_clusters} ) {
            my $clone = $all_clusters->{$type};
            say $type;
            foreach my $vj_key ( sort { $a cmp $b } keys %{$clone} ) {
                foreach my $cdr3_key (
                    sort { $a cmp $b }
                    keys %{ $clone->{$vj_key} }
                    )
                {
                    $aux{$type}{ $vj_key . '_' . $cdr3_key } = scalar @{ $clone->{$vj_key}->{$cdr3_key} };
                    
                    my $z=0;
                    foreach my $well (@{ $clone->{$vj_key}->{$cdr3_key} }) {

                        if ( $well->{H}){

                            if ( $well->{H}->rearrangement_summary ){

                                my $has_stop_codon = $well->{H}->rearrangement_summary->stop_codon;
                                
                                if ( $has_stop_codon =~ /Yes/i){
                                    splice (@{$copy_all_clusters->{$type}->{$vj_key}->{$cdr3_key}},$z,1)                         
                                }else{
                                    $z++;
                                }
                            }
                        }
                    }
                    $aux_copy{$type}{ $vj_key . '_' . $cdr3_key } = scalar @{ $copy_all_clusters->{$type}->{$vj_key}->{$cdr3_key} };
                }
            }
            my @order =  sort { $aux{$type}{$b} <=> $aux{$type}{$a} || $a cmp $b } keys %{$aux{$type}};
            $aux_order{$type} = \@order;
        }
        
        # Remove light chains of copy
        delete $copy_all_clusters->{light_only};
          # Set color
        my @colors = (
            qw [FF0000
                FF8000
                FFFF00
                80FF00
                00FF00
                00FF80
                00FFFF
                0080FF
                0000FF
                7F00FF
                FF00FF
                FF007F
                808080
                ]);


        my @colors_copy = @colors;

        # Getting information about Regions
        $self->get_jitter_plot_info($copy_all_clusters->{heavy_only},$aux{heavy_only},$aux_order{heavy_only}, \@colors_copy);




        my @clones;
        my @values;
        my @values_copy;
        my $single = 0;
        my $single_copy = 0;
        my $j = 1;


        foreach my $key (@{$aux_order{heavy_only}}) {
           my $count = $aux{heavy_only}{$key};
           my $count_copy = $aux_copy{heavy_only}{$key};
 
           if ($count > 1){
               push @clones, $j++;
               push @values, $count;
               push @values_copy, $count_copy;
           }
           else{
               $single++;
                if ($count_copy == 1){
                    $single_copy++;
                }
           }

        }
        push @clones, $j if $single;
        push @values, $single if $single;
        push @values_copy, $single_copy if $single_copy;

        my $data = [
            ['clone_id',@clones],
            ['count', @values],
            ['count_filtered', @values_copy],
        ];
        
        # Create the Excel template
        my $template = Excel::Template::Plus::TT->new( template => 'bin/report.xml', );

              # Start modify palette from this index
        my $index=16;

        # Add a few parameters
        $template->param(
            all_clusters    => $all_clusters,
            filtered_all_clusters    => $copy_all_clusters,
            aux_order       => \%aux_order,
            aux             => \%aux,
            worksheet_name  => 'test',
            col_header      => \@final_header,
            trash           => $trash,
            max_color_index => ( $index + $#colors ),

        );

        my $workbook = $self->_get_xls_object( $template, $self->output_file->stringify );

        # Reindexing colors
        foreach my $color (@colors) {
            $workbook->set_custom_color( $index++, "#$color" );
        }
        
        foreach my $sheet ($workbook->sheets()) {
            $sheet->set_zoom(65);
        }

        my $worksheet = $workbook->add_worksheet('heavy_only_chart');

        $worksheet->write( 'A1', $data );

        # Chart colors;
        my @chart_color;
        for ( my $var = 0; $var < $#clones; $var++ ) {
            my $col = shift @colors;
            push @chart_color, { fill => { color => "#$col" }, line => { none => 0, color => '#000000' } };
            push @colors, $col;
        }
        # Singlets are white
        push @chart_color, { fill => { color => "#FFFFFF" },  line => { none => 0, color => '#000000' } };

        # Add a worksheet chart.
        my $chart = $workbook->add_chart( type => 'pie', embedded => 1 );
        my $chart_filtered = $workbook->add_chart( type => 'pie', embedded => 1 );

        # Configure the chart.
        $chart->add_series(
            categories => '=heavy_only_chart!$A$2:$A$' . ( scalar @clones + 1 ),
            values     => '=heavy_only_chart!$B$2:$B$' . ( scalar @values + 1 ),
            points     => \@chart_color,
        );

        # Configure the chart.
        $chart_filtered->add_series(
            categories => '=heavy_only_chart!$A$2:$A$' . ( scalar @clones + 1 ),
            values     => '=heavy_only_chart!$C$2:$C$' . ( scalar @values_copy + 1 ),
            points     => \@chart_color,
        );

        #Insert the chart into the worksheet (with an offset).
        $worksheet->insert_chart( 'D2', $chart, 25, 10 );
        $worksheet->insert_chart( 'O2', $chart_filtered, 25, 10 );
        $workbook->close();
    }

    method _get_xls_object (Object $template, Str $filename) {
        my $workbook = Excel::Writer::XLSX->new($filename)
            || die "Cannot create XLS in '$filename': $!\n";

        eval { $template->_excel_template->_prepare_output($workbook); };
        die p $@ if $@;
        return if $@;

        return $workbook;
    }

    method run {

        #Code here
        my $combo;
        #$combo = $self->get_combined_H_and_L_chains;
        $combo = $self->get_combo_from_db;

        my $groups = $self->filter_abs($combo);
        my $light_clones = $self->clustering_single( $groups->{light_only}, 'L' );
        #my $lambda_clones = $self->clustering_single( $groups->{light_only}, 'L' );
        #my $kappa_clones = $self->clustering_single( $groups->{light_only}, 'L' );


       my $all;
       if ( $self->use_light ) {
             my $both_clones = $self->clustering_both( $groups->{to_cluster}, );

            #$self->_print_clones( $both_clones, 'H' );

            my $heavy_clones = $self->clustering_single( $groups->{heavy_only}, 'H' );

            #        if (! $self->lotta) {

            $all = $self->combine_clones(
                both_clones  => $both_clones,
                heavy_clones => $heavy_clones,
                light_clones => $light_clones
            );

            #}
        }
        else{
            my %hash = ( %{ $groups->{to_cluster} }, %{ $groups->{heavy_only} } );
            my $heavy_clones = $self->clustering_single( \%hash, 'H' );
            $all = {
                heavy_only => $heavy_clones,
                light_only => $light_clones,
            }

        }

        #$self->output($all,$groups->{trash});

        $self->log->info("==> Write into Excel <==");
        $self->output_excel($all,$groups->{trash});
    }
}

class Main {
    import MyApp;
    MyApp->new_with_command->run();
}
