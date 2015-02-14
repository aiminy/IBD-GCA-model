#R --slave --args file < ~/ConcatenateIBDSegment.R
myarg <- commandArgs()
s=length(myarg)
#cat(s,"\n")

ff <- myarg[4:4]
cat(ff,"\n")

ibd.segment.bw.pop<-read.table(ff,header=F)

unique.pop.pair<-unique(as.character(ibd.segment.bw.pop[,2]))

ibd.segment.bw.pop.2<-ibd.segment.bw.pop[which(ibd.segment.bw.pop[,2]==unique.pop.pair[1]),]

ibd.index<-seq(from = as.integer(ibd.segment.bw.pop.2[1,3]), to = as.integer(ibd.segment.bw.pop.2[1,4]))

for(j in 2:dim(ibd.segment.bw.pop.2)[1]){

ibd.index<-c(ibd.index,seq(from=as.integer(ibd.segment.bw.pop.2[j,3]),to=as.integer(ibd.segment.bw.pop[j,4])))

}

pop.pair.ibd.index<-as.data.frame(cbind(rep(unique.pop.pair[1],length(ibd.index)),ibd.index))

if(length(unique.pop.pair)>1){

for(i in 2:length(unique.pop.pair)){

ibd.segment.bw.pop.2<-ibd.segment.bw.pop[which(ibd.segment.bw.pop[,2]==unique.pop.pair[i]),]


ibd.index<-seq(from = as.integer(ibd.segment.bw.pop.2[1,3]), to = as.integer(ibd.segment.bw.pop.2[1,4]))


for(j in 2:dim(ibd.segment.bw.pop.2)[1]){

ibd.index<-c(ibd.index,seq(from=as.integer(ibd.segment.bw.pop.2[j,3]),to=as.integer(ibd.segment.bw.pop[j,4])))

}

pop.pair.ibd.index<-rbind(pop.pair.ibd.index,as.data.frame(cbind(rep(unique.pop.pair[i],length(ibd.index)),ibd.index)))

}

}

cat(dim(pop.pair.ibd.index)[1],"\n")

write.table(pop.pair.ibd.index,file=paste(ff,"_out_2.txt",sep=""),append=FALSE,quote=FALSE,row.names=FALSE,col.names=FALSE)






