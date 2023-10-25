#!/usr/bin/env fish
function ubak --wraps='bak -u' --description 'alias ubak=bak -u'
  bak -u $argv;
end
status is-interactive; or ubak $argv
