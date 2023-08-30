#!/usr/bin/env fish
function hostname_color_text
	type -q pastel; or begin
		echo "pastel isn't installed. no colors for you"
		echo """you can install it like so:
wget "https://github.com/sharkdp/pastel/releases/download/v0.8.1/pastel_0.8.1_amd64.deb"
sudo dpkg -i pastel_0.8.1_amd64.deb"""
return
	end
	set_color -b (hostname_color)
	set_color (pastel format hex (pastel textcolor (hostname_color)))
end
status is-interactive; or 'hostname_color_text'  $argv
