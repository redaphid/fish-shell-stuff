function nvm_use --on-variable PWD
	test -f .nvmrc; and begin
		nvm use
	end
end
