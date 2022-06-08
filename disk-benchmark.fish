function disk-benchmark --argument NAME SIZE TIME TMP_FILE_DIRECTORY REPORT_DIR
    set -q NAME[1]; or begin
        echo "I need a name to do work!"
        return
    end
    set -q TMP_FILE_DIRECTORY[1]; or set TMP_FILE_DIRECTORY $NAME
    set -q REPORT_DIR[1]; or set REPORT_DIR $TMP_FILE_DIRECTORY
    set -q SIZE[1]; or set SIZE 10M
    set -q TIME[1]; or set TIME 60

    function disk-test -a TMP_FILE_DIRECTORY -a NAME -a SIZE -a TIME -a TYPE -a REPORT_DIR
	set TMP_FILE $TMP_FILE_DIRECTORY/tmp.bin
        head -c $SIZE /dev/random > $TMP_FILE
        set TEST_NAME "$NAME-$TYPE"
        echo "name: $NAME size: $SIZE time: $TIME type: $TYPE report_dir: $REPORT_DIR test_name: $TEST_NAME"
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
            --output="$REPORT_DIR/$TEST_NAME.json"
	rm $TMP_FILE
    end
    set TMP_FILE_DIRECTORY TMP_FILE_DIRECTORY/(date -u +"%Y-%m-%d__%H-%M")
    mkdir -p $TMP_FILE_DIRECTORY
    disk-test $TMP_FILE_DIRECTORY $NAME $SIZE $TIME randrw $REPORT_DIR
    disk-test $TMP_FILE_DIRECTORY $NAME $SIZE $TIME read $REPORT_DIR
end
