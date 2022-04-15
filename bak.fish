function bak --description 'renames a <file | folder> to <file | folder>.bak . the -u flag undoes this'
  argparse "u/undo" -- $argv
  set file $argv[1]
  test -f "$file"; or begin
    echo "$file doesn't exist. So I'm not gonna 'bak' it up"
    return 1
  end
  string length -q "$file"; or begin
    echo "filename not specified! usage: bak <file | folder>"
    return 1
  end

  set -q _flag_undo; and begin
    while string match -q "*.bak" "$file"
      set new_file (string replace -r "\.bak\$" "" -- $file)
      mv "$file" "$new_file"
      set file "$new_file"
    end
    return 0
  end

  string match -q "*.bak" "$file"; and begin
    echo "$file already has a .bak suffix. Cowardly refusing to do anything"
    return 1
  end

  set new_file (string join "." "$file.bak")
  mv "$file" "$new_file"
end
