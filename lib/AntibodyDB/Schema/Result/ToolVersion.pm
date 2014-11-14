use utf8;
package AntibodyDB::Schema::Result::ToolVersion;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::ToolVersion

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tool_versions>

=cut

__PACKAGE__->table("tool_versions");

=head1 ACCESSORS

=head2 tool_version_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 tool_version

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 tool_version_path

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 tool_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "tool_version_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "tool_version",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "tool_version_path",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "tool_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</tool_version_id>

=back

=cut

__PACKAGE__->set_primary_key("tool_version_id");

=head1 RELATIONS

=head2 igblast_params

Type: has_many

Related object: L<AntibodyDB::Schema::Result::IgblastParam>

=cut

__PACKAGE__->has_many(
  "igblast_params",
  "AntibodyDB::Schema::Result::IgblastParam",
  { "foreign.tool_version_id" => "self.tool_version_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tool

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Tool>

=cut

__PACKAGE__->belongs_to(
  "tool",
  "AntibodyDB::Schema::Result::Tool",
  { tool_id => "tool_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "CASCADE" },
);

=head2 workflow_steps

Type: has_many

Related object: L<AntibodyDB::Schema::Result::WorkflowStep>

=cut

__PACKAGE__->has_many(
  "workflow_steps",
  "AntibodyDB::Schema::Result::WorkflowStep",
  { "foreign.tool_version_id" => "self.tool_version_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7Aqx/reBxM3FORygdkTf6A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
