#to use
#R --slave --args file < ~/code/code_R/ProcessTwoGBSFilesForEachAcc3.R

myarg <- commandArgs()
s=length(myarg)
#cat(s,"\n")

ff <- myarg[4:4]
cat(ff,"\n")

load(ff)

nm=dim(wema.1.2)[1]
nm2=dim(wema.1.2)[2]

cat(nm,nm2,"\n")

for (i in 1:nm){

n=length(unique(as.numeric(wema.1.2[i,])))

cat(i,n,"\n")
cat(i,unique(as.character(wema.1.2[i,])),"\n")
wema.1.2[i,which(wema.1.2[i,]=="+")]="-9"

}

wema.acc.name<-rownames(wema.1.2)
wema.1.2.m<-matrix(as.numeric(wema.1.2),nm,955690)
save(wema.acc.name,wema.1.2.m,file=paste("wema_",substr(ff,6,9),"_",nm,"_",nm2,"_matrix_with_acc_names.RData",sep=""))
q("no")
