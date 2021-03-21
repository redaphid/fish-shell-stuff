# Defined in /tmp/fish.x9Hemm/tilix-set-default.fish @ line 2
function tilix-set-default --description 'sets the default terminal to tilix'
	sudo update-alternatives --set x-terminal-emulator (update-alternatives --list x-terminal-emulator | grep tilix)
end
