#!/usr/bin/env fish
function short_url --argument SUFFIX URL
 
set -q SUFFIX[1]; or begin;
 echo "give me the suffix pls"; return 
end;
set -q URL[1]; or begin;
echo "tell me where to go pls"
return
end
echo npx wrangler kv --binding short_urls key put "$SUFFIX" "$URL" --remote;
end
status is-interactive; or short_url $argv
