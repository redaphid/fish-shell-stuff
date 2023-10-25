#!/usr/bin/env fish
function bitcoin-find-in-dir --description 'finds possible bitcoin addresses in a directory' --argument dir
	grep --color=never -aohr '\b[5KL][1-9A-HJ-NP-Za-km-z]\{50,51\}\b' $dir
end
status is-interactive; or bitcoin-find-in-dir $argv
