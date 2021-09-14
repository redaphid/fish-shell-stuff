function efi-remove-inactive
efibootmgr | grep -v '*' | string replace 'Boot' '' | awk '{print $1}' | xargs -i efibootmgr -b {}  --delete-bootnum
end
