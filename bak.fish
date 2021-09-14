# Defined in /tmp/fish.QY6L5p/bak.fish @ line 2
function bak --description 'renames a <file | folder> to <file | folder>.bak . the -u flag undoes this'
  argparse 'u/undo' -- $argv
  set target $argv[1]

  string length "$target"; or begin
    echo "filename not specified"
    return 1
  end

  set -q _flag_undo; and begin;
    string replace -r '.bak$' "" -- $target
    return 0
  end
  string
end
