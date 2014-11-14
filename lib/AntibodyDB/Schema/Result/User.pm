use utf8;
package AntibodyDB::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 25

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 25

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 active

  data_type: 'tinyint'
  default_value: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 25 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 25 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "active",
  { data_type => "tinyint", default_value => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id");

=head1 RELATIONS

=head2 analyses

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Analyse>

=cut

__PACKAGE__->has_many(
  "analyses",
  "AntibodyDB::Schema::Result::Analyse",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 analysis_types

Type: has_many

Related object: L<AntibodyDB::Schema::Result::AnalysisType>

=cut

__PACKAGE__->has_many(
  "analysis_types",
  "AntibodyDB::Schema::Result::AnalysisType",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assay_types

Type: has_many

Related object: L<AntibodyDB::Schema::Result::AssayType>

=cut

__PACKAGE__->has_many(
  "assay_types",
  "AntibodyDB::Schema::Result::AssayType",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assays

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Assay>

=cut

__PACKAGE__->has_many(
  "assays",
  "AntibodyDB::Schema::Result::Assay",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 files

Type: has_many

Related object: L<AntibodyDB::Schema::Result::File>

=cut

__PACKAGE__->has_many(
  "files",
  "AntibodyDB::Schema::Result::File",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 forms

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Form>

=cut

__PACKAGE__->has_many(
  "forms",
  "AntibodyDB::Schema::Result::Form",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 individuals

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Individual>

=cut

__PACKAGE__->has_many(
  "individuals",
  "AntibodyDB::Schema::Result::Individual",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 method_types

Type: has_many

Related object: L<AntibodyDB::Schema::Result::MethodType>

=cut

__PACKAGE__->has_many(
  "method_types",
  "AntibodyDB::Schema::Result::MethodType",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 methods

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Method>

=cut

__PACKAGE__->has_many(
  "methods",
  "AntibodyDB::Schema::Result::Method",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sample_types

Type: has_many

Related object: L<AntibodyDB::Schema::Result::SampleType>

=cut

__PACKAGE__->has_many(
  "sample_types",
  "AntibodyDB::Schema::Result::SampleType",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 samples

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Sample>

=cut

__PACKAGE__->has_many(
  "samples",
  "AntibodyDB::Schema::Result::Sample",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_has_roles

Type: has_many

Related object: L<AntibodyDB::Schema::Result::UserHasRole>

=cut

__PACKAGE__->has_many(
  "user_has_roles",
  "AntibodyDB::Schema::Result::UserHasRole",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_projects

Type: has_many

Related object: L<AntibodyDB::Schema::Result::UserProject>

=cut

__PACKAGE__->has_many(
  "user_projects",
  "AntibodyDB::Schema::Result::UserProject",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 projects

Type: many_to_many

Composing rels: L</user_projects> -> project

=cut

__PACKAGE__->many_to_many("projects", "user_projects", "project");

=head2 roles

Type: many_to_many

Composing rels: L</user_has_roles> -> role

=cut

__PACKAGE__->many_to_many("roles", "user_has_roles", "role");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:swTiWqIUUjVWoanFP+ObgA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
