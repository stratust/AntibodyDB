use utf8;
package AntibodyDB::Schema::Result::Primer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Primer

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<primer>

=cut

__PACKAGE__->table("primer");

=head1 ACCESSORS

=head2 primer_id

  data_type: 'integer'
  is_nullable: 0

=head2 primer_name

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=head2 primer_sequence

  data_type: 'varchar'
  is_nullable: 1
  size: 45

=cut

__PACKAGE__->add_columns(
  "primer_id",
  { data_type => "integer", is_nullable => 0 },
  "primer_name",
  { data_type => "varchar", is_nullable => 0, size => 45 },
  "primer_sequence",
  { data_type => "varchar", is_nullable => 1, size => 45 },
);

=head1 PRIMARY KEY

=over 4

=item * L</primer_id>

=back

=cut

__PACKAGE__->set_primary_key("primer_id");

=head1 RELATIONS

=head2 sequences

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Sequence>

=cut

__PACKAGE__->has_many(
  "sequences",
  "AntibodyDB::Schema::Result::Sequence",
  { "foreign.primer_id" => "self.primer_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/nmUaPMN3PAEy4OIl0s7/A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
