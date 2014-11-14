use utf8;
package AntibodyDB::Schema::Result::Analyse;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Analyse

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<analyses>

=cut

__PACKAGE__->table("analyses");

=head1 ACCESSORS

=head2 analysis_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 analysis_name

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 analysis_type_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 study_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "analysis_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "analysis_name",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "analysis_type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "study_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</analysis_id>

=back

=cut

__PACKAGE__->set_primary_key("analysis_id");

=head1 RELATIONS

=head2 analyses_has_assays

Type: has_many

Related object: L<AntibodyDB::Schema::Result::AnalysesHasAssay>

=cut

__PACKAGE__->has_many(
  "analyses_has_assays",
  "AntibodyDB::Schema::Result::AnalysesHasAssay",
  { "foreign.analysis_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analyses_has_methods

Type: has_many

Related object: L<AntibodyDB::Schema::Result::AnalysesHasMethod>

=cut

__PACKAGE__->has_many(
  "analyses_has_methods",
  "AntibodyDB::Schema::Result::AnalysesHasMethod",
  { "foreign.analysis_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysis_type

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::AnalysisType>

=cut

__PACKAGE__->belongs_to(
  "analysis_type",
  "AntibodyDB::Schema::Result::AnalysisType",
  { analysis_type_id => "analysis_type_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "CASCADE" },
);

=head2 igblast_params

Type: has_many

Related object: L<AntibodyDB::Schema::Result::IgblastParam>

=cut

__PACKAGE__->has_many(
  "igblast_params",
  "AntibodyDB::Schema::Result::IgblastParam",
  { "foreign.analysis_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 study

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Study>

=cut

__PACKAGE__->belongs_to(
  "study",
  "AntibodyDB::Schema::Result::Study",
  { study_id => "study_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "CASCADE" },
);

=head2 user

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "AntibodyDB::Schema::Result::User",
  { user_id => "user_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "CASCADE" },
);

=head2 workflow_steps

Type: has_many

Related object: L<AntibodyDB::Schema::Result::WorkflowStep>

=cut

__PACKAGE__->has_many(
  "workflow_steps",
  "AntibodyDB::Schema::Result::WorkflowStep",
  { "foreign.analysis_id" => "self.analysis_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assays

Type: many_to_many

Composing rels: L</analyses_has_assays> -> assay

=cut

__PACKAGE__->many_to_many("assays", "analyses_has_assays", "assay");

=head2 methods

Type: many_to_many

Composing rels: L</analyses_has_methods> -> method

=cut

__PACKAGE__->many_to_many("methods", "analyses_has_methods", "method");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:m6s8APi6Wnly8E7Vg1otlw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
