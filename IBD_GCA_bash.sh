#bash process_at_c1_file.sh 18_MappingFileGBSData.txt

while read line; do
f=`echo "$line" | cut -f1`
f2=`echo "$line" | cut -f2`

echo "$f" | cut -d"_" -f1
#wc -l "$f"

paste <(awk '{print $1}' "$f") <(awk '{print $2 }' "$f" | cut -d"_" -f1) <(awk '{print $2 }' "$f" | cut -d"_" -f4) <(awk '{print $3 }' "$f") <(awk '{print $4}' "$f") > "$f"_formated.txt

#R --slave --args "$f" < ~/OptimizedCalculateCoverage.R >> output_summary_at_c1_file.txt& 
#R --slave --args "$f" < ~/OptimizedCalculateCoverage.R
R --slave --args "$f"_formated.txt < ~/OptimizedCalculateCoverage.R > output_"$f"_formated.txt

pop_name=`echo output_"$f"_formated.txt | cut -d"_" -f2`

grep -v "multiple poplation" output_"$f"_formated.txt | awk -vut="$pop_name" '$1!=ut' > output_"$pop_name"_at_c1_file_formated_2.txt

sort -n -k1 output_"$pop_name"_at_c1_file_formated_2.txt | cut -f1,2,7,8  > output_"$pop_name"_at_c1_file_formated_2_sorted.txt

R --slave --args output_"$pop_name"_at_c1_file_formated_2_sorted.txt "$f2" < ~/BashProcessPopCoverage.R

done < $1
