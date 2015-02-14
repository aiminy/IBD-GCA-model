#R --slave --args wema_1008_189_955690_new_matrix.RData < ~/code/code_R/CombineDiffPopulation.R

#library(gdata)
#to use
#myarg <- commandArgs()
#cat(myarg,"\n")
#m=length(myarg)
#f_index<-myarg[4:4]
#ff <- myarg[4:m]

load("Pop_16.RData")

myarg = commandArgs()
s=length(myarg)
cat(s,"\n")

ff1 <- myarg[4:4]
load(ff1)
#ff3 <- myarg[6:6]
#ff4 <- myarg[7:7]

cat(substr(ff1,6,9),"\n")
#cat(substr(ff2,6,29),"\n")

population.name<-rep(substr(ff1,6,9),dim(Phenotype.Y.2)[1])
pop.acc.height<-cbind(population.name,Phenotype.Y.2)
pop.acc.height.snp<-cbind(pop.acc.height,data.marker.m)
colnames(pop.acc.height.snp)[1:3]=c("pop.name","acc","height")

temp<-data.frame()

#
pop.acc.height.snp.16<-rbind(pop.acc.height.snp.16,pop.acc.height.snp)
HowmanyPop<-length(unique(pop.acc.height.snp.16[,1]))


save(pop.acc.height.snp.16,file="Pop_16.RData")

#save(pop.acc.height.snp.16,file=paste("Pop_",HowmanyPop,".RData",sep=""))
#write.table(colnames(pop.acc.height.snp),file = "16_population_combined_title.txt", append = FALSE, quote = FALSE, sep = "\t",row.names = F,col.names = F)
#write.table(pop.acc.height.snp,file = "16_population_combined.txt", append = TRUE, quote = FALSE, sep = "\t",row.names = F,col.names = F)
