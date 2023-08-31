function bitcoin-address-checksum --description 'verifies that the string is a bitcoin address' --argument addr
	decho "~"
	decho

	decho "Step 0: Address:" 
	decho $addr
	decho

	set addr_hex (echo $addr | base58 -d | base16 | string upper)
	set -q addr_hex[1]; or begin
		echo hex of $addr is invalid \($addr_hex\)
		return 1
	end

	decho "Step 1: Hex ✓"
	decho $addr_hex
	decho

	decho "Step 2: Check first byte "
	set prefix (string sub --start 1 --length 2 $addr_hex)
	decho $prefix
	decho '80'

	test $prefix = '80'; or return 1
	decho
	
	decho "Step 3: extract checksum ✓"
	set chk1 (string sub --start -8 $addr_hex)
	set addr_new_len (math (string length $addr_hex) - 8)
	set addr_no_chk (string sub --length $addr_new_len $addr_hex)
	decho $chk1
	decho

	decho "Step 4: sha256 hash of 3 ✓"
	set addr_hash_1 (string split ' ' (echo $addr_no_chk | base16 -d | sha256sum | string upper))[1]
	decho $addr_hash_1
	decho
	
	decho "Step 5: sha256 hash of 4 ✓"
	set addr_hash_2 (echo $addr_hash_1 | base16 -d | sha256sum | string upper)
	decho $addr_hash_2

	set chk2 (string sub --start 1 --length 8 $addr_hash_2)
	decho

	decho "Step 6: compare checksums"
	decho $chk1
	decho $chk2
	decho

	test $chk1 = $chk2; or return 1
	decho "Step 7: We're good!"
	echo $addr
	decho
	
	decho "~"
	decho

	return 0
end
