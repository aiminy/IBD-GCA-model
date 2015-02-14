
while read line; do
f=`echo "$line"`
echo "$f"

#cut -d" " -f2 "$f" | sort -u | wc -l >> number_mapped_marker.txt
paste <(awk '{print $1}' "$f") <(awk '{print $2 }' "$f" | cut -d"_" -f1) <(awk '{print $2 }' "$f" | cut -d"_" -f4) <(awk '{print $3 }' "$f") <(awk '{print $4}' "$f") > "$f"_formated.txt

done < $1
