# Defined in /tmp/fish.agJkiD/hecho.fish @ line 2
function hecho --wraps=echo --description 'Trim new lines and copy to clipboard'
   isatty stdin; or begin
	cat - | while read -l line
    	set -a args $line
	end
  end; 
	set -a args $argv
    	hostname_color_text; echo $args
end
