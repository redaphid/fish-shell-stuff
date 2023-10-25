#!/usr/bin/env fish
function gh-pr-link
 gh pr edit --body (git-first-commit-of-branch)\n"Closes #988"; and gh pr ready;
end
status is-interactive; or gh-pr-link $argv
