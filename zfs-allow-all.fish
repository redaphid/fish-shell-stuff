function zfs-allow-all --description 'allows <user> all permissions to <dataset>' --argument user dataset dry_run
    argparse -i 'a/all' -- $argv
    set -q user[1]; and set -q dataset[1]; or begin
	echo "usage: zfs-allow-all <user> <dataset> <dry_run>"
	return
    end
    set -e found_beginning
    for line in (zfs allow 2>&1)
	echo $line | grep -q 'NAME'; and set found_beginning "true"
	set -q found_beginning[1]; or continue
	echo $line | grep -q '[[:space:]]\(subcommand\|property\)[[:space:]]'; or continue
        set perm (string split --no-empty ' ' $line)[1]
	string match -q -r '^y' $dry_run[1]; and begin 
		echo zfs allow -r -u $user $perm $dataset
		continue
	end
	set perm (string split --no-empty ' ' $line)[1]
	echo zfs allow -r -u $user $perm $dataset
    end
end
