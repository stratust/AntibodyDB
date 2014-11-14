#!/usr/bin/env perl
use Moose;
use feature "say";
use FindBin;
use lib "$FindBin::Bin/../lib";
use AntibodyDB::Schema;
use File::Basename;
use Data::Printer class => { expand => 'all' };
use Bio::SeqIO;

print "Connecting into database...\n";
my $schema = AntibodyDB::Schema->connect(
    'dbi:mysql:dbname=biomanager',
    'root',
    '',
);


# Get files that are ABI and don't have sequences yet
my $file = $schema->resultset('File')->search(
    {   file_type_name => 'ABI',
        sequence_id    => { '=' => undef },
    },
    { join => [ 'sequences', 'file_type' ] }
);

my $total = $file->count;

while ( my $f = $file->next ) {
    say $f->file_name;
    store_sequence( $f->id, $f->file_path, $f->file_name, $f->organism_id );
}

sub store_sequence {
    my ( $file_id, $file_path, $file_name, $organism_id ) = @_;
    my $f = "$file_path/$file_name";

    my $in = Bio::SeqIO->new(
        -file   => $f,
        -format => 'ABI'
    );

    my $qual = $in->next_seq();

    my $primer_id = 1; # unknown primer
    my $out = $schema->resultset('Sequence')->create( 
        { 
            sequence_name => $file_name, 
            sequence => $qual->seq, 
            #sequence_primer => , 
            primer_id => 1,
            file_id => $file_id, 
            sequence_quality => $qual->qual_text ,
            organism_id => $organism_id,           
        }, 
    );

}

