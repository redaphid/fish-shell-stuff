#!/usr/bin/env fish
function init-project -a project_type -a repo_name -a private -a source_repo -a source_tag
  set -q repo_name[1]; or begin
      echo "Usage: init-project <project_type> <repo_name> [private] [source_repo] [source_tag]"
      return 1
  end
  set -q private[1]; or set private "false"
  set -q project_type[1]; or set project_type $INIT_PROJECT_TYPE
  set -q project_type[1]; or set project_type "typescript"
  set -q source_repo[1]; or set source_repo $INIT_PROJECT_SOURCE_REPO_$project_type
  set -q source_repo[1]; or set source_repo "git@github.com:redaphid/$project_type-project-template.git"
  set -q source_tag[1]; or set source_tag $project_type$INIT_PROJECT_SOURCE_TAG
  set -q source_tag[1]; or set source_tag "boilerplate"

  set gh_repo_scope_flag (test $private = "true"; and echo "--private"; or echo "--public")
  gh repo create --clone $repo_name $gh_repo_scope_flag; or begin
    echo "Failed to create repo $repo_name"
    return 1
  end
  pushd $repo_name
  git remote add boilerplate $source_repo
  git pull boilerplate $source_tag; or begin
    echo "Failed to pull boilerplate from $source_repo $source_tag"
    return 1
  end
  git push --set-upstream origin main; or begin
    echo "Failed to push to origin $repo_name"
    return 1
  end
  git remote remove boilerplate
end
