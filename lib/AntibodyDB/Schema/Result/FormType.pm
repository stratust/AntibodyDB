use utf8;
package AntibodyDB::Schema::Result::FormType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::FormType

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<form_types>

=cut

__PACKAGE__->table("form_types");

=head1 ACCESSORS

=head2 form_type_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 form_type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "form_type_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "form_type",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</form_type_id>

=back

=cut

__PACKAGE__->set_primary_key("form_type_id");

=head1 RELATIONS

=head2 forms

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Form>

=cut

__PACKAGE__->has_many(
  "forms",
  "AntibodyDB::Schema::Result::Form",
  { "foreign.form_type_id" => "self.form_type_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:i83KNeS85iA6iCkbhXihKw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
