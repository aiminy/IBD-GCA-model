
ImputeSnp<-function(a){

FreqMinusOne=(length(which(a==-1))/length(a))

FreqZero=(length(which(a==0))/length(a))

FreqOne=(length(which(a==1))/length(a))

d1=c(-1,0,1)
d2=c(FreqMinusOne,FreqZero,FreqOne)

W<-d1[which.max(d2)]

a[which(a==-9)]=W
return(a)

}

Tester_CML_395_444=c(1008,1015,1016,1017,1018,1019,1020,1021,1023,1028,1119)
Tester_CML_312_442=c(1115,1116,1117,1118,1120,1121,1122,1114)

Index_Tester_CML_395_444<-which(pop.acc.height.snp.16[,1] %in% Tester_CML_395_444)
Index_Tester_CML_312_442<-which(pop.acc.height.snp.16[,1] %in% Tester_CML_312_442)

data.tester.395.444<-pop.acc.height.snp.16.remove.missing.snp.maf.005.imputation[Index_Tester_CML_395_444,]
data.tester.312.442<-pop.acc.height.snp.16.remove.missing.snp.maf.005.imputation[Index_Tester_CML_312_442,]

data.tester.395.444.title<-pop.acc.height.snp.16[Index_Tester_CML_395_444,1:3]
data.tester.312.442.title<-pop.acc.height.snp.16[Index_Tester_CML_312_442,1:3] 

data.tester.395.444.title.snp<-cbind(data.tester.395.444.title,data.tester.395.444)
data.tester.312.442.title.snp<-cbind(data.tester.312.442.title,data.tester.312.442)

pop.acc.height.snp.16.remove.missing.snp.maf.005.imputation.title<-cbind(pop.acc.height.snp.16[,1:3],pop.acc.height.snp.16.remove.missing.snp.maf.005.imputation)



dim(data.tester.395.444.title.snp)

library(rrBLUP)


Tester_CML_395_444=c(1008,1015,1016,1017,1018,1019,1020,1021,1023,1028,1119)

for(i in 1:length(Tester_CML_395_444)){

validation.index<-Tester_CML_395_444[which(Tester_CML_395_444 %in% Tester_CML_395_444[i])]
training.index<-Tester_CML_395_444[-which(Tester_CML_395_444 %in% Tester_CML_395_444[i])]


#print(validation.index)
#print(training.index)
validation.data.index<-which(data.tester.395.444.title.snp[,1] %in% validation.index) 
training.data.index<-which(data.tester.395.444.title.snp[,1] %in% training.index)

#print(validation.data.index)
#print(training.data.index)

#marker.effect.estimation <- mixed.solve(data.tester.395.444.title.snp[,3],Z=data.tester.395.444.title.snp[,4:dim(data.tester.395.444.title.snp)[2]])

marker.effect.estimation <- mixed.solve(data.tester.395.444.title.snp[training.data.index,3],Z=data.tester.395.444.title.snp[training.data.index,4:dim(data.tester.395.444.title.snp)[2]])

validation.data.y.hat<-as.matrix(data.tester.395.444.title.snp[validation.data.index,4:dim(data.tester.395.444.title.snp)[2]])%*%marker.effect.estimation$u

cat(Tester_CML_395_444[i],"\t",cor(data.tester.395.444.title.snp[validation.data.index,3],validation.data.y.hat),"\n")

}


for(i in 1:length(Tester_CML_312_442)){

validation.index<-Tester_CML_312_442[which(Tester_CML_312_442 %in% Tester_CML_312_442[i])]
training.index<-Tester_CML_312_442[-which(Tester_CML_312_442 %in% Tester_CML_312_442[i])]


#print(validation.index)
#print(training.index)
validation.data.index<-which(data.tester.312.442.title.snp[,1] %in% validation.index)
training.data.index<-which(data.tester.312.442.title.snp[,1] %in% training.index)

#print(validation.data.index)
#print(training.data.index)

#marker.effect.estimation <- mixed.solve(data.tester.395.444.title.snp[,3],Z=data.tester.395.444.title.snp[,4:dim(data.tester.395.444.title.snp)[2]])

marker.effect.estimation <- mixed.solve(data.tester.312.442.title.snp[training.data.index,3],Z=data.tester.312.442.title.snp[training.data.index,4:dim(data.tester.312.442.title.snp)[2]])

validation.data.y.hat<-as.matrix(data.tester.312.442.title.snp[validation.data.index,4:dim(data.tester.312.442.title.snp)[2]])%*%marker.effect.estimation$u

cat(Tester_CML_312_442[i],"\t",cor(data.tester.312.442.title.snp[validation.data.index,3],validation.data.y.hat),"\n")

}

#ans.1018 <- mixed.solve(wema.6x1018.Y[,2],Z=wema.1018.m)

Tester_CML_395_444_312_442=c(1008,1015,1016,1017,1018,1019,1020,1021,1119,1116,1117,1118,1120,1121,1122,1114)

for(i in 1:length(Tester_CML_395_444_312_442)){

validation.index<-Tester_CML_395_444_312_442[which(Tester_CML_395_444_312_442 %in% Tester_CML_395_444_312_442[i])]
training.index<-Tester_CML_395_444_312_442[-which(Tester_CML_395_444_312_442 %in% Tester_CML_395_444_312_442[i])]


#print(validation.index)
#print(training.index)
validation.data.index<-which(pop.acc.height.snp.16.remove.missing.snp.maf.005.imputation.title[,1] %in% validation.index)
training.data.index<-which(pop.acc.height.snp.16.remove.missing.snp.maf.005.imputation.title[,1] %in% training.index)

#print(validation.data.index)
#print(training.data.index)

#marker.effect.estimation <- mixed.solve(data.tester.395.444.title.snp[,3],Z=data.tester.395.444.title.snp[,4:dim(data.tester.395.444.title.snp)[2]])

marker.effect.estimation <- mixed.solve(pop.acc.height.snp.16.remove.missing.snp.maf.005.imputation.title[training.data.index,3],Z=pop.acc.height.snp.16.remove.missing.snp.maf.005.imputation.title[training.data.index,4:dim(pop.acc.height.snp.16.remove.missing.snp.maf.005.imputation.title)[2]])

validation.data.y.hat<-as.matrix(pop.acc.height.snp.16.remove.missing.snp.maf.005.imputation.title[validation.data.index,4:dim(pop.acc.height.snp.16.remove.missing.snp.maf.005.imputation.title)[2]])%*%marker.effect.estimation$u

cat(Tester_CML_395_444_312_442[i],"\t",cor(pop.acc.height.snp.16.remove.missing.snp.maf.005.imputation.title[validation.data.index,3],validation.data.y.hat),"\n")

}
















