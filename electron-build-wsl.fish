function electron-build-wsl --argument DIR
set -q DIR[1]; or set DIR '.'
pushd $DIR
rm -rf node_modules
end
