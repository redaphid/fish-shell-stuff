function update-fish-functions
 pushd ~/.config/fish/functions; git pull; git add .; git commit -m 'automatic'; git push; popd;
end
