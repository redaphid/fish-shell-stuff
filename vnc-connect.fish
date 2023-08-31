#!/usr/bin/env fish
function vnc-connect --description 'starts vncserver on the specified host, starts tilix, and logs in to the host' --argument host display_number
	set -q display_number[1]; or set -l display_number 7
	set conn $host:$display_number
	vncserver -kill $conn; vncserver -localhost no $conn -xstartup ~/bin/vnc-replace-desktop; xtigervncviewer $conn
end
