# Defined in /tmp/fish.wTdsW0/save-all.fish @ line 2
function save-all --argument prefix
 set -q $prefix[1]; or set prefix "redaphid-"
 for f in (functions | grep $prefix); funcsave $f; end
 pushd ~/.config/fish/functions/
 git add "*.fish"
 git commit -am "save"
 popd
end
