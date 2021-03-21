# Defined in /tmp/fish.bga303/bitcoin-find-in-dir.fish @ line 2
function bitcoin-find-in-dir --description 'finds possible bitcoin addresses in a directory' --argument dir
	grep -ohr '\b[5KL][1-9A-HJ-NP-Za-km-z]\{50,51\}\b' $dir
end
