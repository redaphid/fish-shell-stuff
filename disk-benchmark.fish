function disk-benchmark --argument NAME SIZE TIME DIRECTORY OUT_DIR
    set -q NAME[1]; or begin
        echo "I need a name to do work!"
        return
    end
    set -q DIRECTORY[1]; or set DIRECTORY $NAME
    set -q OUT_DIR[1]; or set OUT_DIR $DIRECTORY
    set -q SIZE[1]; or set SIZE 10M
    set -q TIME[1]; or set TIME 60

    function disk-test -a DIRECTORY -a NAME -a SIZE -a TIME -a TYPE -a OUT_DIR
	set TMP_FILE $OUT_DIR/tmp.bin
        head -c $SIZE /dev/random > $TMP_FILE
        set TEST_NAME "$NAME-$TYPE"
        echo "name: $NAME size: $SIZE time: $TIME type: $TYPE out_dir: $OUT_DIR test_name: $TEST_NAME"
        fio \
            --rw="$TYPE" \
            --filename="$TMP_FILE" \
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
            --output="$DIRECTORY/$TEST_NAME.json"
	rm $TMP_FILE
    end
    set DIRECTORY $DIRECTORY/(date -u +"%Y-%m-%d__%H-%M")
    mkdir -p $DIRECTORY
    disk-test $DIRECTORY $NAME $SIZE $TIME randrw $OUT_DIR
    disk-test $DIRECTORY $NAME $SIZE $TIME read $OUT_DIR
end
