use utf8;
package AntibodyDB::Schema::Result::Method;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AntibodyDB::Schema::Result::Method

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<methods>

=cut

__PACKAGE__->table("methods");

=head1 ACCESSORS

=head2 method_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 method_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 method_type_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "method_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "method_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "method_type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</method_id>

=back

=cut

__PACKAGE__->set_primary_key("method_id");

=head1 RELATIONS

=head2 analyses_has_methods

Type: has_many

Related object: L<AntibodyDB::Schema::Result::AnalysesHasMethod>

=cut

__PACKAGE__->has_many(
  "analyses_has_methods",
  "AntibodyDB::Schema::Result::AnalysesHasMethod",
  { "foreign.method_id" => "self.method_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 assay_has_methods

Type: has_many

Related object: L<AntibodyDB::Schema::Result::AssayHasMethod>

=cut

__PACKAGE__->has_many(
  "assay_has_methods",
  "AntibodyDB::Schema::Result::AssayHasMethod",
  { "foreign.method_id" => "self.method_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 method_type

Type: belongs_to

Related object: L<AntibodyDB::Schema::Result::MethodType>

=cut

__PACKAGE__->belongs_to(
  "method_type",
  "AntibodyDB::Schema::Result::MethodType",
  { method_type_id => "method_type_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "CASCADE" },
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

=head2 analyses

Type: many_to_many

Composing rels: L</analyses_has_methods> -> analysis

=cut

__PACKAGE__->many_to_many("analyses", "analyses_has_methods", "analysis");

=head2 assays

Type: many_to_many

Composing rels: L</assay_has_methods> -> assay

=cut

__PACKAGE__->many_to_many("assays", "assay_has_methods", "assay");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2014-11-02 23:24:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1GgRUK3QduD5K+RaikwcDA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
