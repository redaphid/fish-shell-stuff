function hostname_color
 hostname | md5sum | string sub -s 1 -l 6
end
