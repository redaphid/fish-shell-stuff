#!/usr/bin/env fish
function webcam
	open  ~/Projects/webcam/index.html
end
status is-interactive; or webcam $argv
