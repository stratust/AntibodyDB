use utf8;
package AntibodyDB::Schema::Result::AnalysesHasMethod;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::AnalysesHasMethod

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<analyses_has_methods>

=cut

__PACKAGE__->table("analyses_has_methods");

=head1 ACCESSORS

=head2 analysis_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 method_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "analysis_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "method_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</analysis_id>

=item * L</method_id>

=back

=cut

__PACKAGE__->set_primary_key("analysis_id", "method_id");

=head1 RELATIONS

=head2 analysis

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Analyse>

=cut

__PACKAGE__->belongs_to(
  "analysis",
  "AntibodyDB::Schema::Result::Analyse",
  { analysis_id => "analysis_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 method

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::Method>

=cut

__PACKAGE__->belongs_to(
  "method",
  "AntibodyDB::Schema::Result::Method",
  { method_id => "method_id" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jWhB3QoEsXaeh4D6gYeM9A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
