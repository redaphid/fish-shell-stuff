#!/usr/bin/env fish
function gs --wraps='git status'
git status $argv
end
status is-interactive; or gs $argv
