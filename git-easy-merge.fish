#!/usr/bin/env fish
function git-easy-merge
git reset --soft $(git merge-base main HEAD)
end
status is-interactive; or git-easy-merge $argv
