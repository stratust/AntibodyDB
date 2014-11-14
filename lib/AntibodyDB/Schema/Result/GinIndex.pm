use utf8;
package AntibodyDB::Schema::Result::GinIndex;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::GinIndex

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<gin_index>

=cut

__PACKAGE__->table("gin_index");

=head1 ACCESSORS

=head2 id

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 255

=head2 value

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 255 },
  "value",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 RELATIONS

=head2 id

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Entry>

=cut

__PACKAGE__->belongs_to(
  "id",
  "AntibodyDB::Schema::Result::Entry",
  { id => "id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nl1yN7oAKCJTBB5TVLXYoA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
