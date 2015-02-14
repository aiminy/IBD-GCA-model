#Usage: bash RunCombineDiffPop.sh 16_new_matrix_data.txt
#../1008_1015_1017_1018_marker_effect_estimation.RData  ../1020_marker_effect_estimation.RData  ../1116_marker_effect_estimation.RData  ../1120_marker_effect_estimation.RData
#../1016_marker_effect_estimation.RData                 ../1021_marker_effect_estimation.RData  ../1118_marker_effect_estimation.RData  ../1121_marker_effect_estimation.RData
#../1019_marker_effect_estimation.RData                 ../1114_marker_effect_estimation.RData  ../1119_marker_effect_estimation.RData  ../1122_marker_effect_estimation.RData

#wema_1008_189_955690_matrix.RData  wema_1017_189_955690_matrix.RData  wema_1020_188_955690_matrix.RData  wema_1116_184_955690_matrix.RData  wema_1119_182_955690_matrix.RData  wema_1122_164_955690_matrix.RData
#wema_1015_190_955690_matrix.RData  wema_1018_189_955690_matrix.RData  wema_1021_190_955690_matrix.RData  wema_1117_128_955690_matrix.RData  wema_1120_174_955690_matrix.RData
#wema_1016_188_955690_matrix.RData  wema_1019_191_955690_matrix.RData  wema_1114_184_955690_matrix.RData  wema_1118_152_955690_matrix.RData  wema_1121_183_955690_matrix.RData

#../ibd_1015_1016.txt  ../ibd_1016_1017.txt  ../ibd_1017_1119.txt  ../ibd_1020_1021.txt  ../ibd_1116_1117.txt  ../ibd_1117_1118.txt  ../ibd_1118_1119.txt  ../ibd_pair_14.txt
#../ibd_1015_1017.txt  ../ibd_1016_1018.txt  ../ibd_1019_1021.txt  ../ibd_1114_1119.txt  ../ibd_1116_1120.txt  ../ibd_1118_1114.txt  ../ibd_1121_1122.txt

#R --slave --args file1 file2 < ~/code/code_R/CalculateGeneticValue.R

#R --slave --args 1015_marker_effect_estimation.RData wema_1015_190_955690_matrix.RData ../ibd_1015_1016.txt < ~/code/code_R/CalculateGeneticValue.R

#wema_1008_189_955690_matrix.RData 1015_1018
 
#wema_1015_190_955690_matrix.RData 1016_1018

#wema_1016_188_955690_matrix.RData 1017_1018 

#wema_1017_189_955690_matrix.RData 1018_1008

#wema_1018_189_955690_matrix.RData 1018_1008


while read line; do
f=`echo "$line"`

f11=`echo "$f" | cut -d" " -f1`
#f12=`echo "$f" | cut -d" " -f2`

echo "$f11"
#echo "$f12"

#cut -d" " -f1,2 "$f12"


R --slave --args "$f11"  < ~/CombineDiffPopulation.R

done < $1


<<EOF

R --slave --args 1015_marker_effect_estimation.RData 1008_marker_effect_estimation.RData wema_1008_189_955690_matrix.RData ../ibd_1015_1008.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args ../1016_marker_effect_estimation.RData 1008_marker_effect_estimation.RData wema_1016_188_955690_matrix.RData ../ibd_1016_1008.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args ../1016_marker_effect_estimation.RData 1008_marker_effect_estimation.RData wema_1008_189_955690_matrix.RData ../ibd_1016_1008.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args 1017_marker_effect_estimation.RData 1008_marker_effect_estimation.RData wema_1017_189_955690_matrix.RData ../ibd_1017_1008.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args 1017_marker_effect_estimation.RData 1008_marker_effect_estimation.RData wema_1008_189_955690_matrix.RData ../ibd_1017_1008.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args 1018_marker_effect_estimation.RData 1008_marker_effect_estimation.RData wema_1018_189_955690_matrix.RData ../ibd_1018_1008.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args 1018_marker_effect_estimation.RData 1008_marker_effect_estimation.RData wema_1008_189_955690_matrix.RData ../ibd_1018_1008.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args 1015_marker_effect_estimation.RData ../1016_marker_effect_estimation.RData wema_1015_190_955690_matrix.RData ../ibd_1015_1016.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args 1015_marker_effect_estimation.RData ../1016_marker_effect_estimation.RData wema_1016_188_955690_matrix.RData ../ibd_1015_1016.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args 1015_marker_effect_estimation.RData 1008_1015_1017_1018_marker_effect_estimation.RData wema_1015_190_955690_matrix.RData ../ibd_1015_1017.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args 1015_marker_effect_estimation.RData 1008_1015_1017_1018_marker_effect_estimation.RData wema_1017_189_955690_matrix.RData ../ibd_1015_1017.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args ../1016_marker_effect_estimation.RData 1008_1015_1017_1018_marker_effect_estimation.RData wema_1016_188_955690_matrix.RData ../ibd_1016_1017.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args ../1016_marker_effect_estimation.RData 1008_1015_1017_1018_marker_effect_estimation.RData wema_1017_189_955690_matrix.RData ../ibd_1016_1017.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args ../1016_marker_effect_estimation.RData 1008_1015_1017_1018_marker_effect_estimation.RData wema_1016_188_955690_matrix.RData ../ibd_1016_1018.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args ../1016_marker_effect_estimation.RData 1008_1015_1017_1018_marker_effect_estimation.RData wema_1018_189_955690_matrix.RData ../ibd_1016_1018.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args ../1119_marker_effect_estimation.RData 1008_1015_1017_1018_marker_effect_estimation.RData wema_1017_189_955690_matrix.RData ../ibd_1017_1119.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args ../1119_marker_effect_estimation.RData 1008_1015_1017_1018_marker_effect_estimation.RData wema_1119_182_955690_matrix.RData ../ibd_1017_1119.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args ../1019_marker_effect_estimation.RData ../1021_marker_effect_estimation.RData wema_1019_191_955690_matrix.RData ../ibd_1019_1021.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args ../1021_marker_effect_estimation.RData ../1019_marker_effect_estimation.RData wema_1021_190_955690_matrix.RData ../ibd_1019_1021.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args ../1020_marker_effect_estimation.RData ../1021_marker_effect_estimation.RData wema_1020_188_955690_matrix.RData ../ibd_1020_1021.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args ../1021_marker_effect_estimation.RData ../1020_marker_effect_estimation.RData wema_1021_190_955690_matrix.RData ../ibd_1020_1021.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args ../1114_marker_effect_estimation.RData ../1119_marker_effect_estimation.RData wema_1114_184_955690_matrix.RData ../ibd_1114_1119.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args ../1114_marker_effect_estimation.RData ../1119_marker_effect_estimation.RData wema_1119_182_955690_matrix.RData ../ibd_1114_1119.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args ../1116_marker_effect_estimation.RData 1117_marker_effect_estimation.RData wema_1116_184_955690_matrix.RData ../ibd_1116_1117.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args ../1116_marker_effect_estimation.RData 1117_marker_effect_estimation.RData wema_1117_128_955690_matrix.RData ../ibd_1116_1117.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args ../1116_marker_effect_estimation.RData ../1120_marker_effect_estimation.RData wema_1116_184_955690_matrix.RData ../ibd_1116_1120.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args ../1116_marker_effect_estimation.RData ../1120_marker_effect_estimation.RData wema_1120_174_955690_matrix.RData ../ibd_1116_1120.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args  1117_marker_effect_estimation.RData ../1118_marker_effect_estimation.RData wema_1117_128_955690_matrix.RData ../ibd_1117_1118.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args  1117_marker_effect_estimation.RData ../1118_marker_effect_estimation.RData wema_1118_152_955690_matrix.RData ../ibd_1117_1118.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args ../1118_marker_effect_estimation.RData ../1114_marker_effect_estimation.RData wema_1118_152_955690_matrix.RData ../ibd_1118_1114.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args ../1118_marker_effect_estimation.RData ../1114_marker_effect_estimation.RData wema_1114_184_955690_matrix.RData ../ibd_1118_1114.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args ../1118_marker_effect_estimation.RData ../1119_marker_effect_estimation.RData wema_1118_152_955690_matrix.RData ../ibd_1118_1119.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args ../1118_marker_effect_estimation.RData ../1119_marker_effect_estimation.RData wema_1119_182_955690_matrix.RData ../ibd_1118_1119.txt < ~/code/code_R/CalculateGeneticValue.R

R --slave --args ../1121_marker_effect_estimation.RData ../1122_marker_effect_estimation.RData wema_1121_183_955690_matrix.RData ../ibd_1121_1122.txt < ~/code/code_R/CalculateGeneticValue.R
R --slave --args ../1121_marker_effect_estimation.RData ../1122_marker_effect_estimation.RData wema_1122_164_955690_matrix.RData ../ibd_1121_1122.txt < ~/code/code_R/CalculateGeneticValue.R
EOF
