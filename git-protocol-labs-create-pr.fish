# Defined in /home/redaphid/.config/fish/functions/git-protocol-labs-create-pr.fish @ line 2
function git-protocol-labs-create-pr --argument issue issue_type
	set -q issue_type[1]; or set issue_type "feat"
	set issue_title (gh issue view $issue --json title --jq '.title')
	set branch_name (string join '/' $issue_type (echo $issue_title | string lower | string replace -a ' ' '-'))
	echo "branch_name" $branch_name
	#git checkout -b (string join '/' "feat" (gh issue view $issue --json title --jq ".title" | string lower | string replace -a ' ' '-'))
end
