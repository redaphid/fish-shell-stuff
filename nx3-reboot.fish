#!/usr/bin/env fish
function nx3-reboot --argument new_code
set -q NX3_REBOOT_URL[1]; and set -q NX3_UPDATE_CODE[1]; or begin;
	echo "I need NX3_REBOOT_URL and NX3_UPDATE_CODE to continue"
	return		
end
set -q new_code[1]; or set new_code (npx futurama-string-generator)
echo "new code will be $new_code"
http -b $NX3_REBOOT_URL code==$NX3_UPDATE_CODE update==$new_code

end
status is-interactive; or 'nx3-reboot'  $argv
