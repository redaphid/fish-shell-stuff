function network-names
 ip -br link show | grep '^e*' | awk '{print $1}' | grep -o '^e.*'; 
end
