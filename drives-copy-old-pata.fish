#!/usr/bin/env fish
function drives-copy-old-pata --description 'copies very old pata data' --argument disk dest
	echo disk: $disk dest: $dest
	set -q disk[1]; or begin; echo "disk is required"; return 1; end
	set -q dest[1]; or begin; echo "destination is required"; return 1; end

	#set parts (ls /dev | grep '/dev/'$disk)
	set parts (ls /dev/$disk*)
	echo $parts
	for d in $parts
		echo $d
		basename $d
		sg_dd --verbose if=$d bs=512 of=$dest/(basename $d).img
	end
end
status is-interactive; or drives-copy-old-pata $argv
