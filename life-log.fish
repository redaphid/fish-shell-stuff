function life-log --argument value
    if test -z "$value"
        http -b $LIFE_LOG_URL authorization:$LIFE_LOG_TOKEN test:$LIFE_LOG_TEST
    else
        http -b $LIFE_LOG_URL authorization:$LIFE_LOG_TOKEN test:$LIFE_LOG_TEST value:=$value computer=(hostname) gps:=(gps)
    end
end
