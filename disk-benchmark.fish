function disk-benchmark --argument FILE SIZE TIME
	echo $FILE $SIZE $TIME
	function disk-test -a TYPE
		echo "$TYPE"
		sudo fio \
			--rw="$TYPE" \
			--filename="$FILE" \
			--size="$SIZE" \
			--runtime="$TIME" \
			--name="whatever" \
			--direct=1 \
			--bs=64k \
			--ioengine=libaio \
			--iodepth=256 \
			--numjobs=4 \
			--time_based \
			--group_reporting
	end
	disk-test randrw
end
