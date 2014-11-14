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

print "Populating essential tables...\n\n";

print "Populating table: igblast_param..\n";
&populate_igblast_param;




#print "Populating table: files..\n";
#&populate_files;



sub populate_igblast_param {
    my $table = "IgblastParam";
    my @rows = (
        [   1,                                                     #organism_id (human)
            1,                                                     #analysis_id
            1,                                                     #tool_version_id
            '/work/bioinformatics/igblast/database/human_gl_V',    #igblast_param_v_database
            '/work/bioinformatics/igblast/database/human_gl_D',    #igblast_param_d_database
            '/work/bioinformatics/igblast/database/human_gl_J',    #igblast_param_j_database
            '/work/bioinformatics/igblast/optional_file/human_gl.aux',    #igblast_param_auxiliary_data
            1,                                                     #igblast_param_id
            'IgBlastN agaisnt human germline',                     #igblast_param_name
        ],
        [   2,                                                     #organism_id (mouse)
            1,                                                     #analysis_id
            1,                                                     #tool_version_id
            '/work/bioinformatics/igblast/imgt/database/mouse_gl_V',    #igblast_param_v_database
            '/work/bioinformatics/igblast/imgt/database/mouse_gl_D',    #igblast_param_d_database
            '/work/bioinformatics/igblast/imgt/database/mouse_gl_J',    #igblast_param_j_database
            '/work/bioinformatics/igblast/optional_file/mouse_gl.aux',    #igblast_param_auxiliary_data
            2,                                                     #igblast_param_id
            'IgBlastN agaisnt mouse germline',                     #igblast_param_name
        ],

    );
    $schema->populate(
        $table,
        [
            [
                qw/organism_id analysis_id tool_version_id igblast_param_v_database igblast_param_d_database igblast_param_j_database igblast_param_auxiliary_data igblast_param_id igblast_param_name/
            ],
            @rows,
        ]
    );
}
