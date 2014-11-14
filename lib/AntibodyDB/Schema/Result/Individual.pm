use utf8;
package AntibodyDB::Schema::Result::Individual;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Individual

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<individuals>

=cut

__PACKAGE__->table("individuals");

=head1 ACCESSORS

=head2 individual_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 individual_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 organism_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "individual_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "individual_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "organism_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</individual_id>

=back

=cut

__PACKAGE__->set_primary_key("individual_id");

=head1 RELATIONS

=head2 individuals_has_forms

Type: has_many

Related object: L<AntibodyDB::Schema::Result::IndividualsHasForm>

=cut

__PACKAGE__->has_many(
  "individuals_has_forms",
  "AntibodyDB::Schema::Result::IndividualsHasForm",
  { "foreign.individual_id" => "self.individual_id" },
  { cascade_copy => 0, cascade_delete => 0 },
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

=head2 samples

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Sample>

=cut

__PACKAGE__->has_many(
  "samples",
  "AntibodyDB::Schema::Result::Sample",
  { "foreign.individual_id" => "self.individual_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "AntibodyDB::Schema::Result::User",
  { user_id => "user_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "CASCADE" },
);

=head2 forms

Type: many_to_many

Composing rels: L</individuals_has_forms> -> form

=cut

__PACKAGE__->many_to_many("forms", "individuals_has_forms", "form");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YPztIToqnwcdYmyAfvZQEQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
