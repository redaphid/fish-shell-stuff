function save-all-redaphid-os
 echo $argv
 set -q dir[1]; or set dir "/home/redaphid/Projects/fish-shell-stuff"
 set -q prefix[1]; or set prefix ''

 pushd $dir

 for f in $argv
	funcsave --directory $dir $f
	git add "$f.fish"
 end
 git commit -m "functions: $argv"

 popd
end
