# Defined in /tmp/fish.KmLzx0/zfs-allow-all.fish @ line 2
function zfs-allow-all --description 'allows <user> all permissions to <dataset>' --argument user dataset
    #    for line in (zfs allow 2>&1 | grep '\Wproperty\W')
    #        set perm (echo $line | string replace 'property' '' | string trim)
    #        set perm2 (echo $line | string replace 'subcommand' '' | string trim)
    #	echo 'zfs allow -u' $user $perm $dataset
    #	echo $perm2
    #        #zfs allow -u $user $perm $dataset
    #    end
    #   
	argparse -i 'a/all' -- $argv
    for line in (zfs allow 2>&1 | grep '\Wsubcommand\W')
        set perm (echo $line | string split 'subcommand' | string trim)[1]
        zfs allow -u $user $perm $dataset
    end
end
