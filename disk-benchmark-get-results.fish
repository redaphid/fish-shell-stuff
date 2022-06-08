function disk-benchmark-get-results --argument FILE
cat $FILE | jq '.jobs | map({read:.read.io_bytes, write:.write.io_bytes})'
end
