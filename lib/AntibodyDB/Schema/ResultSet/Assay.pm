package AntibodyDB::Schema::ResultSet::Assay;
use Moose;
use namespace::autoclean;
use MooseX::NonMoose;
extends 'DBIx::Class::ResultSet';
use POSIX;

sub list_assay_json {
    my ( $self, $study_id ) = @_;
    my $schema     = $self->result_source->schema;
    my $rs = $schema->resultset('Assay')->search({study_id => $study_id});;
    my @rows = $rs->all;
    my @json = map  {  { label => $_->assay_name, value => $_->id  } } @rows;  
    return \@json;
}

__PACKAGE__->meta->make_immutable;
1;
