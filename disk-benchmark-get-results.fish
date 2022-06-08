function disk-benchmark-get-results --argument DIRECTORY
	for f in (find $DIRECTORY | grep .json)		
		cat $f | jq '.jobs | map({(.jobname):{read:.read.io_bytes, write:.write.io_bytes}}) | add'
	end
end
