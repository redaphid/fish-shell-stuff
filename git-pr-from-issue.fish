#!/usr/bin/env fish
function git-pr-from-issue --description 'Creates a feature branch and draft pr from an issue in github. Then links them together' --argument issue issue_type
        set -q issue[1]; or begin
          echo "I need to know at least the issue # to set things up for ya"
          echo "ex. git-pr-from-issue 4"
          echo "try `gh issue list` to see the project issues"
          return
        end
	set -q issue_type[1]; or set issue_type "feat"
	set issue_title (gh issue view $issue --json title --jq '.title')
	
	set branch_name (string join '/' $issue_type (echo $issue_title | string lower | string replace -r -a '[\W]' '-'))

	git checkout -b $branch_name; or begin
 			echo "couldn't checkout $branch_name"
			return
		end

	set commit_msg "$issue_type:  $issue_title"\n"Closes #"$issue

	git commit --allow-empty -m $commit_msg; and git push -u origin $branch_name

	gh pr create --draft --base main --title "$issue_type: $issue_title"  --body $commit_msg
end
status is-interactive; or git-pr-from-issue $argv
