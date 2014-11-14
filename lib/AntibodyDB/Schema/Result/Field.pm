use utf8;
package AntibodyDB::Schema::Result::Field;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Field

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<fields>

=cut

__PACKAGE__->table("fields");

=head1 ACCESSORS

=head2 field_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 field_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 field_long_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 field_desc

  data_type: 'text'
  is_nullable: 1

=head2 form_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 field_type_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 field_order

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "field_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "field_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "field_long_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "field_desc",
  { data_type => "text", is_nullable => 1 },
  "form_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "field_type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "field_order",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</field_id>

=back

=cut

__PACKAGE__->set_primary_key("field_id");

=head1 RELATIONS

=head2 field_type

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::FieldType>

=cut

__PACKAGE__->belongs_to(
  "field_type",
  "AntibodyDB::Schema::Result::FieldType",
  { field_type_id => "field_type_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "CASCADE" },
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:q36YC1oROOFND4XG6vYXCw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
