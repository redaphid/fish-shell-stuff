#!/usr/bin/env fish
function get-function-description -a func --description "gets the description of <function> in the hackyist way imaginable"
    echo (string unescape (functions -D  --verbose $func)[5])
end