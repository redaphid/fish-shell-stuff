#!/usr/bin/env fish
function save-all --argument prefix
 set -q $prefix[1]; or set prefix "redaphid-"
 for f in (functions | grep $prefix); funcsave $f; end
 pushd ~/.config/fish/functions/
 git add "*.fish"
 git commit -am "save"
 git push
 popd
end
status is-interactive; or 'save-all'  $argv
