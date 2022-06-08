function disk-benchmark-get-results --argument DIRECTORY
	for FILE in (find $DIRECTORY | grep .json)
		cat $FILE | jq '.jobs | map({read:.read.io_bytes, write:.write.io_bytes})'
	end
end
