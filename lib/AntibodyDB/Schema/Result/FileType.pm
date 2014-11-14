use utf8;
package AntibodyDB::Schema::Result::FileType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::FileType

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<file_types>

=cut

__PACKAGE__->table("file_types");

=head1 ACCESSORS

=head2 file_type_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 file_type_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 file_type_desc

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "file_type_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "file_type_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "file_type_desc",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</file_type_id>

=back

=cut

__PACKAGE__->set_primary_key("file_type_id");

=head1 RELATIONS

=head2 files

Type: has_many

Related object: L<AntibodyDB::Schema::Result::File>

=cut

__PACKAGE__->has_many(
  "files",
  "AntibodyDB::Schema::Result::File",
  { "foreign.file_type_id" => "self.file_type_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CgdXq/eeg4HszxrAlhWuwg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
