#!/usr/bin/env fish
function gitignore-get
    curl https://raw.githubusercontent.com/loqwai/cli-tools/refs/heads/main/.gitignore
end
status is-interactive; or gitignore-get $argv
