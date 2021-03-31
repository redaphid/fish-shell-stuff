# Defined in /home/redaphid/.config/fish/functions/hostname_color.fish @ line 2
function hostname_color
 hostname | md5sum | string sub -s 1 -l 6
end
