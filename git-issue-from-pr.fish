function git-issue-from-pr
set issue  (gh pr view --json='body' | jq -r '.body' | string split "Closes #")[3]
echo $issue
end
