#!/usr/bin/env fish
function dangerunload
   echo -n "dangerload: "
   for f in $_dls_new_functions
       echo -n " -$f"
       functions --erase $f
   end
end
status is-interactive; or dangerunload $argv
