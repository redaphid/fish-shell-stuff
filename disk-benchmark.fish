function disk-benchmark --argument NAME SIZE TIME DIRECTORY
    set -q NAME[1]; or begin
        echo "I need a name to do work!"
        return
    end
    set -q DIRECTORY[1]; or set DIRECTORY $NAME
    set -q SIZE[1]; or set SIZE 10M
    set -q TIME[1]; or set TIME 60

    function disk-test -a NAME -a FILE -a SIZE -a TIME -a TYPE
        head -c "$SIZE" /dev/random >$FILE
        set TEST_NAME "$(fs-get-from-file $FILE)-$NAME-$SIZE-$TIME-$TYPE-$(date '+%s')"
        fio \
            --rw="$TYPE" \
            --filename="$FILE" \
            --size="$SIZE" \
            --runtime="$TIME" \
            --name="$TEST_NAME" \
            --direct=1 \
            --bs=64k \
            --ioengine=libaio \
            --iodepth=256 \
            --numjobs=4 \
            --time_based \
            --group_reporting \
            --output-format="json" \
            --output="$NAME/$TEST_NAME.json"
    end
    set DIRECTORY $DIRECTORY/(date -u +"%Y-%m-%d__%H-%M")
    echo $DIRECTORY
    return
    mkdir -p $DIRECTORY
    set FILE "$DIRECTORY/test-data"
    disk-test $NAME $FILE $SIZE $TIME randrw
    disk-test $NAME $FILE $SIZE $TIME read
end
