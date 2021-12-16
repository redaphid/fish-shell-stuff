# Defined in /tmp/fish.NpGdoA/git-protocol-labs-merge-pr.fish @ line 2
function git-protocol-labs-merge-pr
	set commit_msg (gh pr view --json "body" --jq ".body")
	gh pr merge --squash --body $commit_msg
end
