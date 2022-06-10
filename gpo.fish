#!/usr/bin/env fish
function gpo --description 'Pushes current branch to the specified origin. Useful for pushing to multiple repos' --argument repo_name
set -q repo_name[1]; or begin
echo "Must specify a repo name!"
echo "e.g. gpo redaphid"
return
end
git push $repo_name (git branch --show-current)
end
status is-interactive; or gpo $argv
