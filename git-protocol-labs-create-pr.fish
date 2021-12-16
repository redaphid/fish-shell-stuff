# Defined in /tmp/fish.cntXB0/git-protocol-labs-create-pr.fish @ line 2
function git-protocol-labs-create-pr --argument issue
	set issue_title (gh issue view $issue --json title --jq '.title')
	echo $issue_title
	#git checkout -b (string join '/' "feat" (gh issue view $issue --json title --jq ".title" | string lower | string replace -a ' ' '-'))
end
