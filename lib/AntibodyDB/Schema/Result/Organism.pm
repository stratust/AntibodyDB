use utf8;
package AntibodyDB::Schema::Result::Organism;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Organism

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<organism>

=cut

__PACKAGE__->table("organism");

=head1 ACCESSORS

=head2 organism_id

  data_type: 'integer'
  is_nullable: 0

=head2 organism_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 organism_species

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "organism_id",
  { data_type => "integer", is_nullable => 0 },
  "organism_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "organism_species",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</organism_id>

=back

=cut

__PACKAGE__->set_primary_key("organism_id");

=head1 RELATIONS

=head2 files

Type: has_many

Related object: L<AntibodyDB::Schema::Result::File>

=cut

__PACKAGE__->has_many(
  "files",
  "AntibodyDB::Schema::Result::File",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 igblast_params

Type: has_many

Related object: L<AntibodyDB::Schema::Result::IgblastParam>

=cut

__PACKAGE__->has_many(
  "igblast_params",
  "AntibodyDB::Schema::Result::IgblastParam",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 individuals

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Individual>

=cut

__PACKAGE__->has_many(
  "individuals",
  "AntibodyDB::Schema::Result::Individual",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 putative_annotations

Type: has_many

Related object: L<AntibodyDB::Schema::Result::PutativeAnnotation>

=cut

__PACKAGE__->has_many(
  "putative_annotations",
  "AntibodyDB::Schema::Result::PutativeAnnotation",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sequences

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Sequence>

=cut

__PACKAGE__->has_many(
  "sequences",
  "AntibodyDB::Schema::Result::Sequence",
  { "foreign.organism_id" => "self.organism_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mAatnS3laLrREw30AvoEeQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
