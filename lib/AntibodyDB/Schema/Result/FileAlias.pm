use utf8;
package AntibodyDB::Schema::Result::FileAlias;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::FileAlias

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<file_alias>

=cut

__PACKAGE__->table("file_alias");

=head1 ACCESSORS

=head2 file_alias_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 file_alias_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 file_alias_path

  data_type: 'text'
  is_nullable: 0

=head2 file_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "file_alias_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "file_alias_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "file_alias_path",
  { data_type => "text", is_nullable => 0 },
  "file_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</file_alias_id>

=back

=cut

__PACKAGE__->set_primary_key("file_alias_id");

=head1 RELATIONS

=head2 file

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::File>

=cut

__PACKAGE__->belongs_to(
  "file",
  "AntibodyDB::Schema::Result::File",
  { file_id => "file_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4L6eX+NjpoTuF6uWPvQhhg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
