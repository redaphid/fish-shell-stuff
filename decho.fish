function decho --wraps=echo --description 'echo to stderr'
   isatty stdin; or begin
        cat - | while read -l line
        set -a args $line
        end
  end; 
        set -a args $argv
        hostname_color_text; echo $args 1>&2
end
