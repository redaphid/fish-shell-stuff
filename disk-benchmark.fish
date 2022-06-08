function disk-benchmark --argument NAME SIZE TIME
	function disk-test -a NAME -a FILE -a SIZE -a TIME -a TYPE
		head -c "$SIZE" /dev/random > $FILE
		set TEST_NAME "$(fs-get-from-file $FILE)-$NAME-$SIZE-$TIME-$TYPE-$(date '+%s')"
		sudo fio \
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
		rm $FILE
	end
	mkdir $NAME
	set FILE "$NAME/test-data"
	disk-test $NAME $FILE $SIZE $TIME randrw
	disk-test $NAME $FILE $SIZE $TIME read
end