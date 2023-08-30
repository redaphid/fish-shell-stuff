function column-get --argument column_number
set -q column_number[1]; or set column_number $COLUMN_NUMBER;
set -q column_number[1]; or begin
echo "error: column number must be specified as the first parameter, or as the environment variable COLUMN_NUMBER"
end
while read -l line
tr -s '[:blank:]' '\t' | cut -f$column_number  -
end
end
