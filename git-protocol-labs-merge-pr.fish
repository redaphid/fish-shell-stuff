# Defined in /tmp/fish.A6Gq3V/git-protocol-labs-merge-pr.fish @ line 2
function git-protocol-labs-merge-pr
	set branch_name (git branch --show-current)
	echo $branch_name
	gh pr ready $branch_name
	set commit_msg (gh pr view $branch_name --json "body" --jq ".body")
	gh pr merge $branch_name --squash --body (string join '\n' $commit_msg)
end
