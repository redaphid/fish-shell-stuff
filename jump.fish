
set config_file ~/.config/jump/aliases.yaml
function jump
  test (count $argv) -eq 0; and begin
    echo "no path or shortcode specified" 1>&2
    __jump_nothing
    return
  end

  echo "argv: $argv"
  #see if the first argument is a path
  if echo "$argv[1]" | grep -q "/"
    echo "argv[1]: $argv[1]"
    echo "$argv[1] looks like a path, jumping there"
    __jump_path $argv[1]
    return
  end

  # get the dir from the shortcode
  set -l dir (yq e ".$argv[1]" ~/.config/jump/aliases.yaml)
  echo "dir: $dir shortcode: $argv[1]"
  __jump_path $dir $argv[1]
  return
end

function __jump_nothing
  pushd ~
  return
end

function __jump_path --argument-names dir shortcode
  echo "jump_path: $dir $shortcode"
  test -d $dir; and begin
    echo "$dir exists, jumping there"
    pushd $dir
    test -z $shortcode; and begin
      #get shortcode from path by using yq to iterate over the config file's values for each key. If the value matches $dir, then set shortcode to the key.
      set -l shortcode (yq e "to_entries | .[] | select(.value == \"$dir\") | .key" $config_file)
      echo "shortcode: $shortcode"
      test -z "$shortcode"; and begin
        echo "no shortcode found for $dir"
        __jump_shortcode $dir
        return
      end
      return
    end
    return
  end

  echo "Directory '$dir' doesn't exist. Create it? (y/yes or n/no)"

  read -l create
  if test "$create" = "n" or test "$create" = "no"; return; end

  if "$create" != "y" and "$create" != "yes"
    echo "Please enter 'y' or 'n'."
  end

  mkdir -p $dir; or begin
    echo "Failed to create directory '$dir'" 1>&2
    exit -1
  end

  pushd $dir
  echo "Assign a short code to this directory by typing it in and hitting enter."
  echo "Leave blank to exit."
  read -l $requested_shortcode
  test -z $requested_shortcode; and return

  __jump_shortcode $dir $requested_shortcode
end

function __jump_shortcode --argument-names dir shortcode
  echo "jump shortcode:dir: $dir shortcode: $shortcode"
  set -l dir_count (count $dir)
  test $dir_count -eq 0; and begin
    echo "I should at least have a dir to jump to" 1>&2
    return
  end

  touch $config_file; or begin
    echo "Failed to create config file '$config_file'."
    return
  end
  if test -z "$shortcode"
    echo "enter the shortcode for this directory:"
    read shortcode
    echo "you must specify a shortcode to jump to" 1>&2
    __jump_shortcode $dir $shortcode
    return
  end

  set old_path (yq e ".$shortcode" $config_file)
  echo "old_path: $old_path"
  if test "$old_path" = "null"
    echo "shortcode was empty, setting it"
    #update the config file with the new directory
    yq e ".$shortcode = \"$dir\"" -i $config_file
    echo "$shortcode -> $dir ✅"
    return
  end
  # if $dir is the same as $old_path, then don't overwrite it
  if test "$dir" = "$old_path"
    return
  end
  echo "old_path: $old_path dir: $dir"

  echo "Do you want to overwrite it? (y/yes or n/no)"
  read -l overwrite
  if test "$overwrite" = "n" -o "$overwrite" = "no"
    echo "$shortcode -> $dir ❌"
    return
  end

  if test "$overwrite" != "y" -a "$overwrite" != "yes"
    echo "Please enter 'y' or 'n'."
    __jump_shortcode $dir $shortcode
    return
  end

  echo "updating $config_file with $shortcode -> $dir"
  #update the config file with the new directory
  # get full path of dir
  set -l full_dir (realpath $dir)
  yq e -i ".$shortcode = \"$full_dir\"" $config_file
  echo "$shortcode -> $full_dir ✅"
  return
end
