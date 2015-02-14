#R --slave < ~/RunCrossValidationBackground_2.R&
load("Pop_19_data_after_qc.RData")

library(rrBLUP)

Tester_CML_data_index<-unique(pop.acc.height.after.qc.snp[,1])

#CrossValidation<-function(Tester_CML_data_index,data.tester.title.snp){

#for(i in 1:length(Tester_CML_data_index)){

#validation.index<-Tester_CML_data_index[which(Tester_CML_data_index %in% Tester_CML_data_index[i])]
#training.index<-Tester_CML_data_index[-which(Tester_CML_data_index %in% Tester_CML_data_index[i])]

data.tester.title.snp<-pop.acc.height.after.qc.snp

#validation.index<-Tester_CML_data_index[which(Tester_CML_data_index %in% Tester_CML_data_index[i])]
#training.index<-Tester_CML_data_index[-which(Tester_CML_data_index %in% Tester_CML_data_index[i])]
#Tester_CML_395_444=c(1008,1015,1016,1017,1018,1019,1020,1021,1023,1028,1119)
#Tester_CML_312_442=c(1115,1116,1117,1118,1120,1121,1122,1114)

#validation.index<-c(1023)
#training.index<-c(1008,1015,1016,1017,1018,1019,1020,1021,1028,1119)

MarkerEffectEstimation<-function(training.index,data.tester.title.snp){
#print(validation.index)
#print(training.index)
#validation.data.index<-which(data.tester.title.snp[,1] %in% validation.index)
training.data.index<-which(data.tester.title.snp[,1] %in% training.index)

#print(validation.data.index)
#print(training.data.index)

#marker.effect.estimation <- mixed.solve(data.tester.395.444.title.snp[,3],Z=data.tester.395.444.title.snp[,4:dim(data.tester.395.444.title.snp)[2]])

marker.effect.estimation <- mixed.solve(data.tester.title.snp[training.data.index,3],Z=data.tester.title.snp[training.data.index,4:dim(data.tester.title.snp)[2]])

#validation.data.y.hat<-as.matrix(data.tester.title.snp[validation.data.index,4:dim(data.tester.title.snp)[2]])%*%marker.effect.estimation$u

#cat(validation.index,"\t",cor(data.tester.title.snp[validation.data.index,3],validation.data.y.hat),"\n")

return(marker.effect.estimation)
}

CrossValidation<-function(validation.index,training.index,data.tester.title.snp){
#print(validation.index)
#print(training.index)
#print(validation.data.index)
#print(training.data.index)

#marker.effect.estimation <- mixed.solve(data.tester.395.444.title.snp[,3],Z=data.tester.395.444.title.snp[,4:dim(data.tester.395.444.title.snp)[2]])
validation.data.index<-which(data.tester.title.snp[,1] %in% validation.index)
training.data.index<-which(data.tester.title.snp[,1] %in% training.index)

marker.effect.estimation <- MarkerEffectEstimation(training.index,data.tester.title.snp)

validation.data.y.hat<-as.matrix(data.tester.title.snp[validation.data.index,4:dim(data.tester.title.snp)[2]])%*%marker.effect.estimation$u

cat(validation.index,"\t",cor(data.tester.title.snp[validation.data.index,3],validation.data.y.hat),"\n")

#return(marker.effect.estimation)

}


sink("Pop_19_CV_results.txt")

for(i in 1:length(Tester_CML_data_index)){
validation.index<-Tester_CML_data_index[which(Tester_CML_data_index %in% Tester_CML_data_index[i])]
training.index<-Tester_CML_data_index[-which(Tester_CML_data_index %in% Tester_CML_data_index[i])]
CrossValidation(validation.index,training.index,data.tester.title.snp)
}

sink()

q("no")
#validation.index<-c(1023)
#training.index<-c(1008,1015,1016,1017,1018,1019,1020,1021,1028,1119)

#marker.effect.for.1023<-MarkerEffectEstimation(training.index,data.tester.395.444.title.snp)









