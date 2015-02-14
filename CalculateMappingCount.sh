location_index=(`seq 2814 954676`)

for (( i = 0 ; i < ${#location_index[@]} ; i++ )){

mapping_num=`awk -vut="${location_index[$i]}" '$2==ut' 1008_at_c1_file.txt_out_2.txt_sorted.txt | wc -l`

echo "${location_index[$i]}" "$mapping_num"

}
