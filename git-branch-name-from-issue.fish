function git-branch-name-from-issue --argument issue
    set issue_title (gh issue view $issue --json title --jq '.title')
    set branch_name (echo $issue_title | string replace --all --regex '^\W+|\W+$' '' | string replace --all --regex '\W+' '-' | string lower)
    echo $branch_name
end
