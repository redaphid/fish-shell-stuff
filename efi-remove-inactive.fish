#!/usr/bin/env fish
function efi-remove-inactive
efibootmgr | grep -v '*' | string replace 'Boot' '' | awk '{print $1}' | xargs -i efibootmgr -b {}  --delete-bootnum
end
status is-interactive; or efi-remove-inactive $argv
