function decho --wraps=echo --description 'echo to stderr'
    isatty stdin; or begin
        cat - | while read -l line
            echo $argv $line 1>&2
        end
        return
    end
    echo $argv 1>&2
end
