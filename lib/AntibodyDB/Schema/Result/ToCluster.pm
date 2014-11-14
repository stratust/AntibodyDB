use utf8;
package AntibodyDB::Schema::Result::ToCluster;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::ToCluster

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<to_cluster>

=cut

__PACKAGE__->table("to_cluster");

=head1 ACCESSORS

=head2 to_cluster_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 to_cluster_name

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "to_cluster_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "to_cluster_name",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</to_cluster_id>

=back

=cut

__PACKAGE__->set_primary_key("to_cluster_id");

=head1 RELATIONS

=head2 clusters

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Cluster>

=cut

__PACKAGE__->has_many(
  "clusters",
  "AntibodyDB::Schema::Result::Cluster",
  { "foreign.to_cluster_id" => "self.to_cluster_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 putative_annotation_has_to_clusters

Type: has_many

Related object: L<AntibodyDB::Schema::Result::PutativeAnnotationHasToCluster>

=cut

__PACKAGE__->has_many(
  "putative_annotation_has_to_clusters",
  "AntibodyDB::Schema::Result::PutativeAnnotationHasToCluster",
  { "foreign.to_cluster_id" => "self.to_cluster_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 putative_annotations

Type: many_to_many

Composing rels: L</putative_annotation_has_to_clusters> -> putative_annotation

=cut

__PACKAGE__->many_to_many(
  "putative_annotations",
  "putative_annotation_has_to_clusters",
  "putative_annotation",
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9gZ82vgi2Cfb6xDrjcydiQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
