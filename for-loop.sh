Files=(/home/meenakshi/*)
for i in "${Files[@]}"; do
        wc -c "$i"
done
