#!/usr/bin/env fish
function git-first-commit-of-branch
    set commit_with_hash (git log main.. --oneline | tail -1)
    string sub $commit_with_hash --start=9
end
status is-interactive; or 'git-first-commit-of-branch'  $argv
