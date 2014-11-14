use utf8;
package AntibodyDB::Schema::Result::FieldType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::FieldType

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<field_types>

=cut

__PACKAGE__->table("field_types");

=head1 ACCESSORS

=head2 field_type_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 field_type

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "field_type_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "field_type",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</field_type_id>

=back

=cut

__PACKAGE__->set_primary_key("field_type_id");

=head1 RELATIONS

=head2 fields

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Field>

=cut

__PACKAGE__->has_many(
  "fields",
  "AntibodyDB::Schema::Result::Field",
  { "foreign.field_type_id" => "self.field_type_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Bag6ephk+9axHoR7Jwe/hg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
