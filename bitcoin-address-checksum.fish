# Defined in /tmp/fish.TEo53O/bitcoin-address-checksum.fish @ line 2
function bitcoin-address-checksum --description 'verifies that the string is a bitcoin address' --argument addr

	decho $addr
	set addr_hex (echo $addr | base58 -d | base16 | string upper)

	set -q addr_hex[1]; or return 1

	decho "Step 1: Hex ✓"
	decho $addr_hex
	decho "Step 2: Check first byte "
	test (string sub --start 1 --length 2 $addr_hex) = '80'
	and decho "✓"
	or begin; decho "𐄂 \n ...address doesn't begin with 80"; return 1; end
	decho
	
	decho "Step 3: extract checksum ✓"
	set chk1 (string sub --start -8 $addr_hex)
	decho $chk1
	set addr_new_len (math (string length $addr_hex) - 8)
	set addr_no_chk (string sub --length $addr_new_len $addr_hex)
	decho "address without checksum:" 
	decho $addr_no_chk
	decho

	decho "Step 4: sha256 hash of 3 ✓"
	set addr_hash_1 (string split ' ' (echo $addr_no_chk | base16 -d | sha256sum | string upper))[1]
	decho $addr_hash_1
	decho
	
	decho "Step 5: sha256 hash of 4 ✓"
	set addr_hash_2 (string split ' ' (echo $addr_hash_1 | base16 -d | sha256sum | string upper))[1]
	decho $addr_hash_2
	set chk2 (string sub --length 8 $addr_hash_2)
	decho $chk2
	decho

	decho -n "Step 6: compare checksums "
	test $chk1 = $chk2; or begin
		decho "checksums didn't match :("
		return 1
	end

	echo $addr
	decho "✓"

	return 0
end
