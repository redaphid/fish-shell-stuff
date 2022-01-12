# Defined in /tmp/fish.kVplG7/covid-vaccine-cut-in-line.fish @ line 2
function covid-vaccine-cut-in-line
  while true
    echo (http https://www.handsonphoenix.org/opportunity/a0C1J00000JEdQUUA1 | npx hred "#opportunity-detail-description" | jq -r .[0] | md5sum | string split ' ')[1]
  end
end
