while read line; do
f=`echo "$line"| cut -d" " -f2`
echo "$f"

#sort -k2 -n "$f" | cut -d" " -f2 | sort -u | wc -l

cut -d" " -f2 "$f" | sort -u | wc -l >> number_mapped_marker.txt

done < $1
