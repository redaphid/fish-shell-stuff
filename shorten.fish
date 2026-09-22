#!/usr/bin/env fish
function shorten --argument URL SUFFIX
    set -q URL[1]; or begin
        echo "Usage: shorten <original_url> <shortened_url>"
        return 1
    end
    set -q SUFFIX[1]; or begin
        echo "Usage: shorten <original_url> <shortened_url>"
        return 1
    end
    npx wrangler kv key put "$SUFFIX" "$URL" --namespace-id e239df04697f45d78631c29760c1a5b9 --remote
end
status is-interactive; or shorten $argv
