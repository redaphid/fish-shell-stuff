#!/usr/bin/env fish
function copy-files-fast --description 'uses rsync to quickly copy from <src> to <dst>' --argument src dst
    rsync -avhW --no-compress --info=progress2 $src/ $dst
end
status is-interactive; or copy-files-fast $argv
