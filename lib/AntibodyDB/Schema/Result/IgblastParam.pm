use utf8;
package AntibodyDB::Schema::Result::IgblastParam;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::IgblastParam

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<igblast_param>

=cut

__PACKAGE__->table("igblast_param");

=head1 ACCESSORS

=head2 organism_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 analysis_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 tool_version_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 igblast_param_v_database

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 igblast_param_d_database

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 igblast_param_j_database

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 igblast_param_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 igblast_param_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 igblast_param_auxiliary_data

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 igblast_param_desc

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 igblast_param_is_knockin

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "organism_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "analysis_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "tool_version_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "igblast_param_v_database",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "igblast_param_d_database",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "igblast_param_j_database",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "igblast_param_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "igblast_param_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "igblast_param_auxiliary_data",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "igblast_param_desc",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "igblast_param_is_knockin",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</organism_id>

=item * L</analysis_id>

=item * L</tool_version_id>

=back

=cut

__PACKAGE__->set_primary_key("organism_id", "analysis_id", "tool_version_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<igblast_param_id_UNIQUE>

=over 4

=item * L</igblast_param_id>

=back

=cut

__PACKAGE__->add_unique_constraint("igblast_param_id_UNIQUE", ["igblast_param_id"]);

=head1 RELATIONS

=head2 analysis

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Analyse>

=cut

__PACKAGE__->belongs_to(
  "analysis",
  "AntibodyDB::Schema::Result::Analyse",
  { analysis_id => "analysis_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 organism

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Organism>

=cut

__PACKAGE__->belongs_to(
  "organism",
  "AntibodyDB::Schema::Result::Organism",
  { organism_id => "organism_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 putative_annotations

Type: has_many

Related object: L<AntibodyDB::Schema::Result::PutativeAnnotation>

=cut

__PACKAGE__->has_many(
  "putative_annotations",
  "AntibodyDB::Schema::Result::PutativeAnnotation",
  { "foreign.igblast_param_id" => "self.igblast_param_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tool_version

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::ToolVersion>

=cut

__PACKAGE__->belongs_to(
  "tool_version",
  "AntibodyDB::Schema::Result::ToolVersion",
  { tool_version_id => "tool_version_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-10 11:15:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7EqmWLGBs5X2MNle+hR2gQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
