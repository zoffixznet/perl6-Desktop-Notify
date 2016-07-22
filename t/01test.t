#!/usr/bin/env perl6

use Test;
use lib 'lib';
use Desktop::Notify;

constant AUTHOR = ?%*ENV<TEST_AUTHOR>;

my $notify = Desktop::Notify.new(app-name => 'testone');

ok { defined $notify }, 'initialization';
ok $notify.is-initted, "is-initted method";
is $notify.app-name, 'testone', 'reading app name';

$notify.app-name('testtwo');

is $notify.app-name, 'testtwo', 'writing app name';

my $n = $notify.new-notification('Attention!', 'What just happened?', 'stop');

is $n.WHAT, Desktop::Notify::NotifyNotification, 'creating a notification';
is $notify.error.WHAT, Desktop::Notify::GError, "it's a GError";
is $notify.error.domain, 0, "reading error domain";
is $notify.error.code, 0, "reading error code";
if AUTHOR {
  ok $notify.show($n), 'showing the notification';
  # Does it show on screen? :-)
  sleep 1;
}else{
  skip 'showing the notification', 1;
}

ok $notify.update($n, 'Oh well!', 'Not quite a disaster!', 'stop'), 'changing the message';
if AUTHOR {
  ok $notify.show($n), 'showing updated notification';
  sleep 1;
}else{
  skip 'showing updated notification', 1;
}
if AUTHOR {
  ok $notify.close($n), 'closing the notification';
}else{
  skip 'closing the notification', 1;
}

is $notify.get-type.WHAT, Int, 'get-type method';

done-testing;
