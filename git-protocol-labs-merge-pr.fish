#!/usr/bin/env fish
function git-protocol-labs-merge-pr
	set branch_name (git branch --show-current)
	echo $branch_name
	gh pr ready $branch_name
	set commit_msg (gh pr view $branch_name --json "body" --jq ".body")
	gh pr merge $branch_name --squash --body $commit_msg
end
status is-interactive; or git-protocol-labs-merge-pr $argv
