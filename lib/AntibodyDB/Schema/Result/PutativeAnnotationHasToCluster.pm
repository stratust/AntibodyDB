use utf8;
package AntibodyDB::Schema::Result::PutativeAnnotationHasToCluster;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::PutativeAnnotationHasToCluster

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<putative_annotation_has_to_cluster>

=cut

__PACKAGE__->table("putative_annotation_has_to_cluster");

=head1 ACCESSORS

=head2 sequence_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 organism_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 to_cluster_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "sequence_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "organism_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "to_cluster_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</sequence_id>

=item * L</organism_id>

=item * L</to_cluster_id>

=back

=cut

__PACKAGE__->set_primary_key("sequence_id", "organism_id", "to_cluster_id");

=head1 RELATIONS

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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:IdJH4M81/ODU7QsjVVltCw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
