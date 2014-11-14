use utf8;
package AntibodyDB::Schema::Result::ReadInfoHasPosition;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::ReadInfoHasPosition

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<read_info_has_position>

=cut

__PACKAGE__->table("read_info_has_position");

=head1 ACCESSORS

=head2 read_type_id

  data_type: 'integer'
  is_nullable: 0

=head2 read_id

  data_type: 'bigint'
  is_nullable: 0

=head2 start_pos

  data_type: 'integer'
  is_nullable: 0

=head2 end_pos

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "read_type_id",
  { data_type => "integer", is_nullable => 0 },
  "read_id",
  { data_type => "bigint", is_nullable => 0 },
  "start_pos",
  { data_type => "integer", is_nullable => 0 },
  "end_pos",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</read_type_id>

=item * L</read_id>

=item * L</start_pos>

=item * L</end_pos>

=back

=cut

__PACKAGE__->set_primary_key("read_type_id", "read_id", "start_pos", "end_pos");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KQxha9hfPkJJFEqCKxPUIw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
