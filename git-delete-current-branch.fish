# Defined in /tmp/fish.jKZUT0/git-delete-current-branch.fish @ line 2
function git-delete-current-branch
	set current_branch (git branch --show-current)
	git checkout main
	git branch -D $current_branch
end
