use utf8;
package AntibodyDB::Schema::Result::AnalysisType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::AnalysisType

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<analysis_types>

=cut

__PACKAGE__->table("analysis_types");

=head1 ACCESSORS

=head2 analysis_type_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 analysis_type_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "analysis_type_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "analysis_type_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</analysis_type_id>

=back

=cut

__PACKAGE__->set_primary_key("analysis_type_id");

=head1 RELATIONS

=head2 analyses

Type: has_many

Related object: L<AntibodyDB::Schema::Result::Analyse>

=cut

__PACKAGE__->has_many(
  "analyses",
  "AntibodyDB::Schema::Result::Analyse",
  { "foreign.analysis_type_id" => "self.analysis_type_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6oBqGfeELdi/FDo50yOthg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
