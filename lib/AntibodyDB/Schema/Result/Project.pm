use utf8;
package AntibodyDB::Schema::Result::Project;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Project

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<projects>

=cut

__PACKAGE__->table("projects");

=head1 ACCESSORS

=head2 project_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 project_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 project_description

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "project_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "project_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "project_description",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</project_id>

=back

=cut

__PACKAGE__->set_primary_key("project_id");

=head1 RELATIONS

=head2 projects_has_forms

Type: has_many

Related object: L<AntibodyDB::Schema::Result::ProjectsHasForm>

=cut

__PACKAGE__->has_many(
  "projects_has_forms",
  "AntibodyDB::Schema::Result::ProjectsHasForm",
  { "foreign.project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 studies

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Study>

=cut

__PACKAGE__->has_many(
  "studies",
  "AntibodyDB::Schema::Result::Study",
  { "foreign.project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_projects

Type: has_many

Related object: L<AntibodyDB::Schema::Result::UserProject>

=cut

__PACKAGE__->has_many(
  "user_projects",
  "AntibodyDB::Schema::Result::UserProject",
  { "foreign.project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 forms

Type: many_to_many

Composing rels: L</projects_has_forms> -> form

=cut

__PACKAGE__->many_to_many("forms", "projects_has_forms", "form");

=head2 users

Type: many_to_many

Composing rels: L</user_projects> -> user

=cut

__PACKAGE__->many_to_many("users", "user_projects", "user");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1ITMCIurf8g36mKBcc2+UA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
