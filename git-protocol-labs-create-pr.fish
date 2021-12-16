# Defined in /tmp/fish.Lx1efE/git-protocol-labs-create-pr.fish @ line 2
function git-protocol-labs-create-pr --argument issue issue_type
	set -q issue_type[1]; or set issue_type "feat"
	set issue_title (gh issue view $issue --json title --jq '.title')
	
	set branch_name (string join '/' $issue_type (echo $issue_title | string lower | string replace -a ' ' '-'))

	git checkout -b $branch_name; or begin
 			echo "couldn't checkout $branch_name"
			return
		end

	set commit_msg """
                $issue_type:  $issue_title
                Closes #$issue
        """

	git commit --allow-empty -m $commit_msg; and git push -u origin $branch_name

	gh pr create --draft --base main --title "$issue_type: $issue_title"  --body $commit_msg
end
