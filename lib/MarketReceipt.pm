package Web::MarketReceipt;
use 5.010000;
our $VERSION = "0.02";

use Mouse;
use Mouse::Util::TypeConstraints;
use utf8;

use Web::MarketReceipt::Order;

subtype 'ArrayRefWebMarketReceiptOrder',
    as 'ArrayRef[Web::MarketReceipt::Order]';

coerce 'ArrayRefWebMarketReceiptOrder'
    => from 'ArrayRef',
    => via { [ map { Web::MarketReceipt::Order->new($_) } @$_ ] };

has is_success => (
    is       => 'ro',
    isa      => 'Bool',
    required => 1,
);

has raw => (
    is       => 'ro',
    required => 1,
);

has orders => (
    is     => 'ro',
    isa    => 'ArrayRefWebMarketReceiptOrder',
    coerce => 1,
);

has store => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

no Mouse;

sub dump {
    my $self = shift;

    +{
        is_success => $self->is_success,
        raw        => $self->raw,
        ($self->orders ? (orders => [map {$_->dump} @{ $self->orders }]) : ())
    };
}

1;
__END__

=head1 NAME

Web::MarketReceipt - market receipt verifier

=head1 SYNOPSIS

    use Web::MarketReceipt;

=head1 DESCRIPTION

Market receipt verifier

=head1 LICENSE

Copyright (C) KAYAC Inc.

=head1 AUTHOR

Masayuki Matsuki <songmu@cpan.org>

=cut
