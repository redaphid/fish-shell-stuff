#!/usr/bin/env fish
function git-easy-rebase
git reset --soft $(git merge-base main HEAD)
end
status is-interactive; or git-easy-rebase $argv
