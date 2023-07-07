#!/usr/bin/env fish
function typescript-init-project -a repo_name -a private
  set -q repo_name[1]; or begin
    echo "Usage: typescript-init-project <repo_name> [private]"
    return 1
  end
  set -q private[1]; or set private "false"
  set gh_repo_scope_flag (test $private = "true"; and echo "--private"; or echo "--public")
  set boilerplate_source "git@github.com:redaphid/typescript-yarn3-esbuild-boilerplate.git"
  set boilerplate_tag "boilerplate"
  gh repo create $repo_name $gh_repo_scope_flag
end
