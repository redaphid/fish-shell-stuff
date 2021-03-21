# Defined in /tmp/fish.zUhmeR/decode-bitcoin-addresses.fish @ line 2
function decode-bitcoin-addresses
	for a in (cat /home/redaphid/bitcoin-search/sanitized-keys.txt)              04:13:00
                        set decoded (echo $a | base58 -d | xxd -l 16 | string split ':')
			echo $a
			echo $decoded[2]
        end
end
