#!/usr/bin/env fish
function color-vscode-node

set background (cat package.json | jq '.name' | md5sum | string sub -s 1 -l 6  | pastel darken 0.3 | pastel format hex)
set foreground (pastel textcolor $background | pastel format hex) 
echo "background": $background
echo "foreground": $foreground
end
status is-interactive; or color-vscode-node $argv
