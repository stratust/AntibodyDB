use utf8;
package AntibodyDB::Schema::Result::ChainType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::ChainType

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<chain_type>

=cut

__PACKAGE__->table("chain_type");

=head1 ACCESSORS

=head2 chain_type_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 chain_type_name

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "chain_type_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "chain_type_name",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</chain_type_id>

=back

=cut

__PACKAGE__->set_primary_key("chain_type_id");

=head1 RELATIONS

=head2 putative_annotations

Type: has_many

Related object: L<AntibodyDB::Schema::Result::PutativeAnnotation>

=cut

__PACKAGE__->has_many(
  "putative_annotations",
  "AntibodyDB::Schema::Result::PutativeAnnotation",
  { "foreign.chain_type_id" => "self.chain_type_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5TPlVJFEmAYWKnINoQFOWw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
