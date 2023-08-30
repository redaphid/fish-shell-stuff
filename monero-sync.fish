#!/usr/bin/env fish
function monero-sync
/mnt/f18/monero/monero/monerod --data-dir /mnt/f18/monero/db/
end
status is-interactive; or 'monero-sync'  $argv
