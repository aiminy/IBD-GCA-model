CalculateMissingRate<-function(a){

missing.rate=length(which(a=="-9"|a=="+"))/length(a)

return(missing.rate)
}


CalculateMAF<-function(a){

#a<-a[-which(a=="+"|a=="-9")]

AA=length(which(a=="-1"))
Aa=length(which(a=="0"))
aa=length(which(a=="1"))

Freq.A=(AA*2+Aa*1+aa*0)/(2*length(a))
Freq.a=(aa*2+Aa*1+AA*0)/(2*length(a))


MAF<-list()
MAF[[1]]<-Freq.A
MAF[[2]]<-Freq.a
MAF[[3]]<-min(Freq.A,Freq.a)

return(MAF[[3]])

}


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


load("Pop_19.RData")

data.new<-pop.acc.height.snp.16[,3:dim(pop.acc.height.snp.16)[2]]

#Missing.rate.by.acc<-apply(data.new,1,CalculateMissingRate)
Missing.rate.by.snp<-apply(data.new,2,CalculateMissingRate)

data.new.missing.rate.less.than.01<-data.new[,which(Missing.rate.by.snp<0.1)]

MAF.by.snp<-apply(data.new.missing.rate.less.than.01,2,CalculateMAF)

data.new.missing.rate.less.than.01.maf.greater.than.005<-data.new.missing.rate.less.than.01[,which(MAF.by.snp>0.05)]

data.new.missing.rate.less.than.01.maf.greater.than.005.imputation<-apply(data.new.missing.rate.less.than.01.maf.greater.than.005,2,ImputeSnp)

pop.acc.height.after.qc.snp<-cbind(pop.acc.height.snp.16[,1:3],data.new.missing.rate.less.than.01.maf.greater.than.005.imputation)

save(pop.acc.height.after.qc.snp,file="Pop_19_data_after_qc.RData")
save.image(file="Pop_19_data_after_qc_all.RData")
savehistory(file = "Pop_19_data_after_qc_all.Rhistory")





