function clock
    set cf (date '+%s')

    echo date '+%s' >>~/Documents/clock/$cf
    while true
        sleep 1
        echo date '+%s' >>~/Documents/clock
    end
    trap 'echo date "+%s" >> ~/Documents/clock' INT
end
