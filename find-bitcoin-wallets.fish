#!/usr/bin/env fish
function find-bitcoin-wallets --argument directory
    grep --binary-files=text -r '\b5[HJK][1-9A-HJ-NP-Za-km-z]\{49\}\b' $directory
    grep --binary-files=text -r '\b[KL][1-9A-HJ-NP-Za-km-z]\{51\}\b' $directory
end
status is-interactive; or find-bitcoin-wallets $argv
