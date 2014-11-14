use utf8;
package AntibodyDB::Schema::Result::AssaysHasForm;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::AssaysHasForm

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<assays_has_forms>

=cut

__PACKAGE__->table("assays_has_forms");

=head1 ACCESSORS

=head2 assay_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 form_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "assay_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "form_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</assay_id>

=item * L</form_id>

=back

=cut

__PACKAGE__->set_primary_key("assay_id", "form_id");

=head1 RELATIONS

=head2 assay

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Assay>

=cut

__PACKAGE__->belongs_to(
  "assay",
  "AntibodyDB::Schema::Result::Assay",
  { assay_id => "assay_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 form

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Form>

=cut

__PACKAGE__->belongs_to(
  "form",
  "AntibodyDB::Schema::Result::Form",
  { form_id => "form_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Lax90UuBmxQ7Cq8T4ImOuw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
