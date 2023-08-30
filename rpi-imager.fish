#!/usr/bin/env fish
function rpi-imager
flatpak run org.raspberrypi.rpi-imager
end
status is-interactive; or 'rpi-imager'  $argv
