use utf8;
package AntibodyDB::Schema::Result::Assay;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Assay

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<assays>

=cut

__PACKAGE__->table("assays");

=head1 ACCESSORS

=head2 assay_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 study_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 assay_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 assay_type_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "assay_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "study_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "assay_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "assay_type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</assay_id>

=back

=cut

__PACKAGE__->set_primary_key("assay_id");

=head1 RELATIONS

=head2 analyses_has_assays

Type: has_many

Related object: L<AntibodyDB::Schema::Result::AnalysesHasAssay>

=cut

__PACKAGE__->has_many(
  "analyses_has_assays",
  "AntibodyDB::Schema::Result::AnalysesHasAssay",
  { "foreign.assay_id" => "self.assay_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assay_has_methods

Type: has_many

Related object: L<AntibodyDB::Schema::Result::AssayHasMethod>

=cut

__PACKAGE__->has_many(
  "assay_has_methods",
  "AntibodyDB::Schema::Result::AssayHasMethod",
  { "foreign.assay_id" => "self.assay_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assay_has_samples

Type: has_many

Related object: L<AntibodyDB::Schema::Result::AssayHasSample>

=cut

__PACKAGE__->has_many(
  "assay_has_samples",
  "AntibodyDB::Schema::Result::AssayHasSample",
  { "foreign.assay_id" => "self.assay_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assay_type

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::AssayType>

=cut

__PACKAGE__->belongs_to(
  "assay_type",
  "AntibodyDB::Schema::Result::AssayType",
  { assay_type_id => "assay_type_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "CASCADE" },
);

=head2 assays_has_forms

Type: has_many

Related object: L<AntibodyDB::Schema::Result::AssaysHasForm>

=cut

__PACKAGE__->has_many(
  "assays_has_forms",
  "AntibodyDB::Schema::Result::AssaysHasForm",
  { "foreign.assay_id" => "self.assay_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 files

Type: has_many

Related object: L<AntibodyDB::Schema::Result::File>

=cut

__PACKAGE__->has_many(
  "files",
  "AntibodyDB::Schema::Result::File",
  { "foreign.assay_id" => "self.assay_id" },
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

=head2 analyses

Type: many_to_many

Composing rels: L</analyses_has_assays> -> analysis

=cut

__PACKAGE__->many_to_many("analyses", "analyses_has_assays", "analysis");

=head2 forms

Type: many_to_many

Composing rels: L</assays_has_forms> -> form

=cut

__PACKAGE__->many_to_many("forms", "assays_has_forms", "form");

=head2 methods

Type: many_to_many

Composing rels: L</assay_has_methods> -> method

=cut

__PACKAGE__->many_to_many("methods", "assay_has_methods", "method");

=head2 samples

Type: many_to_many

Composing rels: L</assay_has_samples> -> sample

=cut

__PACKAGE__->many_to_many("samples", "assay_has_samples", "sample");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UcKtgn5+PEdPZGY2/gz+OQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
