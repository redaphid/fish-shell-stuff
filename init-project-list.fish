#!/usr/bin/env fish
function init-project-list
  gh repo list --json name --jq '.[] | select(.name | endswith("-project-template")) | .name[:-17]' --template='{{range .}}{{println .}}{{end}}'
end
status is-interactive; or init-project-list $argv
