#!/usr/bin/env fish
function disk-benchmark-get-results --argument DIRECTORY
	for f in (find $DIRECTORY | grep .json)				
		set jq_output (cat $f | jq '.jobs[0] | {name: .jobname, read: .read.iops, write: .write.iops}')
		echo "### $f ###"\n
		echo "read:" (numfmt --to=si (echo $jq_output | jq -r '.read'))
		echo "write:" (numfmt --to=si (echo $jq_output | jq -r '.write'))
	end
end
status is-interactive; or 'disk-benchmark-get-results'  $argv
