function nvm_use --on-variable PWD
		type -q nvm; or return
		type -q node; or nvm use
		set prev_node_version (node --version)
		nvm use --silent
		set new_node_version (node --version)
		if [ $prev_node_version != $new_node_version ]
				echo "$prev_node_version -> $new_node_version"
		end
end
