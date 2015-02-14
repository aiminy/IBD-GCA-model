pop=(`cut -d" " -f2 IBD_output_5.txt | sort -u | cut -d"_" -f1 | sort -u`)
echo $pop

for (( i = 0 ; i < ${#pop[@]} ; i++ ))
do
echo "Element [$i]: ${pop[$i]}"

#cut -d" " -f2 IBD_output_5.txt | sort -u | cut -d"_" -f1 | grep "${pop[$i]}"
 
grep "${pop[$i]}"_at_c1 IBD_output_5.txt > "${pop[$i]}"_at_c1_file.txt 

R --slave --args "${pop[$i]}"_at_c1_file.txt < ~/ConcatenateIBDSegment.R& 

done
