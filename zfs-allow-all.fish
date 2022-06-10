#!/usr/bin/env fish
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
        sudo zfs allow -u $user $perm $dataset
    end
end
status is-interactive; or zfs-allow-all $argv
