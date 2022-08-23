function nvm_use --on-variable PWD
	test -f .nvmrc; and begin
		set prev_node_version (node --version)
		nvm use
		set new_node_version (node --version)
		if [ $prev_node_version != $new_node_version ]
			echo "$old_node_version -> $new_node_version"
		end
	end
end
