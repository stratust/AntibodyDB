#!/usr/bin/env perl
use Moose;
use feature "say";
use FindBin;
use lib "$FindBin::Bin/../lib";
use AntibodyDB::Schema;
use File::Basename;
use Data::Printer;
use Digest::SHA qw(sha256_hex);

print "Connecting into database...\n";
my $schema = AntibodyDB::Schema->connect(
    'dbi:mysql:dbname=biomanager',
    'root',
    '',
);


print "Populating table: files..\n";
&populate_file_mouse;
&populate_file_human;


sub populate_file_human {
    my $path = "/data_beta/toliveira/trace/human";

    # Code Here
    my @files = glob quotemeta($path) . "/*.ab1";

    my $sha = Digest::SHA->new(256);
    #my @seqs;
    my @rows;
    my @cols = (qw/file_name file_path file_desc file_sha256 file_type_id user_id assay_id organism_id/);
    foreach my $f (@files) {
        my @row;
        my ( $filename, $directories, $suffix ) = fileparse($f);
        say $filename;
        my $digest = $sha->addfile($f)->hexdigest;
        my $file = $schema->resultset('File')->find({file_sha256 => $digest});
        
        if ($file) {
            if ( $file->file_name ne $filename ) {
                # Search in alias;
                my $f_alias_rs = $schema->resultset('FileAlias');
                my $alias = $f_alias_rs->find( { file_alias_name => $filename , file_id => $file->id} );
                unless ($alias){
                    my $new_alias= $f_alias_rs->create(
                        {
                            file_alias_name => $filename,
                            file_alias_path => $path,
                            file_id => $file->id,
                        }
                    );
                }
                next;
            }
            else {
                next;
            }
        }


        my $organism_id =1;
        my $assay_id = 2;
        if ( $filename =~ /R18/ ) {
            my $rs = $schema->resultset('Individual')
                ->search( { individual_name => { 'like' => 'R18' } } );
            my $ind    = $rs->first;
            my $sample = $ind->samples->first;
            my $assay  = $sample->assays->first;
            $assay_id = $assay->id;
        }
        if ( $filename =~ /R1/ ) {
            my $rs = $schema->resultset('Individual')
                ->search( { individual_name => 'R1'  } );
            my $ind    = $rs->first;
            my $sample = $ind->samples->first;
            my $assay  = $sample->assays->first;
            $assay_id = $assay->id;
        }


        @row = ($filename,$path,$filename,$digest,1,1,$assay_id,$organism_id);
        my %hash;
        @hash{@cols} = @row;
        my $new_file = $schema->resultset('File')->create(\%hash);
 
    }
     
}

sub populate_file_mouse {
    my $path = "/data_beta/toliveira/trace/mouse";

    # Code Here
    my @files = glob quotemeta($path) . "/*.ab1";

    my $sha = Digest::SHA->new(256);
    #my @seqs;
    my @rows;
    my @cols = (qw/file_name file_path file_desc file_sha256 file_type_id user_id assay_id organism_id/);
    foreach my $f (@files) {
        my @row;
        my ( $filename, $directories, $suffix ) = fileparse($f);
        say $filename;
        my $digest = $sha->addfile($f)->hexdigest;
        my $file = $schema->resultset('File')->find({file_sha256 => $digest});
        
        if ($file) {
            if ( $file->file_name ne $filename ) {
                # Search in alias;
                my $f_alias_rs = $schema->resultset('FileAlias');
                my $alias = $f_alias_rs->find( { file_alias_name => $filename , file_id => $file->id} );
                unless ($alias){
                    my $new_alias= $f_alias_rs->create(
                        {
                            file_alias_name => $filename,
                            file_alias_path => $path,
                            file_id => $file->id,
                        }
                    );
                }
                next;
            }
            else {
                next;
            }
        }

        my $organism_id = 2;
        my $assay_id = 2;
        $assay_id = 3 if $filename =~ /^E11/;
    
        @row = ($filename,$path,$filename,$digest,1,1,$assay_id,$organism_id);
        my %hash;
        @hash{@cols} = @row;
        my $new_file = $schema->resultset('File')->create(\%hash);
 
    }
     
}


