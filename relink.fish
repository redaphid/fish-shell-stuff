#!/usr/bin/env fish
# Symlink every runnable script here into PATH, minus the .fish suffix.

set -l src (path dirname (path resolve (status filename)))
set -l bin (test (count $argv) -gt 0; and echo $argv[1]; or echo $HOME/.local/bin)

test -d $bin; or begin
    echo "relink: no such directory: $bin" >&2
    exit 1
end

for file in $src/*
    test -f $file; or continue
    head -1 $file | string match -qr '^#!'; or continue
    chmod +x $file
    ln -sfn $file $bin/(path change-extension '' (path basename $file))
end
