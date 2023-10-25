#!/usr/bin/env fish
function tsconfig-get
	curl https://gist.githubusercontent.com/redaphid/c2c3e89444c7e7a183f4b48f94e46503/raw
end
status is-interactive; or tsconfig-get $argv
