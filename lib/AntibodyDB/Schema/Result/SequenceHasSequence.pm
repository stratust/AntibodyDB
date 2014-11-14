use utf8;
package AntibodyDB::Schema::Result::SequenceHasSequence;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::SequenceHasSequence

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<sequence_has_sequence>

=cut

__PACKAGE__->table("sequence_has_sequence");

=head1 ACCESSORS

=head2 heavy_file_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 light_file_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "heavy_file_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "light_file_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</heavy_file_id>

=item * L</light_file_id>

=back

=cut

__PACKAGE__->set_primary_key("heavy_file_id", "light_file_id");

=head1 RELATIONS

=head2 heavy_file

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Sequence>

=cut

__PACKAGE__->belongs_to(
  "heavy_file",
  "AntibodyDB::Schema::Result::Sequence",
  { sequence_id => "heavy_file_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 light_file

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Sequence>

=cut

__PACKAGE__->belongs_to(
  "light_file",
  "AntibodyDB::Schema::Result::Sequence",
  { sequence_id => "light_file_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:IfzIOo42LyR52NyO5StZUg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
