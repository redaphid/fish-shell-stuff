#!/usr/bin/env fish
function eslintrc-get
	curl https://gist.githubusercontent.com/redaphid/4d051305ae07a69e49f71b6a5f54e32a/raw
end
status is-interactive; or 'eslintrc-get'  $argv
