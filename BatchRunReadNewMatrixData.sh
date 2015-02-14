#bash BatchRunReadNewMatrixData.sh summary_at_c1_file.txt

while read line; do
f=`echo "$line"`
echo "$f"
R --slave --args "$f" < ReadEachNewMatrixData.R 
done < $1
