#!/usr/bin/env perl
use Moose;
use feature "say";
use FindBin;
use lib "$FindBin::Bin/../lib";
use AntibodyDB::Schema;
use File::Basename;
use Data::Printer class => { expand => 'all' };
use File::Temp;
use KiokuDB;

print "Connecting into database...\n";
my $schema = AntibodyDB::Schema->connect( 'dbi:mysql:dbname=biomanager', 'root', '', );
my $dir = KiokuDB->connect( 'dbi:mysql:dbname=biomanager', user => 'root', password => '',);

our $igblast_param_id;
our $organism_id;

my $organism = "human";

my $seq = $schema->resultset('PutativeAnnotation')->first;

my $scope = $dir->new_scope;
my $feat = $dir->lookup($seq->object_id);

p $feat;
