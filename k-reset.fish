# Defined in /tmp/fish.yAZ8a1/k-reset.fish @ line 2
function k-reset
	kubectl delete namespace --all
	kubectl api-resources --namespaced=true --verbs=delete -o name | xargs -l kubectl delete --all
end
