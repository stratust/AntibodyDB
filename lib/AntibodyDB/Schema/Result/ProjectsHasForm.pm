use utf8;
package AntibodyDB::Schema::Result::ProjectsHasForm;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::ProjectsHasForm

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<projects_has_forms>

=cut

__PACKAGE__->table("projects_has_forms");

=head1 ACCESSORS

=head2 project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 form_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "form_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</project_id>

=item * L</form_id>

=back

=cut

__PACKAGE__->set_primary_key("project_id", "form_id");

=head1 RELATIONS

=head2 form

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Form>

=cut

__PACKAGE__->belongs_to(
  "form",
  "AntibodyDB::Schema::Result::Form",
  { form_id => "form_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 project

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Project>

=cut

__PACKAGE__->belongs_to(
  "project",
  "AntibodyDB::Schema::Result::Project",
  { project_id => "project_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UrQO99wALZY7QLqKNIQXEQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
