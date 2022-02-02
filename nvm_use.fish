# Defined in /tmp/fish.FOuhZh/nvm_use.fish @ line 2
function nvm_use --on-variable PWD
	test -f .nvmrc; and begin
		nvm use
	end
end
