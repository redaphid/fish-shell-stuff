function kill-em-all --argument name
ps ax | grep $name | awk '{print $1}' | xargs kill -9
end
