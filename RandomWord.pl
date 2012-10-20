package MT::Plugin::OMV::RandomWord;
# $Id$

use strict;
use MT 3;
use MT::Template::Context;

use vars qw( $VENDOR $MYNAME $VERSION );
($VENDOR, $MYNAME) = (split /::/, __PACKAGE__)[-2, -1];
(my $revision = '$Rev$') =~ s/\D//g;
$VERSION = '0.10'. ($revision ? ".$revision" : '');

use base qw( MT::Plugin );
my $plugin = __PACKAGE__->new({
    id => $MYNAME,
    key => $MYNAME,
    name => $MYNAME,
    version => $VERSION,
    author_name => 'Open MagicVox.net',
    author_link => 'http://www.magicvox.net/',
    doc_link => '',
    description => <<PERLHEREDOC,
Return a word randomly from the comma separated words list.
PERLHEREDOC
});
MT->add_plugin ($plugin);

sub instance { $plugin; }



###
MT::Template::Context->add_container_tag ($MYNAME => sub {
    my ($ctx, $args, $cond) = @_;

    defined (my $out = $ctx->slurp ($args, $cond))
        or return;

    my $delim = $args->{delim} || $args->{glue} || ',';
    my @out = split $delim, $out;

    $out[int (rand ($#out))];
});

1;