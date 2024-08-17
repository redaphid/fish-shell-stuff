function life-log
    set -l value $argv
    set -l service_url "https://life-log.loqwai.workers.dev" # Replace with your actual service URL
    set -l auth_token $LIFE_LOG_TOKEN

    # Create JSON payload
    set -l json_payload (echo '{"value": "'$value'"}')

    # Use curl to POST the log event
    curl -X POST $service_url \
        -H "Content-Type: application/json" \
        -H "Authorization: $auth_token" \
        -d $json_payload
end
