#!/usr/bin/env fish
function home_lock --description 'locks the lock at home' --argument sesame_token
set -q sesame_token[1]; or set sesame_token $SESAME_API_TOKEN;
set -q sesame_token[1]; or begin
echo "either an auth token must be provided (home_lock <token>) or the SESAME_API_TOKEN must be set in the environment"
return 1
end
set url_prefix "https://api.candyhouse.co/public";
set device_id (http --check-status $url_prefix/sesames "Authorization:$sesame_token" | jq -r '.[].device_id')
set -q device_id[1]; or begin
echo "couldn't find device id"
return 1
end
set resp (http --check-status $url_prefix/sesame/$device_id "Authorization:$sesame_token" command=lock); or begin
echo "$resp" | jq 1>&2
return 1
end
return 0
end
status is-interactive; or 'home_lock'  $argv
