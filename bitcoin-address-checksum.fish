# Defined in /tmp/fish.q27crN/bitcoin-address-checksum.fish @ line 1
function bitcoin-address-checksum --description 'verifies that the string is a bitcoin address' --argument addr
	set addr_hex (echo $addr | base58 -d | base16 | string upper)
	echo "Step 1: Hex ✓"
	echo $addr_hex

	echo -n "Step 2: Check first byte "
	test (string sub --start 1 --length 2 $addr_hex) = '80'
	and echo "✓"
	or begin; echo "𐄂 \n ...address doesn't begin with 80"; return 1; end
	echo
	
	echo "Step 3: extract checksum ✓"
	set chk1 (string sub --start -8 $addr_hex)
	echo $chk1
	set addr_new_len (math (string length $addr_hex) - 8)
	set addr_no_chk (string sub --length $addr_new_len $addr_hex)
	echo "address without checksum:" 
	echo $addr_no_chk
	echo

	echo "Step 4: sha256 hash of 3 ✓"
	set addr_hash_1 (string split ' ' (echo $addr_no_chk | base16 -d | sha256sum | string upper))[1]
	echo $addr_hash_1
	echo
	
	echo "Step 5: sha256 hash of 4 ✓"
	set addr_hash_2 (string split ' ' (echo $addr_hash_1 | base16 -d | sha256sum | string upper))[1]
	echo $addr_hash_2
	set chk2 (string sub --length 8 $addr_hash_2)
	echo $chk2
	echo

	echo -n "Step 6: compare checksums "
	test $chk1 = $chk2; or begin
		echo "checksums didn't match :("
		return 1
	end

	echo "✓"

	return 0
end
