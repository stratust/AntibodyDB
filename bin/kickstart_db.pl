#!/usr/bin/env perl
use Moose;
use FindBin;
use lib "$FindBin::Bin/../lib";
use AntibodyDB::Schema;
#use utf8::all;


print "Connecting into database...\n";
my $schema = AntibodyDB::Schema->connect(
    'dbi:mysql:dbname=biomanager',
    'root',
    '',
);

print "Deploying Schema into database...\n";
# Deploying the database
## Call the deploy method on the schema object:
$schema->deploy( {add_drop_table => 1} );
print "Deploy done!\n\n";

print "Populating essential tables...\n\n";

print "Populating table: users...\n";
&populate_users;

print "Populating table: roles...\n";
&populate_roles;

print "Populating table: user_has_roles...\n";
&populate_user_has_roles;

print "Populating table: organism...\n";
&populate_organism;

print "Populating table: individual...\n";
&populate_individual;

print "Populating table: sample_type...\n";
&populate_sample_type;

print "Populating table: sample...\n";
&populate_sample;

#------------
print "Populating table: project...\n";
&populate_project;

print "Populating table: study...\n";
&populate_study;

print "Populating table: assay_type...\n";
&populate_assay_type;

#print "Populating table: assay_method...\n";
#&populate_assay_method;

print "Populating table: assay..\n";
&populate_assay;

print "Populating table: assay_has_sample..\n";
&populate_assay_has_sample;

print "Populating table: tools..\n";
&populate_tool;

print "Populating table: tool_version..\n";
&populate_tool_version;

print "Populating table: file_type..\n";
&populate_file_type;

print "Populating table: primer..\n";
&populate_primer;

print "Populating table: chain_type..\n";
&populate_chain_type;

print "Populating table: analysis_type..\n";
&populate_analysis_type;

print "Populating table: analyse..\n";
&populate_analyse;




#print "Populating table: files..\n";
#&populate_files;


sub populate_users {

    # Populate Members
    my @users = (
        [ 1, 'Thiago Yukio Kikuchi Oliveira', '12345', 'toliveira@rockefeller.edu',       1 ],
        [ 2, 'Lotta von Boehmer',             '12345', 'lvonboehme@mail.rockefeller.edu', 1 ],
    );
    my @test = $schema->populate( 'User', [ [qw/ user_id name password email active /], @users, ] );
}

sub populate_roles {

    #Populate event member
    my @roles = ( 
        [ 1, "Administrator" ],
        [ 2, "Lab Member" ],
    );

    $schema->populate(
        'Role',
        [
            [
                qw/role_id role /
            ],
            @roles,
        ]
    );
}

sub populate_user_has_roles {

    #Populate event member
    my @user_roles = ( 
        [ 1, 1 ],
        [ 2, 2 ],
    );

    $schema->populate(
        'UserHasRole',
        [
            [
                qw/user_id role_id /
            ],
            @user_roles,
        ]
    );
}

sub populate_organism {
    my $table = "Organism";
    #Populate event member
    my @rows = ( 
        [ 1, "Human","Homo Sapiens" ],
        [ 2, "Mouse","Mus muscululs" ],
    );
    $schema->populate(
        $table,
        [
            [
                qw/organism_id organism_name organism_species /
            ],
            @rows,
        ]
    );
}

sub populate_individual {
    my $table = "Individual";
    #Populate event member
    my @rows = ( 
        [ 1, "R18",1,1 ],
        [ 2, "R1",1,1 ],
        [ 3, "Pia's mouse",1,2 ],
    );
    $schema->populate(
        $table,
        [
            [
                qw/individual_id individual_name user_id organism_id /
            ],
            @rows,
        ]
    );
}

sub populate_sample_type {
    my $table = "SampleType";
    my @rows = ( 
        [ 1, "Blood","Extracted blood",1 ],
        [ 2, "Spleen Cells","Cells extracted from spleen",1 ],
    );
    $schema->populate(
        $table,
        [
            [
                qw/sample_type_id sample_type sample_type_description user_id /
            ],
            @rows,
        ]
    );
}

sub populate_sample {
    my $table = "Sample";
    my @rows = (
        [ 1, "First Blood Extraction", 1, 1, 1 ],
        [ 2, "First Blood Extraction", 1, 2, 1 ],
        [ 3, "Experiment 7 - HCmut", 1, 3, 2 ],
        [ 4, "Experiment 7 - HCmutLCgl", 1, 3, 2 ],
        [ 5, "Experiment 11 - HCmut", 1, 3, 2 ],
        [ 6, "Experiment 11 - HCmutLCgl", 1, 3, 2 ],
        [ 7, "Experiment 13 - HCgl", 1, 3, 2 ],
        [ 8, "Experiment 13 - HCglLCgl", 1, 3, 2 ],
        [ 9, "Naive - HCgl", 1, 3, 2 ],
        [ 10, "Naive - HCglLCgl", 1, 3, 2 ],
        [ 11, "Naive - HCmut", 1, 3, 2 ],
        [ 12, "Naive - HCglLCgl", 1, 3, 2 ],
    );
    $schema->populate(
        $table,
        [
            [
                qw/sample_id sample_desc sample_type_id  individual_id user_id /
            ],
            @rows,
        ]
    );
}

sub populate_project {
    my $table = "Project";
    my @rows = (
        [ 1, "HIV Project", "HIV"],
        [ 2, "DNA damage Project", "DNA Damage" ],
    );
    $schema->populate(
        $table,
        [
            [
                qw/project_id project_name project_description/
            ],
            @rows,
        ]
    );
}

sub populate_study {
    my $table = "Study";
    my @rows = (
        [ 1, "Antibody Database", 1 ],
    );
    $schema->populate(
        $table,
        [
            [
                qw/study_id study_description project_id/
            ],
            @rows,
        ]
    );
}

sub populate_assay_type {
    my $table = "AssayType";
    my @rows = (
        [ 1, "Simple PCR", 1 ],
        [ 2, "TC-Seq", 1 ],
        [ 3, "VI-Seq", 1 ],
        [ 4, "RNA-Seq", 1 ],
        [ 5, "ChIP-Seq", 1 ],
    );
    $schema->populate(
        $table,
        [
            [
                qw/assay_type_id assay_type_name user_id/
            ],
            @rows,
        ]
    );
}

sub populate_assay {
    my $table = "Assay";
    my @rows = (
        [ 1, 1, "Human Antibody Screening", 1, 2 ],
        [ 2, 1, "Experiment 7", 1, 2 ],
        [ 3, 1, "Experiment 11", 1, 2 ],
    );
    $schema->populate(
        $table,
        [
            [
                qw/assay_id study_id assay_name assay_type_id user_id/
            ],
            @rows,
        ]
    );
}

sub populate_assay_has_sample {
    my $table = "AssayHasSample";
    my @rows = (
        [1, 1 ],
        [1, 2 ],
        [ 2, 3 ],
        [ 3, 4 ],
    );
    $schema->populate(
        $table,
        [
            [
                qw/assay_id sample_id/
            ],
            @rows,
        ]
    );
}

sub populate_tool {
    my $table = "Tool";
    my @rows = (
        [ 1, "IgBlastN", "Aligner for Ig nucleotide sequences" ],
        [ 2, "IgBlastP", "Aligner for Ig amino acid sequences" ],
    );
    $schema->populate(
        $table,
        [
            [
                qw/tool_id tool_name tool_desc/
            ],
            @rows,
        ]
    );
}

sub populate_tool_version {
    my $table = "ToolVersion";
    my @rows = (
        [ 1, 1,"1.2", "/work/bioinformatics/igblast/1.2.0/ncbi-igblast-1.2.0/bin/igblastn" ],
        [ 2, 2,"1.2", "/work/bioinformatics/igblast/1.2.0/ncbi-igblast-1.2.0/bin/igblastp" ],
    );
    $schema->populate(
        $table,
        [
            [
                qw/tool_version_id tool_id tool_version tool_version_path/
            ],
            @rows,
        ]
    );
}

sub populate_file_type {
    my $table = "FileType";
    my @rows = (
        [ 1, 'abi', "ABI trace"],
        [ 2, 'fastq', "Fastq file"],
        [ 3, 'fasta', "Fasta file"],
    );
    $schema->populate(
        $table,
        [
            [
                qw/file_type_id file_type_name file_type_desc/
            ],
            @rows,
        ]
    );
}

sub populate_primer {
    my $table = "Primer";
    my @rows = (
        [ 1, 'unknown', ""],
    );
    $schema->populate(
        $table,
        [
            [
                qw/primer_id primer_name primer_sequence/
            ],
            @rows,
        ]
    );
}

sub populate_chain_type {
    my $table = "ChainType";
    my @rows = (
        [ 1, 'unknown'],
        [ 2, 'heavy chain'],
        [ 3, 'kappa chain'],
        [ 4, 'lambda chain'],
    );
    $schema->populate(
        $table,
        [
            [
                qw/chain_type_id chain_type_name/
            ],
            @rows,
        ]
    );
}

sub populate_analysis_type {
    my $table = "AnalysisType";
    my @rows = (
        [ 1, 'Immunoglobulin type detection', 1],
    );
    $schema->populate(
        $table,
        [
            [
                qw/analysis_type_id analysis_type_name user_id/
            ],
            @rows,
        ]
    );
}

sub populate_analyse {
    my $table = "Analyse";
    my @rows = (
        [ 'Immunoglobulin chain analysis', 1, 1, 1],
    );
    $schema->populate(
        $table,
        [
            [
                qw/analysis_name analysis_type_id study_id user_id/
            ],
            @rows,
        ]
    );
}
