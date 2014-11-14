use utf8;
package AntibodyDB::Schema::Result::WorkflowStep;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::WorkflowStep

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<workflow_steps>

=cut

__PACKAGE__->table("workflow_steps");

=head1 ACCESSORS

=head2 workflow_step_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 tool_version_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 analysis_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "workflow_step_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "tool_version_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "analysis_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</workflow_step_id>

=back

=cut

__PACKAGE__->set_primary_key("workflow_step_id");

=head1 RELATIONS

=head2 analysis

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Analyse>

=cut

__PACKAGE__->belongs_to(
  "analysis",
  "AntibodyDB::Schema::Result::Analyse",
  { analysis_id => "analysis_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "CASCADE" },
);

=head2 tool_version

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::ToolVersion>

=cut

__PACKAGE__->belongs_to(
  "tool_version",
  "AntibodyDB::Schema::Result::ToolVersion",
  { tool_version_id => "tool_version_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7EjG6ue/LAISm4DyJvlDaQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
