myarg <- commandArgs()
#cat(s,"\n")

f1 <- myarg[4:4] 
ff <- myarg[5:5]

pop.coverage<-read.table(f1,header=F)
pop.marker<-unique(as.character(pop.coverage[,1]))

load("~/Marker_effect_estimation/CombinedMarkerEffectEstimation.RData")

dim(combined.marker.estimation)


target.pop.marker.index<-array()
target.pop.marker.estimation<-array()


for(i in 1:length(pop.marker)){

#cat(as.numeric(pop.marker[i]),"\t",length(pop.coverage[which(pop.coverage[,1]==pop.marker[i]),4]),"\t")

target.pop.marker.index<-c(target.pop.marker.index,as.numeric(pop.marker[i]))

#cat(which(colnames(combined.marker.estimation) %in% pop.coverage[which(pop.coverage[,1]==pop.marker[i]),4]),"\t")

mapped.pop.index<-which(colnames(combined.marker.estimation) %in% pop.coverage[which(pop.coverage[,1]==pop.marker[i]),4])
#cat(colnames(combined.marker.estimation)[mapped.pop.index],"\t")

#cat(combined.marker.estimation[as.numeric(pop.marker[i]),mapped.pop.index],"\t",mean(combined.marker.estimation[as.numeric(pop.marker[i]),mapped.pop.index]),"\n")





#combined,.marker.estimation[as.numeric(pop.marker[i]),which(colnames(combined.marker.estimation) == pop.coverage[which(pop.coverage[,1]==pop.marker[i]),4][1])]
target.pop.marker.estimation<-c(target.pop.marker.estimation,mean(combined.marker.estimation[as.numeric(pop.marker[i]),mapped.pop.index]))
#combined.marker.estimation[as.numeric(pop.marker[i]),which(colnames(combined.marker.estimation) == pop.coverage[which(pop.coverage[,1]==pop.marker[i]),4][2])]
#combined.marker.estimation[as.numeric(pop.marker[i]),which(colnames(combined.marker.estimation) == pop.coverage[which(pop.coverage[,1]==pop.marker[i]),4][3])]

}

target.pop.marker.index.estimation<-cbind(target.pop.marker.index,target.pop.marker.estimation)

load(ff)

tartget.marker.gbs.data.ibd.part<-(data.marker.m[,target.pop.marker.index.estimation[,1]])

target.pop.ibd.gca.trait.prediction<-tartget.marker.gbs.data.ibd.part%*%target.pop.marker.index.estimation[,2]

cat(cor(target.pop.ibd.gca.trait.prediction,Phenotype.Y.2[,2]),"\n")
