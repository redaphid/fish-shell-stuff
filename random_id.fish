function random_id
    head -c 16 /dev/urandom | od -A n -t x1 | tr -d ' \n'
end
