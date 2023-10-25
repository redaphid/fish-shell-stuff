#!/usr/bin/env fish
function color-vscode-node --argument darken_amount
    set -q darken_amount[1]; or set darken_amount 0.1
    set background (cat package.json | jq '.name' | md5sum | string sub -s 1 -l 6  | pastel darken $darken_amount | pastel format hex)
    set foreground (pastel textcolor $background | pastel format hex)
    echo "background": $background
    echo "foreground": $foreground
end
status is-interactive; or color-vscode-node $argv
