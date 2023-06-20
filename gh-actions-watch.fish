function gh-actions-watch

 while true
 gh run watch (gh run list --json=name,status,createdAt,databaseId -q '.[] | select(.status == "in_progress") | .databaseId') 2> /dev/null; or echo "no jobs"
 sleep 1
 end
end
