#! /bin/bash

#pipline for running gbs gatk pipeline
#
# run_gbs.sh  $basedir barcode.txt $num_of_processors
#
###################
##

#input_file-directory=$1
cd $1
barcode=`echo $2|sed 's/.*\///g'`
CPU=$3

#cat all fastq files with same barcoding together
for file in `dir -d *.fastq`; do
    debar=`echo $file |sed 's/.fastq/_%_debar.fastq/g'`
    fastq-multx -B $barcode $file -o $debar
done

#run bowtie2
for file in `dir -d *debar.fastq`; do
    samfile=`echo "$file" | sed 's/.fastq/.sam/'`
    bowtie2 -p $CPU -x /home/srs57/Coffea/DH200-94/pseudomolecules -U $file -S $samfile
done

#Convert sam to sorted bam
for file in `dir -d *.sam`; do
    bamfile=`echo "$file" |sed 's/.sam/.sort/'`
    samtools import /home/srs57/Coffea/DH200-94/pseudomolecules.fa $file - |samtools view -bq 20 - |samtools sort - $bamfile &
    let count+=1
    [[ $((count%CPU)) -eq 0 ]] && wait
done

#mark duplicate reads
for file in `dir -d *.sort.bam`; do
    outfile=`echo "$file" |sed 's/.bam/.md.bam/'`
    java -Djava.io.tmpdir=`pwd`~/tmp -jar ~/programs/picard-tools-1.118/MarkDuplicates.jar INPUT=$file OUTPUT=$outfile METRICS_FILE=$file.metrics REMOVE_DUPLICATES=false ASSUME_SORTED=true VALIDATION_STRINGENCY=SILENT MAX_RECORDS_IN_RAM=5000000 &
    let count+=1
    [[ $((count%CPU)) -eq 0 ]] && wait
done

#add read groups
for file in `dir -d *.md.bam`; do
    outfile=`echo "$file" |sed 's/.bam/.rg.bam/'`
    java -Djava.io.tmpdir=`pwd`~/tmp -jar ~/programs/picard-tools-1.118/AddOrReplaceReadGroups.jar INPUT=$file OUTPUT=$outfile SORT_ORDER=coordinate RGID=$outfile RGLB=1 RGPL=GBS RGPU=run RGSM=$outfile RGCN=BRC RGDS=$outfile &
    let count+=1
    [[ $((count%CPU)) -eq 0 ]] && wait
done

find `pwd` -name "*.rg.bam" -exec samtools index {} \;

#Find targets for realignment
for file in `dir -d *.rg.bam`; do
    outfile=`echo "$file" |sed 's/.bam/.intervals/'`
    java -jar ~/programs/GenomeAnalysisTK.jar -T RealignerTargetCreator -R /home/srs57/Coffea/DH200-94/pseudomolecules.fa  -nt $CPU -I $file  -o $outfile &
    let count+=1
    [[ $((count%CPU)) -eq 0 ]] && wait
done

#Realign targets
for file in `dir -d *.rg.bam`; do
    outfile=`echo "$file" |sed 's/.bam/.ir.bam/'`
    intervals=`echo "$file" |sed 's/.bam/.intervals/'`
    java -jar ~/programs/GenomeAnalysisTK.jar -T IndelRealigner -R /home/srs57/Coffea/DH200-94/pseudomolecules.fa  -I $file  -targetIntervals $intervals  -o $outfile &
    let count+=1
    [[ $((count%CPU)) -eq 0 ]] && wait
done

#A header file needs to be created 
find -name *ir.bam -exec samtools view -H {} >> header

#The header then needs to be formated ex: @HD     VN:1.4  GO:none SO:coordinate
#                                         @SQ     SN:chr1 LN:38193400
#                                         @SQ     SN:chr10        LN:27624748
#                                         @RG     ID:C56Y8ACXX_2_S17Lib2.sort.bam.md      PL:GBS  PU:run  LB:1    DS:C56Y8ACXX_2_S17Lib2.sort.bam.md      SM:C56Y8ACXX_2_S17Lib2.sort.bam.md      CN:weill
#                                         @RG     ID:C3KB2ACXX_8_5_2_debar.sort.md.rg.bam PL:GBS  PU:run  LB:1    DS:C3KB2ACXX_8_5_2_debar.sort.md.rg.bam SM:C3KB2ACXX_8_5_2_debar.sort.md.rg.bam CN:BRC
#                                         @PG     ID:MarkDuplicates       PN:MarkDuplicates       VN:1.118(2329276ea55d31ab6b19bab55b9ee7b51e4a446e_1406559781)   CL:picard.sam.MarkDuplicates INPUT=[C3KB2ACXX_5_Blue_Montain_debar.sort.bam] OUTPUT=C3KB2ACXX_5_Blue_Montain_debar.sort.md.bam METRICS_FILE=C3KB2ACXX_5_Blue_Montain_debar.sort.bam.metrics REMOVE_DUPLICATES=false ASSUME_SORTED=true VALIDATION_STRINGENCY=SILENT    PROGRAM_RECORD_ID=MarkDuplicates PROGRAM_GROUP_NAME=MarkDuplicates MAX_SEQUENCES_FOR_DISK_READ_ENDS_MAP=50000 MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=8000 SORTING_COLLECTION_SIZE_RATIO=0.25 READ_NAME_REGEX=[a-zA-Z0-9]+:[0-9]:([0-9]+):([0-9]+):([0-9]+).* OPTICAL_DUPLICATE_PIXEL_DISTANCE=100 VERBOSITY=INFO QUIET=false COMPRESSION_LEVEL=5 MAX_RECORDS_IN_RAM=500000 CREATE_INDEX=false CREATE_MD5_FILE=false
#                                         @PG     ID:bowtie2      PN:bowtie2      VN:2.2.3        CL:"/usr/local/bin/bowtie2-align-s --wrapper basic-0 -p 50 -x /home/srs57/Coffea/DH200-94/pseudomolecules -S C3KB2ACXX_5_Blue_Montain_debar.sam -U C3KB2ACXX_5_Blue_Montain_debar.fastq"
#                                         @PG     ID:GATK IndelRealigner  CL:knownAlleles=[] targetIntervals=C3KB2ACXX_5_Blue_Montain_debar.sort.md.rg.intervals LODThresholdForCleaning=5.0 consensusDeterminationModel=USE_READS entropyThreshold=0.15 maxReadsInMemory=150000 maxIsizeForMovement=3000 maxPositionalMoveAllowed=200 maxConsensuses=30 maxReadsForConsensuses=120 maxReadsForRealignment=20000 noOriginalAlignmentTags=false nWayOut=null generate_nWayOut_md5s=false check_early=false noPGTag=false keepPGTags=false indelsFileForDebugging=null statisticsFileForDebugging=null SNPsFileForDebugging=null


#merge bam files
#find $1 -name "*.ir.bam" -exec samtools merge -h header.txt $1/all_gbs_merged.bam {} \;
#sort all_gbs_merged.bam all_gbs_merged.sort

#Call SNPs
#java -jar ~/Coffea/GenomeAnalysisTK.jar -T HaplotypeCaller -R /home/srs57/Coffea/DH200-94/pseudomolecules.fa  -nct $CPU -I $1/all_gbs_merged.sort.bam -o $1/all_gbs_merged.vcf


