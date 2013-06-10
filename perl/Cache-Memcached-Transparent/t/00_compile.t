use strict;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Test::More tests => 1;

BEGIN { 
    use FindBin;
    use lib "$FindBin::Bin/../lib";
    use_ok 'Cache::Memcached::Transparent' 
}
