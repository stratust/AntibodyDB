use utf8;
package AntibodyDB::Schema::Result::PutativeAnnotation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::PutativeAnnotation

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<putative_annotation>

=cut

__PACKAGE__->table("putative_annotation");

=head1 ACCESSORS

=head2 putative_annotation_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 chain_type_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 igblast_param_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 putative_annotation_productive

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=head2 putative_annotation_stop_codon

  data_type: 'tinyint'
  is_nullable: 1

=head2 putative_annotation_best_v

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_best_d

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_best_j

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_fwr1

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_cdr1

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_fwr2

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_cdr2

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_fwr3

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_putative_cdr3

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_fwr1_aa

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_cdr1_aa

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_fwr2_aa

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_cdr2_aa

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_fwr3_aa

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_putative_cdr3_aa

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 putative_annotation_fwr1_mismatches

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_fwr1_mismatches_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_fwr1_insertions_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_fwr1_deletions_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_fwr1_gaps

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_cdr1_mismatches

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_cdr1_mismatches_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_cdr1_insertions_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_cdr1_deletions_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_cdr1_gaps

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_fwr2_mismatches

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_fwr2_mismatches_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_fwr2_insertions_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_fwr2_deletions_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_fwr2_gaps

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_cdr2_mismatches

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_cdr2_mismatches_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_cdr2_insertions_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_cdr2_deletions_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_cdr2_gaps

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_fwr3_mismatches

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_fwr3_mismatches_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_fwr3_insertions_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_fwr3_deletions_aa

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_fwr3_gaps

  data_type: 'integer'
  is_nullable: 1

=head2 putative_annotation_seq_nt

  data_type: 'text'
  is_nullable: 1

=head2 putative_annotation_seq_aa

  data_type: 'text'
  is_nullable: 1

=head2 object_id

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 255

=head2 sequence_id

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 organism_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 putative_annotation_is_reliable

  data_type: 'tinyint'
  is_nullable: 0

=head2 putative_annotation_is_complete

  data_type: 'tinyint'
  is_nullable: 0

=head2 putative_annotation_is_almost_perfect

  data_type: 'tinyint'
  is_nullable: 0

=head2 putative_annotation_is_perfect

  data_type: 'tinyint'
  is_nullable: 0

=head2 putative_annotation_has_mismatches

  data_type: 'tinyint'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "putative_annotation_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "chain_type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "igblast_param_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "putative_annotation_productive",
  { data_type => "varchar", is_nullable => 1, size => 45 },
  "putative_annotation_stop_codon",
  { data_type => "tinyint", is_nullable => 1 },
  "putative_annotation_best_v",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_best_d",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_best_j",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_fwr1",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_cdr1",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_fwr2",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_cdr2",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_fwr3",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_putative_cdr3",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_fwr1_aa",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_cdr1_aa",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_fwr2_aa",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_cdr2_aa",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_fwr3_aa",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_putative_cdr3_aa",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "putative_annotation_fwr1_mismatches",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_fwr1_mismatches_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_fwr1_insertions_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_fwr1_deletions_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_fwr1_gaps",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_cdr1_mismatches",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_cdr1_mismatches_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_cdr1_insertions_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_cdr1_deletions_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_cdr1_gaps",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_fwr2_mismatches",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_fwr2_mismatches_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_fwr2_insertions_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_fwr2_deletions_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_fwr2_gaps",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_cdr2_mismatches",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_cdr2_mismatches_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_cdr2_insertions_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_cdr2_deletions_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_cdr2_gaps",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_fwr3_mismatches",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_fwr3_mismatches_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_fwr3_insertions_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_fwr3_deletions_aa",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_fwr3_gaps",
  { data_type => "integer", is_nullable => 1 },
  "putative_annotation_seq_nt",
  { data_type => "text", is_nullable => 1 },
  "putative_annotation_seq_aa",
  { data_type => "text", is_nullable => 1 },
  "object_id",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 255 },
  "sequence_id",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "organism_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "putative_annotation_is_reliable",
  { data_type => "tinyint", is_nullable => 0 },
  "putative_annotation_is_complete",
  { data_type => "tinyint", is_nullable => 0 },
  "putative_annotation_is_almost_perfect",
  { data_type => "tinyint", is_nullable => 0 },
  "putative_annotation_is_perfect",
  { data_type => "tinyint", is_nullable => 0 },
  "putative_annotation_has_mismatches",
  { data_type => "tinyint", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</sequence_id>

=item * L</organism_id>

=back

=cut

__PACKAGE__->set_primary_key("sequence_id", "organism_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<object_id_UNIQUE>

=over 4

=item * L</object_id>

=back

=cut

__PACKAGE__->add_unique_constraint("object_id_UNIQUE", ["object_id"]);

=head2 C<putative_annotation_id_UNIQUE>

=over 4

=item * L</putative_annotation_id>

=back

=cut

__PACKAGE__->add_unique_constraint("putative_annotation_id_UNIQUE", ["putative_annotation_id"]);

=head1 RELATIONS

=head2 chain_type

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::ChainType>

=cut

__PACKAGE__->belongs_to(
  "chain_type",
  "AntibodyDB::Schema::Result::ChainType",
  { chain_type_id => "chain_type_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 cluster_has_putative_annotations

Type: has_many

Related object: L<AntibodyDB::Schema::Result::ClusterHasPutativeAnnotation>

=cut

__PACKAGE__->has_many(
  "cluster_has_putative_annotations",
  "AntibodyDB::Schema::Result::ClusterHasPutativeAnnotation",
  {
    "foreign.organism_id" => "self.organism_id",
    "foreign.sequence_id" => "self.sequence_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 igblast_param

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::IgblastParam>

=cut

__PACKAGE__->belongs_to(
  "igblast_param",
  "AntibodyDB::Schema::Result::IgblastParam",
  { igblast_param_id => "igblast_param_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 object

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Entry>

=cut

__PACKAGE__->belongs_to(
  "object",
  "AntibodyDB::Schema::Result::Entry",
  { id => "object_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
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

=head2 putative_annotation_has_to_clusters

Type: has_many

Related object: L<AntibodyDB::Schema::Result::PutativeAnnotationHasToCluster>

=cut

__PACKAGE__->has_many(
  "putative_annotation_has_to_clusters",
  "AntibodyDB::Schema::Result::PutativeAnnotationHasToCluster",
  {
    "foreign.organism_id" => "self.organism_id",
    "foreign.sequence_id" => "self.sequence_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 sequence_rel

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Sequence>

=cut

__PACKAGE__->belongs_to(
  "sequence_rel",
  "AntibodyDB::Schema::Result::Sequence",
  { sequence_id => "sequence_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 clusters

Type: many_to_many

Composing rels: L</cluster_has_putative_annotations> -> cluster

=cut

__PACKAGE__->many_to_many("clusters", "cluster_has_putative_annotations", "cluster");

=head2 to_clusters

Type: many_to_many

Composing rels: L</putative_annotation_has_to_clusters> -> to_cluster

=cut

__PACKAGE__->many_to_many(
  "to_clusters",
  "putative_annotation_has_to_clusters",
  "to_cluster",
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-03 15:48:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RrGNhV1lCW9HvRJ0ea6BYQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
