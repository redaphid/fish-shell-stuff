#!/usr/bin/env fish
function git-delete-current-branch
	set current_branch (git branch --show-current)
	git checkout main
	git branch -D $current_branch
end
status is-interactive; or 'git-delete-current-branch'  $argv
