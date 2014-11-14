use utf8;
package AntibodyDB::Schema::Result::Entry;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Entry

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<entries>

=cut

__PACKAGE__->table("entries");

=head1 ACCESSORS

=head2 id

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 data

  data_type: 'longblob'
  is_nullable: 0

=head2 class

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 root

  data_type: 'tinyint'
  is_nullable: 0

=head2 tied

  data_type: 'char'
  is_nullable: 1
  size: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "data",
  { data_type => "longblob", is_nullable => 0 },
  "class",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "root",
  { data_type => "tinyint", is_nullable => 0 },
  "tied",
  { data_type => "char", is_nullable => 1, size => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 gin_indexes

Type: has_many

Related object: L<AntibodyDB::Schema::Result::GinIndex>

=cut

__PACKAGE__->has_many(
  "gin_indexes",
  "AntibodyDB::Schema::Result::GinIndex",
  { "foreign.id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 putative_annotation

Type: might_have

Related object: L<AntibodyDB::Schema::Result::PutativeAnnotation>

=cut

__PACKAGE__->might_have(
  "putative_annotation",
  "AntibodyDB::Schema::Result::PutativeAnnotation",
  { "foreign.object_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2Otqt091mf7cRIb/Oy5AOA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
