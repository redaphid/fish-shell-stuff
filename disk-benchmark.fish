function disk-benchmark --argument FILE SIZE TIME
	function disk-test -a SIZE -a TIME -a TYPE
		sudo fio \
			--rw="$TYPE" \
			--filename="test-data" \
			--size="$SIZE" \
			--runtime="$TIME" \
			--name="disk-benchmark-$SIZE-$TIME-$TYPE" \
			--direct=1 \
			--bs=64k \
			--ioengine=libaio \
			--iodepth=256 \
			--numjobs=4 \
			--time_based \
			--group_reporting \
			--output-format="json"
	end
	disk-test $SIZE $TIME randrw
end
