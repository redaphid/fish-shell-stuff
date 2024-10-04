function zcollections --wraps='zellij --layout ~/.config/zellij/layouts/collections.kdl --session collections' --description 'alias zcollections=zellij --layout ~/.config/zellij/layouts/collections.kdl --session collections'
  zellij --layout ~/.config/zellij/layouts/collections.kdl --session collections $argv
end
