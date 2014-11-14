use utf8;
package AntibodyDB::Schema::Result::File;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::File

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<files>

=cut

__PACKAGE__->table("files");

=head1 ACCESSORS

=head2 file_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 file_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 file_path

  data_type: 'text'
  is_nullable: 0

=head2 file_desc

  data_type: 'text'
  is_nullable: 1

=head2 file_sha256

  data_type: 'varchar'
  is_nullable: 0
  size: 64

=head2 file_type_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 assay_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 organism_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 trash

  data_type: 'tinyint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "file_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "file_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "file_path",
  { data_type => "text", is_nullable => 0 },
  "file_desc",
  { data_type => "text", is_nullable => 1 },
  "file_sha256",
  { data_type => "varchar", is_nullable => 0, size => 64 },
  "file_type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "assay_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "organism_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "trash",
  { data_type => "tinyint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</file_id>

=back

=cut

__PACKAGE__->set_primary_key("file_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<file_sha256_UNIQUE>

=over 4

=item * L</file_sha256>

=back

=cut

__PACKAGE__->add_unique_constraint("file_sha256_UNIQUE", ["file_sha256"]);

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

=head2 file_aliases

Type: has_many

Related object: L<AntibodyDB::Schema::Result::FileAlias>

=cut

__PACKAGE__->has_many(
  "file_aliases",
  "AntibodyDB::Schema::Result::FileAlias",
  { "foreign.file_id" => "self.file_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 file_type

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::FileType>

=cut

__PACKAGE__->belongs_to(
  "file_type",
  "AntibodyDB::Schema::Result::FileType",
  { file_type_id => "file_type_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "CASCADE" },
);

=head2 organism

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Organism>

=cut

__PACKAGE__->belongs_to(
  "organism",
  "AntibodyDB::Schema::Result::Organism",
  { organism_id => "organism_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 sequences

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Sequence>

=cut

__PACKAGE__->has_many(
  "sequences",
  "AntibodyDB::Schema::Result::Sequence",
  { "foreign.file_id" => "self.file_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XHWI82hfDxc15sSHmecMzg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
