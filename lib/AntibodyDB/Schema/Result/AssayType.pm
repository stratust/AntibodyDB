use utf8;
package AntibodyDB::Schema::Result::AssayType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::AssayType

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<assay_types>

=cut

__PACKAGE__->table("assay_types");

=head1 ACCESSORS

=head2 assay_type_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 assay_type_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "assay_type_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "assay_type_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</assay_type_id>

=back

=cut

__PACKAGE__->set_primary_key("assay_type_id");

=head1 RELATIONS

=head2 assays

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Assay>

=cut

__PACKAGE__->has_many(
  "assays",
  "AntibodyDB::Schema::Result::Assay",
  { "foreign.assay_type_id" => "self.assay_type_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gmAJy4XhlhtS2QYCVbLKqg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
