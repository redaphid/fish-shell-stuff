#!/usr/bin/env fish
function hecho --wraps=echo --description 'Trim new lines and copy to clipboard'
   isatty stdin; or begin
	cat - | while read -l line
    	set -a args $line
	end
  end; 
	set -a args $argv
    	hostname_color_text; echo $args
end
status is-interactive; or 'hecho'  $argv
