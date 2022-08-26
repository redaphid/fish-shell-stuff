function wsl-build-electron --argument DIR
set -q DIR[1]; or set DIR '.'
pushd $DIR
rm -rf node_modules
end
