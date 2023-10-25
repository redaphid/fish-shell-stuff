#!/usr/bin/env fish
function disk-benchmark --argument NAME SIZE TIME TMP_DIR REPORT_DIR
    set -q NAME[1]; or begin
        echo "I need a name to do work!"
        return
    end
    set -q TMP_DIR[1]; or set TMP_DIR $NAME
    set -q REPORT_DIR[1]; or set REPORT_DIR $TMP_DIR
    set -q SIZE[1]; or set SIZE 10M
    set -q TIME[1]; or set TIME 60

    function disk-test -a TMP_DIR -a NAME -a SIZE -a TIME -a TYPE -a REPORT_DIR
	set TMP_FILE $TMP_DIR/tmp.bin
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
    set run_string (date -u +"%Y-%m-%d__%H-%M")
    set TMP_DIR $TMP_DIR/$run_string
    set REPORT_DIR $REPORT_DIR/$run_string
    echo "tmp: $TMP_DIR report: $REPORT_DIR"

    mkdir -p $TMP_DIR
    mkdir -p $REPORT_DIR

    disk-test $TMP_DIR $NAME $SIZE $TIME randrw $REPORT_DIR
    disk-test $TMP_DIR $NAME $SIZE $TIME read $REPORT_DIR
end
status is-interactive; or disk-benchmark $argv
