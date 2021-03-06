use utf8;
package AntibodyDB::Schema::Result::UserProject;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::UserProject

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<user_projects>

=cut

__PACKAGE__->table("user_projects");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=item * L</project_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id", "project_id");

=head1 RELATIONS

=head2 project

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Project>

=cut

__PACKAGE__->belongs_to(
  "project",
  "AntibodyDB::Schema::Result::Project",
  { project_id => "project_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 user

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "AntibodyDB::Schema::Result::User",
  { user_id => "user_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:DVTEYhMwJHzMRZqkAff5FQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
