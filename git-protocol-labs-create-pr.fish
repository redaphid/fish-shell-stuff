# Defined in /tmp/fish.2NTIcy/git-protocol-labs-create-pr.fish @ line 2
function git-protocol-labs-create-pr --argument issue type
	set -q type[1]; or set type "feat"
	set issue_title (gh issue view $issue --json title --jq '.title')
	echo "title" $issue_title
	set branch_name (string join '/' "feat" (echo $issue_title | string lower | string replace -a ' ' '-'))
	echo "branch_name" $branch_name
	#git checkout -b (string join '/' "feat" (gh issue view $issue --json title --jq ".title" | string lower | string replace -a ' ' '-'))
end
