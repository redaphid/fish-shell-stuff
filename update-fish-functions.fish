#!/usr/bin/env fish
function update-fish-functions
 pushd ~/.config/fish/functions; git pull; git add .; git commit -m 'automatic'; git push; popd;
end
status is-interactive; or 'update-fish-functions'  $argv
