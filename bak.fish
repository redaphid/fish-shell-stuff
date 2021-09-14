# Defined in /tmp/fish.bmTXZk/bak.fish @ line 2
function bak --description 'renames a <file | folder> to <file | folder>.bak .' --argument target
  argparse 'u/undo' -- "$argv"; 
  
  set -q _flag_undo; and begin;
    echo "lets undo this biz"
    echo "undo: $_flag_undo"
    echo "target: $target"
    string replace -r '.bak$' "" $target
  end
end
