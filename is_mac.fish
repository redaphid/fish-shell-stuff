#!/usr/bin/env fish
function is_mac
  set os (uname -s)
  return (test $os = Darwin)
end
