function filename-sanitizer
 for i in $argv; echo (string replace -a ' ' '-' $i | string lower | string replace -ar '\-{1,}' '-' | string replace -ar '\(.*$' '.mp3' | string replace -ar '\-\.mp3' '.mp3')  ; end;
end
