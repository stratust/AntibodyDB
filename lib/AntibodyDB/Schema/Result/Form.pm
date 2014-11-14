use utf8;
package AntibodyDB::Schema::Result::Form;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Form

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<forms>

=cut

__PACKAGE__->table("forms");

=head1 ACCESSORS

=head2 form_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 form_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 public_form

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 form_type_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "form_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "form_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "public_form",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "form_type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</form_id>

=back

=cut

__PACKAGE__->set_primary_key("form_id");

=head1 RELATIONS

=head2 assays_has_forms

Type: has_many

Related object: L<AntibodyDB::Schema::Result::AssaysHasForm>

=cut

__PACKAGE__->has_many(
  "assays_has_forms",
  "AntibodyDB::Schema::Result::AssaysHasForm",
  { "foreign.form_id" => "self.form_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 fields

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Field>

=cut

__PACKAGE__->has_many(
  "fields",
  "AntibodyDB::Schema::Result::Field",
  { "foreign.form_id" => "self.form_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 form_type

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::FormType>

=cut

__PACKAGE__->belongs_to(
  "form_type",
  "AntibodyDB::Schema::Result::FormType",
  { form_type_id => "form_type_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "CASCADE" },
);

=head2 individuals_has_forms

Type: has_many

Related object: L<AntibodyDB::Schema::Result::IndividualsHasForm>

=cut

__PACKAGE__->has_many(
  "individuals_has_forms",
  "AntibodyDB::Schema::Result::IndividualsHasForm",
  { "foreign.form_id" => "self.form_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 projects_has_forms

Type: has_many

Related object: L<AntibodyDB::Schema::Result::ProjectsHasForm>

=cut

__PACKAGE__->has_many(
  "projects_has_forms",
  "AntibodyDB::Schema::Result::ProjectsHasForm",
  { "foreign.form_id" => "self.form_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 samples_has_forms

Type: has_many

Related object: L<AntibodyDB::Schema::Result::SamplesHasForm>

=cut

__PACKAGE__->has_many(
  "samples_has_forms",
  "AntibodyDB::Schema::Result::SamplesHasForm",
  { "foreign.form_id" => "self.form_id" },
  { cascade_copy => 0, cascade_delete => 0 },
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

=head2 assays

Type: many_to_many

Composing rels: L</assays_has_forms> -> assay

=cut

__PACKAGE__->many_to_many("assays", "assays_has_forms", "assay");

=head2 individuals

Type: many_to_many

Composing rels: L</individuals_has_forms> -> individual

=cut

__PACKAGE__->many_to_many("individuals", "individuals_has_forms", "individual");

=head2 projects

Type: many_to_many

Composing rels: L</projects_has_forms> -> project

=cut

__PACKAGE__->many_to_many("projects", "projects_has_forms", "project");

=head2 samples

Type: many_to_many

Composing rels: L</samples_has_forms> -> sample

=cut

__PACKAGE__->many_to_many("samples", "samples_has_forms", "sample");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HpZSnbJlvjRDOE49ESmUVw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
