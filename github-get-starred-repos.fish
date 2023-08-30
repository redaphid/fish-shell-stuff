#!/usr/bin/env fish
function github-get-starred-repos
 gh api user/starred --template '{{range .}}{{.full_name|color "yellow"}} ({{timeago .updated_at}}){{"\n"}}{{end}}'; 
end
status is-interactive; or 'github-get-starred-repos'  $argv
