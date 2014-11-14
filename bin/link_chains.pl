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
use Spreadsheet::Read;

print "Connecting into database...\n";
my $schema = AntibodyDB::Schema->connect( 'dbi:mysql:dbname=biomanager', 'root', '', );
my $dir = KiokuDB->connect( 'dbi:mysql:dbname=biomanager', user => 'root', password => '',);

my $book  = ReadData (shift);

my $n_sheets = $book->[0]->{sheets};
my $seq_rs = $schema->resultset('Sequence')->search({},{ join => { file => 'file_aliases' }});
for my $s (1.. $n_sheets){
    my $this = $book->[$s];
    my $heavy = $this->{cell}->[2];
    my $light = $this->{cell}->[4];
    my %links;
    if (scalar @{$heavy} == scalar @{$light}){
        %links = map { $heavy->[$_] => $light->[$_] } 3 .. $#{$heavy};
    }
    else{
        die "Heavy and Light chains columns have different length at sheet $s !";
    }
    
    foreach my $heavy (sort {$a cmp $b} keys %links) {

        my $h = $seq_rs->search( { -or => [  sequence_name => $heavy , file_alias_name => $heavy ] } )->first;
        my $l = $seq_rs->search( { -or => [  sequence_name => $links{$heavy} , file_alias_name => $links{$heavy} ] } )->first;

        if ( $l && $h ) {
            say join " => ", ( $h->sequence_name, $l->sequence_name );
            
            my $rs = $schema->resultset('SequenceHasSequence');
            my $find = $rs->find($h->id,$l->id);
            next if $find;
            my $item = $rs->create({
                    heavy_file_id => $h->id,
                    light_file_id => $l->id,
                });
        }
        else {
            die $heavy;
        }
    }
}

