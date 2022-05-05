# Defined in /tmp/fish.V6vvL4/fish_custom_prompt.fish @ line 2
function fish_custom_prompt
    echo "hi"
    hostname_color_text; echo (whoami)@(hostname)
end
