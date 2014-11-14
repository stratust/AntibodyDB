package AntibodyDB::Schema::ResultSet::IgblastParam;
use Moose;
use namespace::autoclean;
use MooseX::NonMoose;
extends 'DBIx::Class::ResultSet';
use POSIX;

sub list_igblast_param_json {
    my ( $self, $igblast_param_id ) = @_;
    my $schema = $self->result_source->schema;

    my $rs = $schema->resultset('IgblastParam');
    if ($igblast_param_id) {
        $rs = $rs->search( { Igblast_param_id => $igblast_param_id } );
    }

    my @rows = $rs->all;
    my @json = map {
        { labEL => $_->assay_name, value => $_->id }
    } @rows;
    return \@json;
}


__PACKAGE__->meta->make_immutable;
1;
