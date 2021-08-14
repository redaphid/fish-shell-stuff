function filename-sanitizer-dir
 for i in (ls -1); mv "./$i" (filename-sanitizer $i); end;
end
