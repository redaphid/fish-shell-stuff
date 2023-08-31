#!/usr/bin/env fish
function ros-functions-change-file-perms --argument directory
for f in (ls -1 $directory)
 set pre (cat $f)[1]
test "#!/usr/bin/env fish" = $pre; or continue
test -x $f; and continue
echo "making $f executable";
chmod +x $f;
end
end
