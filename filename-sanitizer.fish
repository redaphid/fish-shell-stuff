function filename-sanitizer
 for i in $argv; string replace -a ' ' '-' $i | string lower | string replace -ar '\-{1,}' '-' | string replace -ar '\(.*$' '.mp3' | string replace -ar '\-\(.*(.*$)' '$1.$2' | string replace -a \' '' | string replace -r '\-\.(.*)' '.$1'; end;
end
