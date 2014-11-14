use utf8;
package AntibodyDB::Schema::Result::Sample;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Sample

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<samples>

=cut

__PACKAGE__->table("samples");

=head1 ACCESSORS

=head2 sample_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 sample_desc

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 sample_type_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 individual_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "sample_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "sample_desc",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "sample_type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "individual_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</sample_id>

=back

=cut

__PACKAGE__->set_primary_key("sample_id");

=head1 RELATIONS

=head2 assay_has_samples

Type: has_many

Related object: L<AntibodyDB::Schema::Result::AssayHasSample>

=cut

__PACKAGE__->has_many(
  "assay_has_samples",
  "AntibodyDB::Schema::Result::AssayHasSample",
  { "foreign.sample_id" => "self.sample_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 individual

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Individual>

=cut

__PACKAGE__->belongs_to(
  "individual",
  "AntibodyDB::Schema::Result::Individual",
  { individual_id => "individual_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "CASCADE" },
);

=head2 sample_type

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::SampleType>

=cut

__PACKAGE__->belongs_to(
  "sample_type",
  "AntibodyDB::Schema::Result::SampleType",
  { sample_type_id => "sample_type_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 samples_has_forms

Type: has_many

Related object: L<AntibodyDB::Schema::Result::SamplesHasForm>

=cut

__PACKAGE__->has_many(
  "samples_has_forms",
  "AntibodyDB::Schema::Result::SamplesHasForm",
  { "foreign.sample_id" => "self.sample_id" },
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

Composing rels: L</assay_has_samples> -> assay

=cut

__PACKAGE__->many_to_many("assays", "assay_has_samples", "assay");

=head2 forms

Type: many_to_many

Composing rels: L</samples_has_forms> -> form

=cut

__PACKAGE__->many_to_many("forms", "samples_has_forms", "form");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dRzH9fZksBitOLitzkzyeg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
