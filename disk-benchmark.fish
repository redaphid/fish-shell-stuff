function disk-benchmark --argument FILE SIZE TIME
	function disk-test -a FILE -a SIZE -a TIME -a TYPE
		echo $FILE
		sudo fio \
			--rw="$TYPE" \
			--filename="$FILE" \
			--size="$SIZE" \
			--runtime="$TIME" \
			--name="disk-benchmark-$FILE-$SIZE-$TIME-$TYPE" \
			--direct=1 \
			--bs=64k \
			--ioengine=libaio \
			--iodepth=256 \
			--numjobs=4 \
			--time_based \
			--group_reporting
	end
	disk-test $FILE $SIZE $TIME randrw
end
