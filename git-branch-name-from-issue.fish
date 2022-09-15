function git-branch-name-from-issue --argument issue
set issue_title (gh issue view $issue --json title --jq '.title')
set branch_name (string join '/' $issue_type (echo $issue_title | string trim |string lower | string replace -r -a '[\W]+' '-'))
echo $branch_name
end
