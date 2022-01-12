# Defined in /home/redaphid/.config/fish/functions/hostname_color_text.fish @ line 2
function hostname_color_text
	type -q pastel; or begin
		echo "pastel isn't installed. no colors for you"
	end
	set_color -b (hostname_color)
	set_color (pastel format hex (pastel complement (hostname_color)))
end
