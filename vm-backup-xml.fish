function vm-backup-xml --argument backup_directory
	set -q backup_directory[1]; or set backup_directory $ROS_VM_LOCATION
	set -q backup_directory[1]; or begin
		echo "you must specify a directory to back the xml in to"
		echo "usage: vm-backup-xml <directory>"
		echo "or set the env variable ROS_VM_LOCATION"
		return
	end	
	set vms (virsh list --all --name | grep [a-zA-Z])
	for vm in $vms
		virsh dumpxml $vm > $backup_directory/$vm.xml
	end

	set xml_file_count (ls -1 $backup_directory/*.xml | wc -l)
	set vm_count (echo $vms | wc -l)
	test $xml_file_count -ge $vm_count; or begin
		echo "this script didn't export everything. Ugh $xml_file_count $vm_count"
		return
	end
	
end
status is-interactive; or vm-backup-xml $argv
