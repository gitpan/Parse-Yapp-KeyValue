use Test::More tests => 13;

BEGIN { use_ok('Parse::Yapp::KeyValue') };

my $pkv = new Parse::Yapp::KeyValue;
my $href;

isa_ok($pkv, 'Parse::Yapp::KeyValue', 'instantiate new Parse::Yapp::KeyValue object');

$href = $pkv->parse('AL=53 AK=54 AB=55 TN="home sweet home" A=1 A=2 =$ =4');

cmp_ok($href->{AL}, '==', 53, 'key/value pair: AL => 53');
cmp_ok($href->{AK}, '==', 54, 'key/value pair: AK => 54');
cmp_ok($href->{AB}, '==', 55, 'key/value pair: AB => 55');
cmp_ok($href->{TN}, 'eq', 'home sweet home', 'key/value pair: TN => home sweet home');
isa_ok($href->{A}, 'ARRAY', 'value for key A is an array reference');
cmp_ok(scalar(@{ $href->{A} }), '==', 2, 'value for key A has two members');
cmp_ok($href->{A}->[0], '==', 1, 'index 0 for key A: 1');
cmp_ok($href->{A}->[1], '==', 2, 'index 1 for key A: 2');
isa_ok($href->{''}, 'ARRAY', 'value for the empty key has two members');
cmp_ok($href->{''}->[0], 'eq', '$', 'index 0 for empty key: $');
cmp_ok($href->{''}->[1], '==', 4, 'index 1 for empty key: 4');

