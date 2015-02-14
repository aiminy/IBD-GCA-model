while read line; do 

f1=`echo "$line"|awk -F"\t" '{print $1}'`
#f2=`echo "$line"|awk -F"\t" '{print $2}'`

#echo "$f1"

R --slave --args "$f1" < ~/ProcessTwoGBSFilesForEachAcc3.R&

done < $1
