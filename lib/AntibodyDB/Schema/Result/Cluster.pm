use utf8;
package AntibodyDB::Schema::Result::Cluster;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Cluster

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<cluster>

=cut

__PACKAGE__->table("cluster");

=head1 ACCESSORS

=head2 cluster_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 to_cluster_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "cluster_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "to_cluster_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</cluster_id>

=back

=cut

__PACKAGE__->set_primary_key("cluster_id");

=head1 RELATIONS

=head2 cluster_has_putative_annotations

Type: has_many

Related object: L<AntibodyDB::Schema::Result::ClusterHasPutativeAnnotation>

=cut

__PACKAGE__->has_many(
  "cluster_has_putative_annotations",
  "AntibodyDB::Schema::Result::ClusterHasPutativeAnnotation",
  { "foreign.cluster_id" => "self.cluster_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 to_cluster

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::ToCluster>

=cut

__PACKAGE__->belongs_to(
  "to_cluster",
  "AntibodyDB::Schema::Result::ToCluster",
  { to_cluster_id => "to_cluster_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 putative_annotations

Type: many_to_many

Composing rels: L</cluster_has_putative_annotations> -> putative_annotation

=cut

__PACKAGE__->many_to_many(
  "putative_annotations",
  "cluster_has_putative_annotations",
  "putative_annotation",
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rbWOGXV9MD4HujIgIPqiOQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
