use utf8;
package AntibodyDB::Schema::Result::ClusterHasPutativeAnnotation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::ClusterHasPutativeAnnotation

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<cluster_has_putative_annotation>

=cut

__PACKAGE__->table("cluster_has_putative_annotation");

=head1 ACCESSORS

=head2 cluster_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 sequence_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 organism_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "cluster_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "sequence_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "organism_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</cluster_id>

=item * L</sequence_id>

=item * L</organism_id>

=back

=cut

__PACKAGE__->set_primary_key("cluster_id", "sequence_id", "organism_id");

=head1 RELATIONS

=head2 cluster

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Cluster>

=cut

__PACKAGE__->belongs_to(
  "cluster",
  "AntibodyDB::Schema::Result::Cluster",
  { cluster_id => "cluster_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 putative_annotation

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::PutativeAnnotation>

=cut

__PACKAGE__->belongs_to(
  "putative_annotation",
  "AntibodyDB::Schema::Result::PutativeAnnotation",
  { organism_id => "organism_id", sequence_id => "sequence_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sNU8VxW0i1n7OJVZ7jE6wA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
