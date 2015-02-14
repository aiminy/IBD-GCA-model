#bash process_at_c1_file.sh summary_at_c1_file.txt

while read line; do
f=`echo "$line"`
echo "$f"
R --slave --args "$f" < ~/OptimizedCalculateCoverage.R >> output_summary_at_c1_file.txt& 
done < $1
