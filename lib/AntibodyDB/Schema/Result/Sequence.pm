use utf8;
package AntibodyDB::Schema::Result::Sequence;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Sequence

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<sequence>

=cut

__PACKAGE__->table("sequence");

=head1 ACCESSORS

=head2 sequence_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 sequence_name

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 sequence

  accessor: undef
  data_type: 'text'
  is_nullable: 1

=head2 file_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 primer_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 sequence_quality

  data_type: 'text'
  is_nullable: 1

=head2 organism_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "sequence_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "sequence_name",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "sequence",
  { accessor => undef, data_type => "text", is_nullable => 1 },
  "file_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "primer_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "sequence_quality",
  { data_type => "text", is_nullable => 1 },
  "organism_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</sequence_id>

=back

=cut

__PACKAGE__->set_primary_key("sequence_id");

=head1 RELATIONS

=head2 file

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::File>

=cut

__PACKAGE__->belongs_to(
  "file",
  "AntibodyDB::Schema::Result::File",
  { file_id => "file_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
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

=head2 primer

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Primer>

=cut

__PACKAGE__->belongs_to(
  "primer",
  "AntibodyDB::Schema::Result::Primer",
  { primer_id => "primer_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 putative_annotations

Type: has_many

Related object: L<AntibodyDB::Schema::Result::PutativeAnnotation>

=cut

__PACKAGE__->has_many(
  "putative_annotations",
  "AntibodyDB::Schema::Result::PutativeAnnotation",
  { "foreign.sequence_id" => "self.sequence_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sequence_has_sequence_heavy_files

Type: has_many

Related object: L<AntibodyDB::Schema::Result::SequenceHasSequence>

=cut

__PACKAGE__->has_many(
  "sequence_has_sequence_heavy_files",
  "AntibodyDB::Schema::Result::SequenceHasSequence",
  { "foreign.heavy_file_id" => "self.sequence_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sequence_has_sequence_light_files

Type: has_many

Related object: L<AntibodyDB::Schema::Result::SequenceHasSequence>

=cut

__PACKAGE__->has_many(
  "sequence_has_sequence_light_files",
  "AntibodyDB::Schema::Result::SequenceHasSequence",
  { "foreign.light_file_id" => "self.sequence_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 heavy_files

Type: many_to_many

Composing rels: L</sequence_has_sequence_light_files> -> heavy_file

=cut

__PACKAGE__->many_to_many(
  "heavy_files",
  "sequence_has_sequence_light_files",
  "heavy_file",
);

=head2 light_files

Type: many_to_many

Composing rels: L</sequence_has_sequence_heavy_files> -> light_file

=cut

__PACKAGE__->many_to_many(
  "light_files",
  "sequence_has_sequence_heavy_files",
  "light_file",
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Kitasn+eg9OY+OfARkhg4A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
