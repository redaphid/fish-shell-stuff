function nx3-reboot-watch
	set -q NX3_REBOOT_TIMEOUT[1]; or set NX3_REBOOT_TIMEOUT 60
	while true
		sleep $NX3_REBOOT_TIMEOUT
		set NX3_NEW_CODE (curl "$NX3_REBOOT_URL?code=$NX3_QUERY_CODE" 2>/dev/null)
		test "$NX3_OLD_CODE" = "$NX3_NEW_CODE"; or begin;
			echo "rebooting nx3"
			virsh reboot nx3
			set NX3_OLD_CODE $NX3_NEW_CODE 
		end
	end
end
