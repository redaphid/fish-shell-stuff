# Defined in /tmp/fish.EGyAFd/bak.fish @ line 2
function bak --description 'renames a <file | folder> to <file | folder>.bak . the -u flag undoes this'
  argparse 'u/undo' -- $argv
  set file $argv[1]

  string length -q "$file"; or begin
    echo "filename not specified! usage: bak <file | folder>"
    return 1
  end

  set new_file (string join '.' $file'.bak')

  set -q _flag_undo; and begin;
    set new_file (string replace -r '\.bak$' "" -- $file)
  end
  
 mv $file $new_file
end
