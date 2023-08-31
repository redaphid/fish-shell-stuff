function clock
    set cf (date '+%s')
    echo $cf
    echo date '+%s' >>~/Documents/clock/$cf
    while true
        sleep 1
        echo date '+%s' >>~/Documents/clock/$cf
    end
    #trap 'echo date "+%s" >> ~/Documents/clock' INT
end
