use utf8;
package AntibodyDB::Schema::Result::Study;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Study

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<studies>

=cut

__PACKAGE__->table("studies");

=head1 ACCESSORS

=head2 study_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 study_description

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "study_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "study_description",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</study_id>

=back

=cut

__PACKAGE__->set_primary_key("study_id");

=head1 RELATIONS

=head2 analyses

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Analyse>

=cut

__PACKAGE__->has_many(
  "analyses",
  "AntibodyDB::Schema::Result::Analyse",
  { "foreign.study_id" => "self.study_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assays

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Assay>

=cut

__PACKAGE__->has_many(
  "assays",
  "AntibodyDB::Schema::Result::Assay",
  { "foreign.study_id" => "self.study_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Project>

=cut

__PACKAGE__->belongs_to(
  "project",
  "AntibodyDB::Schema::Result::Project",
  { project_id => "project_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dMd34KyuUUa21O+NSIqoeA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
