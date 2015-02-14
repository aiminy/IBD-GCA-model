#bash calculate_mapped_pop_ibd_segments.sh summary_at_c1_file.txt

while read line; do
f=`echo "$line"`
echo "$f"

wc -l "$f"
cut -d" " -f2 "$f" | cut -d"_" -f4 | sort -u

done < $1
