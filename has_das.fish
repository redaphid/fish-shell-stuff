function has_das
set das (lsusb | grep "Das Keyboard")
return (set -q das[1])
end
