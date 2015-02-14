#R --slave --args 1021_at_c1_file.txt < ~/OptimizedCalculateCoverage.R
FindMappingForOnePair<-function(ca.1021){


sorted.ca.1021<-ca.1021[order(ca.1021[,4]),]

mapp.count<-rep(0,955690)

for(i in 1:955690){


mapped.segment<-sorted.ca.1021[which(sorted.ca.1021[,4]<=i&sorted.ca.1021[,5]>=i),]


#print(mapped.segment)

num=dim(mapped.segment)[1]

if(num!=0){
mapp.count[i]=num

#print(mapped.segment)


#cat(i,"\t",length(mapped.segment[,3]),"\n")

target.pop<-mapped.segment[,2]
mapped.pop<-mapped.segment[,3]
mapped.start<-mapped.segment[,4]
mapped.end<-mapped.segment[,5]
mapped.start.end<-c(mapped.start,mapped.end)

mapped.start.end.sorted<-mapped.start.end[order(mapped.start.end)]

cat(i,"\t",length(mapped.segment[,3]),"\t",target.pop,"\t",mapped.pop,"\t",mapped.start.end,"\t",mapped.start.end.sorted,"\t",unique(target.pop),"\t",unique(mapped.pop),"\t",min(mapped.start.end.sorted),"\t",max(mapped.start.end.sorted),"\n")

}


}

cat(substr(ff,1,4),length(which(mapp.count!=0)),"\n")


}

myarg = commandArgs()

ff <- myarg[4:4]

#cat(ff,"\n")

ca.1021<-read.table(ff,header=F)



if(length(unique(ca.1021[,3]))==1){

FindMappingForOnePair(ca.1021)

}else
{
cat("multiple poplation","\n")

mapped.pop=unique(as.character(ca.1021[,3]))
m=length(mapped.pop)

for(i in 1:m){

ca.1021.single.pop<-ca.1021[which(as.character(ca.1021[,3])==mapped.pop[i]),]

FindMappingForOnePair(ca.1021.single.pop)

}



}


