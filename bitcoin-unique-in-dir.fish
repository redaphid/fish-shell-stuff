function bitcoin-unique-in-dir --description 'runs bitcoin-find-in-dir and prints only unique addresses' --argument dir
 bitcoin-find-in-dir $dir | sort | uniq;
end
