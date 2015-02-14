while read line; do
f=`echo "$line"| cut -d" " -f2`
echo "$f"

sort -k2 -n "$f" > "$f"_sorted.txt

#cut -d" " -f2 "$f" | sort -u | wc -l >> number_mapped_marker.txt

done < $1
