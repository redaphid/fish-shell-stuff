#!/usr/bin/env fish
function k-reset
	kubectl delete namespace --all
	kubectl api-resources --namespaced=true --verbs=delete -o name | xargs -l kubectl delete --all
end
status is-interactive; or k-reset $argv
