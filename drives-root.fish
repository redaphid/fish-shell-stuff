function drives-root
mount | sed -n 's|^/dev/\(.*\) on / .*|\1|p'
end
