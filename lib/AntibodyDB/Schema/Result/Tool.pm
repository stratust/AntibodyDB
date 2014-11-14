use utf8;
package AntibodyDB::Schema::Result::Tool;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Tool

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<tools>

=cut

__PACKAGE__->table("tools");

=head1 ACCESSORS

=head2 tool_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 tool_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 tool_desc

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "tool_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "tool_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "tool_desc",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</tool_id>

=back

=cut

__PACKAGE__->set_primary_key("tool_id");

=head1 RELATIONS

=head2 tool_versions

Type: has_many

Related object: L<AntibodyDB::Schema::Result::ToolVersion>

=cut

__PACKAGE__->has_many(
  "tool_versions",
  "AntibodyDB::Schema::Result::ToolVersion",
  { "foreign.tool_id" => "self.tool_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KNMcxLj2c9GOP7Xq/qHhXA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
