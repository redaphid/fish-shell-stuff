# Defined in /tmp/fish.TXfqLH/bitcoin-wif-to-hex.fish @ line 2
function bitcoin-wif-to-hex --argument addr
	set decoded (echo $addr | base58 -d | xxd -u -g 0| string split ':')
	set hex_addr (echo $decoded[2] | string split ' ')[2]
	set -a hex_addr (echo $decoded[4] | string split ' ')[2]
	set -a hex_addr (echo $decoded[6] | string split ' ')[2]
	echo (echo $hex_addr | string collect | string replace -a ' ' '')
end
