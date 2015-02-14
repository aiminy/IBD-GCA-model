#R --slave --args wema_1008_189_955690.RData ../WEMA_6x1008_Plant_Height_Y.txt < ~/code/code_R/CalculateGeneticValue2.R

#library(gdata)
#to use
#myarg <- commandArgs()
#cat(myarg,"\n")
#m=length(myarg)
#f_index<-myarg[4:4]
#ff <- myarg[4:m]

myarg = commandArgs()
s=length(myarg)
cat(s,"\n")

ff1 <- myarg[4:4]
ff2 <- myarg[5:5]
#ff3 <- myarg[6:6]
#ff4 <- myarg[7:7]

cat(substr(ff1,6,9),"\n")
cat(substr(ff2,6,29),"\n")

load(ff1)
#load(ff2)
#load(ff3)

#str(all.element[[1]])

#dim(ans.1114$u)

#dim(all.element[1]$u)

#print(ls(pattern=substr(ff4,8,11)))
#print(ls(pattern=substr(ff4,13,16)))

#estimation.1<-ls(pattern=substr(ff4,8,11))
#print(estimation.1)
#cat(length(get(estimation.1)$u),"\n")

#estimation.2<-ls(pattern=substr(ff4,13,16))
#print(estimation.2)
#cat(length(get(estimation.2)$u),"\n")

Phenotype.Y<-read.table(ff2,header=F)

print(Phenotype.Y)

if(length(ls(pattern=paste("wema.","1.","2",sep="")))==1){
data.marker<-ls(pattern=paste("wema.","1.","2",sep=""))
} else if(length(ls(pattern=paste("wema.",substr(ff1,6,9),".t",sep="")))==1){
data.marker<-ls(pattern=paste("wema.",substr(ff1,6,9),".t",sep=""))
} else{
data.marker<-ls(pattern=paste("wema.",substr(ff1,6,9),sep=""))
}

#print(data.marker)
#print(rownames(get(data.marker)))

#cat(dim(get(data.marker)),"\n")

Match.GBS.2.Trait <- function(gbs,trait) {

wema.acc.name<-rownames(gbs)

m=length(wema.acc.name)

match_index<-array()

match_index<-which(substr(trait[,1],23,28)==substr(wema.acc.name,23,28)[1])

for(i in 2:m){

match_index<-c(match_index,which(substr(trait[,1],23,28)==substr(wema.acc.name,23,28)[i]))

}

trait.2<-trait[c(match_index),]


return(trait.2)

}

Phenotype.Y.2<-Match.GBS.2.Trait(get(data.marker),Phenotype.Y)

cat("gbs_length:",length(rownames(get(data.marker))),"\n")
cat("before_match:",dim(Phenotype.Y),"\n")
cat("after_match:",dim(Phenotype.Y.2),"\n")


gbs_n=dim(get(data.marker))[1]
gbs_m=dim(get(data.marker))[2]



data.new<-get(data.marker)

for (i in 1:gbs_n){
data.new[i,which(data.new[i,]=="+")]="-9"
}

data.marker.m<-matrix(as.numeric(data.new),gbs_n,gbs_m)


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


#result<-list()

Missing.rate.by.acc<-apply(data.new,1,CalculateMissingRate)
Missing.rate.by.snp<-apply(data.new,2,CalculateMissingRate)

#result[[1]]<-data.new
#result[[2]]<-Phenotype.Y.2
#result[[3]]<-Missing.rate.by.acc
#result[[4]]<-Missing.rate.by.snp

cat("BY_ACC","\t",range(Missing.rate.by.acc)[1],"\t",range(Missing.rate.by.acc)[2],"\t",mean(Missing.rate.by.acc),"\n")
cat("BY_SNP","\t",range(Missing.rate.by.snp)[1],"\t",range(Missing.rate.by.acc)[2],"\t",mean(Missing.rate.by.snp),"\n")
cat("Filter_less_01",length(which(Missing.rate.by.snp<0.1)),"\n")

#save(data.new,Phenotype.Y.2,Missing.rate.by.acc,Missing.rate.by.snp,file=paste("wema_",substr(ff1,6,9),"_",gbs_n,"_",gbs_m,"_new.RData",sep=""))
save(data.marker.m,Phenotype.Y.2,Missing.rate.by.acc,Missing.rate.by.snp,file=paste("wema_",substr(ff1,6,9),"_",gbs_n,"_",gbs_m,"_new_matrix.RData",sep=""))
#ibd.index<-paste("ibd.",substr(ff4,8,11),".",substr(ff4,13,16),sep="")

#ibd.index<-read.table(ff4,header=F)

#dim(ibd.index)

#ibd.segments<-read.table(ff4,header=F)
#nm=dim(ibd.segments)[1]

#ibd.index<-seq(from = as.integer(ibd.segments[1,3]), to = as.integer(ibd.segments[1,4]))

#for(i in 2:nm){

#ibd.index<-c(ibd.index,seq(from=as.integer(ibd.segments[i,3]),to=as.integer(ibd.segments[i,4])))
#
#}

#all.id<-seq(1,955690,1)

#all.non.ibd.id<-setdiff(all.id,ibd.index)


#ll(dim=TRUE)

#cat(length(ibd.index),"\n")

#print(ls())

#For 1114 from 1114 
#genetic.value.all.for.estimation.1.from.estimation.1<-get(data.marker)%*%get(estimation.1)$u
#genetic.value.ibd.for.estimation.1.from.estimation.1<-get(data.marker)[,ibd.index]%*%get(estimation.1)$u[ibd.index]
#genetic.value.non.ibd.for.estimation.1.from.estimation.1<-get(data.marker)[,-ibd.index]%*%get(estimation.1)$u[-ibd.index]

#For 1114 from 1119 
#genetic.value.all.for.estimation.1.from.estimation.2<-get(data.marker)%*%get(estimation.2)$u
#genetic.value.ibd.for.estimation.1.from.estimation.2<-get(data.marker)[,ibd.index]%*%get(estimation.2)$u[ibd.index]
#genetic.value.non.ibd.for.estimation.1.from.estimation.2<-get(data.marker)[,-ibd.index]%*%get(estimation.2)$u[-ibd.index]

#cc.all<-cor(genetic.value.all.for.estimation.1.from.estimation.1,genetic.value.all.for.estimation.1.from.estimation.2)
#cc.ibd<-cor(genetic.value.ibd.for.estimation.1.from.estimation.1,genetic.value.ibd.for.estimation.1.from.estimation.2)
#cc.non.ibd<-cor(genetic.value.non.ibd.for.estimation.1.from.estimation.1,genetic.value.non.ibd.for.estimation.1.from.estimation.2)

#cc.non.ibd.random<-array()

#all.non.ibd.id.random.sampling<-sample(all.non.ibd.id,length(ibd.index))
#genetic.value.non.ibd.for.estimation.1.from.estimation.1.random.sampling<-get(data.marker)[,all.non.ibd.id.random.sampling]%*%get(estimation.1)$u[all.non.ibd.id.random.sampling]
#genetic.value.non.ibd.for.estimation.1.from.estimation.2.random.sampling<-get(data.marker)[,all.non.ibd.id.random.sampling]%*%get(estimation.2)$u[all.non.ibd.id.random.sampling]
#cc.non.ibd.random[1]<-cor(genetic.value.non.ibd.for.estimation.1.from.estimation.1.random.sampling,genetic.value.non.ibd.for.estimation.1.from.estimation.2.random.sampling)

#for(i in 2:50){
#all.non.ibd.id.random.sampling<-sample(all.non.ibd.id,length(ibd.index))
#genetic.value.non.ibd.for.estimation.1.from.estimation.1.random.sampling<-get(data.marker)[,all.non.ibd.id.random.sampling]%*%get(estimation.1)$u[all.non.ibd.id.random.sampling]
#genetic.value.non.ibd.for.estimation.1.from.estimation.2.random.sampling<-get(data.marker)[,all.non.ibd.id.random.sampling]%*%get(estimation.2)$u[all.non.ibd.id.random.sampling]
#cc.non.ibd.random[i]<-cor(genetic.value.non.ibd.for.estimation.1.from.estimation.1.random.sampling,genetic.value.non.ibd.for.estimation.1.from.estimation.2.random.sampling)
#}

#p.value<-length(which(cc.non.ibd.random>=cc.ibd[1]))/50

#cat(substr(ff4,8,11),substr(ff4,13,16),"ibd_snp:",cc.ibd,"\n")
#cat(substr(ff4,8,11),substr(ff4,13,16),"non_ibd:",cc.non.ibd,"\n")
#cat(substr(ff4,8,11),substr(ff4,13,16),"all_snp:",cc.all,"\n")
#cat(substr(ff4,8,11),substr(ff4,13,16),"p_value:",p.value,"\n")

#cat("all_snp:",cor(genetic.value.all.for.1021.from.1021,genetic.value.all.for.1021.from.1020),"\n")
#cat("ibd_snp:",cor(genetic.value.ibd.for.1021.from.1021,genetic.value.ibd.for.1021.from.1020),"\n")
#cat("non_ibd:",cor(genetic.value.non.ibd.for.1021.from.1021,genetic.value.non.ibd.for.1021.from.1020),"\n")

#print(ls(pattern=substr(ff4,8,11)))
#print(ls(pattern=substr(ff4,13,16)))

#For 1017 from 1017 
#genetic.value.all.for.1017.from.1017<-wema.1017.m%*%ans.1017$u
#genetic.value.ibd.for.1017.from.1017<-wema.1017.m[,ibd.index.1015.1016]%*%ans.1017$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1017.from.1017<-wema.1017.m[,-ibd.index.1015.1016]%*%ans.1017$u[-ibd.index.1015.1016]

#For 1017 from 1119 
#genetic.value.all.for.1017.from.1119<-wema.1017.m%*%ans.1119$u
#genetic.value.ibd.for.1017.from.1119<-wema.1017.m[,ibd.index.1015.1016]%*%ans.1119$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1017.from.1119<-wema.1017.m[,-ibd.index.1015.1016]%*%ans.1119$u[-ibd.index.1015.1016]

#cor(genetic.value.all.for.1017.from.1017,genetic.value.all.for.1017.from.1119)
#cor(genetic.value.ibd.for.1017.from.1017,genetic.value.ibd.for.1017.from.1119)
#cor(genetic.value.non.ibd.for.1017.from.1017,genetic.value.non.ibd.for.1017.from.1119)


#For 1119 from 1119 
#genetic.value.all.for.1119.from.1119<-wema.1.2.m%*%ans.1119$u
#genetic.value.ibd.for.1119.from.1119<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1119$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1119.from.1119<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1119$u[-ibd.index.1015.1016]

#For 1119 from 1017 
#genetic.value.all.for.1119.from.1017<-wema.1.2.m%*%ans.1017$u
#genetic.value.ibd.for.1119.from.1017<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1017$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1119.from.1017<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1017$u[-ibd.index.1015.1016]

#cor(genetic.value.all.for.1119.from.1119,genetic.value.all.for.1119.from.1017)
#cor(genetic.value.ibd.for.1119.from.1119,genetic.value.ibd.for.1119.from.1017)
#cor(genetic.value.non.ibd.for.1119.from.1119,genetic.value.non.ibd.for.1119.from.1017)

#For 1019 from 1019 
#genetic.value.all.for.1019.from.1019<-wema.1.2.m%*%ans.1019$u
#genetic.value.ibd.for.1019.from.1019<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1019$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1019.from.1019<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1019$u[-ibd.index.1015.1016]

#For 1019 from 1021 
#genetic.value.all.for.1019.from.1021<-wema.1.2.m%*%ans.1021$u
#genetic.value.ibd.for.1019.from.1021<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1021$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1019.from.1021<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1021$u[-ibd.index.1015.1016]

#cat("all_snp:",cor(genetic.value.all.for.1019.from.1019,genetic.value.all.for.1019.from.1021),"\n")
#cat("ibd_snp:",cor(genetic.value.ibd.for.1019.from.1019,genetic.value.ibd.for.1019.from.1021),"\n")
#cat("non_ibd:",cor(genetic.value.non.ibd.for.1019.from.1019,genetic.value.non.ibd.for.1019.from.1021),"\n")


#For 1021 from 1021 
#genetic.value.all.for.1021.from.1021<-wema.1.2.m%*%ans.1021$u
#genetic.value.ibd.for.1021.from.1021<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1021$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1021.from.1021<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1021$u[-ibd.index.1015.1016]

#For 1021 from 1019 
#genetic.value.all.for.1021.from.1019<-wema.1.2.m%*%ans.1019$u
#genetic.value.ibd.for.1021.from.1019<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1019$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1021.from.1019<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1019$u[-ibd.index.1015.1016]

#cat("all_snp:",cor(genetic.value.all.for.1021.from.1021,genetic.value.all.for.1021.from.1019),"\n")
#cat("ibd_snp:",cor(genetic.value.ibd.for.1021.from.1021,genetic.value.ibd.for.1021.from.1019),"\n")
#cat("non_ibd:",cor(genetic.value.non.ibd.for.1021.from.1021,genetic.value.non.ibd.for.1021.from.1019),"\n")


#For 1020 from 1020 
#genetic.value.all.for.1020.from.1020<-wema.1.2.m%*%ans.1020$u
#genetic.value.ibd.for.1020.from.1020<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1020$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1020.from.1020<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1020$u[-ibd.index.1015.1016]

#For 1020 from 1021 
#genetic.value.all.for.1020.from.1021<-wema.1.2.m%*%ans.1021$u
#genetic.value.ibd.for.1020.from.1021<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1021$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1020.from.1021<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1021$u[-ibd.index.1015.1016]

#cat("all_snp:",cor(genetic.value.all.for.1020.from.1020,genetic.value.all.for.1020.from.1021),"\n")
#cat("ibd_snp:",cor(genetic.value.ibd.for.1020.from.1020,genetic.value.ibd.for.1020.from.1021),"\n")
#cat("non_ibd:",cor(genetic.value.non.ibd.for.1020.from.1020,genetic.value.non.ibd.for.1020.from.1021),"\n")

#For 1021 from 1021 
#genetic.value.all.for.1021.from.1021<-wema.1.2.m%*%ans.1021$u
#genetic.value.ibd.for.1021.from.1021<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1021$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1021.from.1021<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1021$u[-ibd.index.1015.1016]

#For 1021 from 1020 
#genetic.value.all.for.1021.from.1020<-wema.1.2.m%*%ans.1020$u
#genetic.value.ibd.for.1021.from.1020<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1020$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1021.from.1020<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1020$u[-ibd.index.1015.1016]

#cat("all_snp:",cor(genetic.value.all.for.1021.from.1021,genetic.value.all.for.1021.from.1020),"\n")
#cat("ibd_snp:",cor(genetic.value.ibd.for.1021.from.1021,genetic.value.ibd.for.1021.from.1020),"\n")
#cat("non_ibd:",cor(genetic.value.non.ibd.for.1021.from.1021,genetic.value.non.ibd.for.1021.from.1020),"\n")


#ibd.index.1015.1016.2<-c(ibd.index.1015.1016)

#ibd.index.1015.1016.2<-noquote(ibd.index.1015.1016)

#ibd.index.1015.1016.2

#ibd.index.1015.1016.3<-c(as.integer(paste(ibd.index.1015.1016.2,collapse=",")))


#as.numeric(ibd.index.1015.1016)

#ibd.index.1015.1016.3

#print(gsub('',',',ibd.index.1015.1016))

#ibd.index.1015.1016.22<-c(9736:9782,41761:41912,41966:42255,54097:56226,81599:81931,100129:100512,102037:102307,104835:105163,127617:127949,129420:129603,157339:157460,180812:181055,182735:182839,187758:187826,191178:191249,200537:201452,245264:245326,313985:314388,318182:318242,382053:382325,392650:392972,523384:523876,551964:552085,564306:564523,573411:573694,614921:615021,641074:641170,642930:643300,644075:644276,668984:669300,695319:695395,751867:752031,755159:756118,761304:761449,769501:770075,798352:798543,815143:815336,825885:826058,830073:830674,832158:832328,844287:844919,863345:863517,867689:867767,872509:872563,888210:888405,907323:907931,943129:943224)

#print(c(ibd.index.1015.1016.3))

#class(ibd.index.1015.1016)
#class(ibd.index.1015.1016.22)


#print(ls())

#cat(length(ibd.index.1015.1016.3),"\n")

#cat(length(ibd.index.1015.1016.22),"\n")

#print(ibd.index.1015.1016)

#print(sub(""","",ibd.index.1015.1016))

#print(ls()[1])

#ibd.part<-ans.1015$u[c(ibd.index.1015.1016.3)]

#print(dim(ans.1015$u))

#print(ibd.part))

#print(dim(ans.1015$u[ibd.index.1015.1016]))

#print(dim(ans.1015$u[-ibd.index.1015.1016]))

#from 1015
#genetic.value.all.from.1015<-wema.1015.m%*%ans.1015$u
#genetic.value.ibd.from.1015<-wema.1015.m[,ibd.index.1015.1016]%*%ans.1015$u[ibd.index.1015.1016]
#genetic.value.non.ibd.from.1015<-wema.1015.m[,-ibd.index.1015.1016]%*%ans.1015$u[-ibd.index.1015.1016]

#from 1016
#genetic.value.all.from.1016<-wema.1015.m%*%ans.1016$u
#genetic.value.ibd.from.1016<-wema.1015.m[,ibd.index.1015.1016]%*%ans.1016$u[ibd.index.1015.1016]
#genetic.value.non.ibd.from.1016<-wema.1015.m[,-ibd.index.1015.1016]%*%ans.1016$u[-ibd.index.1015.1016]

#For 1017 from 1017 
#genetic.value.all.for.1017.from.1017<-wema.1017.m%*%ans.1017$u
#genetic.value.ibd.for.1017.from.1017<-wema.1017.m[,ibd.index.1015.1016]%*%ans.1017$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1017.from.1017<-wema.1017.m[,-ibd.index.1015.1016]%*%ans.1017$u[-ibd.index.1015.1016]

#For 1017 from 1016 
#genetic.value.all.for.1017.from.1016<-wema.1017.m%*%ans.1016$u
#genetic.value.ibd.for.1017.from.1016<-wema.1017.m[,ibd.index.1015.1016]%*%ans.1016$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1017.from.1016<-wema.1017.m[,-ibd.index.1015.1016]%*%ans.1016$u[-ibd.index.1015.1016]

#cor(genetic.value.all.for.1017.from.1017,genetic.value.all.for.1017.from.1016)
#cor(genetic.value.ibd.for.1017.from.1017,genetic.value.ibd.for.1017.from.1016)
#cor(genetic.value.non.ibd.for.1017.from.1017,genetic.value.non.ibd.for.1017.from.1016)


#For 1017 from 1015
#genetic.value.all.from.1017.from.1015<-wema.1017.m%*%ans.1015$u
#genetic.value.ibd.from.1017.from.1015<-wema.1017.m[,ibd.index.1015.1016]%*%ans.1015$u[ibd.index.1015.1016]
#genetic.value.non.ibd.from.1017.from.1015<-wema.1017.m[,-ibd.index.1015.1016]%*%ans.1015$u[-ibd.index.1015.1016]

#cor(genetic.value.all.for.1017.from.1017,genetic.value.all.from.1017.from.1015)
#cor(genetic.value.ibd.for.1017.from.1017,genetic.value.ibd.from.1017.from.1015)
#cor(genetic.value.non.ibd.for.1017.from.1017,genetic.value.non.ibd.from.1017.from.1015)

#For 1016 from 1016 
#genetic.value.all.for.1016.from.1016<-wema.1.2.m%*%ans.1016$u
#genetic.value.ibd.for.1016.from.1016<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1016$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1016.from.1016<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1016$u[-ibd.index.1015.1016]

#For 1016 from 1017
#genetic.value.all.for.1016.from.1017<-wema.1.2.m%*%ans.1017$u
#genetic.value.ibd.for.1016.from.1017<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1017$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1016.from.1017<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1017$u[-ibd.index.1015.1016]


#For 1016 from 1018
#genetic.value.all.for.1016.from.1018<-wema.1.2.m%*%ans.1018$u
#genetic.value.ibd.for.1016.from.1018<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1018$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1016.from.1018<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1018$u[-ibd.index.1015.1016]

#cor(genetic.value.all.for.1016.from.1016,genetic.value.all.for.1016.from.1018)
#cor(genetic.value.ibd.for.1016.from.1016,genetic.value.ibd.for.1016.from.1018)
#cor(genetic.value.non.ibd.for.1016.from.1016,genetic.value.non.ibd.for.1016.from.1018)

#For 1018 from 1018 
#genetic.value.all.for.1018.from.1018<-wema.1018.m%*%ans.1018$u
#genetic.value.ibd.for.1018.from.1018<-wema.1018.m[,ibd.index.1015.1016]%*%ans.1018$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1018.from.1018<-wema.1018.m[,-ibd.index.1015.1016]%*%ans.1018$u[-ibd.index.1015.1016]

#For 1016 from 1017
#genetic.value.all.for.1016.from.1017<-wema.1.2.m%*%ans.1017$u
#genetic.value.ibd.for.1016.from.1017<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1017$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1016.from.1017<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1017$u[-ibd.index.1015.1016]


#For 1018 from 1016
#genetic.value.all.for.1018.from.1016<-wema.1018.m%*%ans.1016$u
#genetic.value.ibd.for.1018.from.1016<-wema.1018.m[,ibd.index.1015.1016]%*%ans.1016$u[ibd.index.1015.1016]
#genetic.value.non.ibd.for.1018.from.1016<-wema.1018.m[,-ibd.index.1015.1016]%*%ans.1016$u[-ibd.index.1015.1016]


#cor(genetic.value.all.for.1018.from.1018,genetic.value.all.for.1018.from.1016)
#cor(genetic.value.ibd.for.1018.from.1018,genetic.value.ibd.for.1018.from.1016)
#cor(genetic.value.non.ibd.for.1018.from.1018,genetic.value.non.ibd.for.1018.from.1016)


#from 1015
#genetic.value.all.from.1015<-wema.1.2.m%*%ans.1015$u
#genetic.value.ibd.from.1015<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1015$u[ibd.index.1015.1016]
#genetic.value.non.ibd.from.1015<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1015$u[-ibd.index.1015.1016]


#from 1016
#genetic.value.all.from.1016<-wema.1.2.m%*%ans.1016$u
#genetic.value.ibd.from.1016<-wema.1.2.m[,ibd.index.1015.1016]%*%ans.1016$u[ibd.index.1015.1016]
#genetic.value.non.ibd.from.1016<-wema.1.2.m[,-ibd.index.1015.1016]%*%ans.1016$u[-ibd.index.1015.1016]

#cor(genetic.value.all.from.1015,genetic.value.all.from.1017)
#cor(genetic.value.ibd.from.1015,genetic.value.ibd.from.1017)
#cor(genetic.value.non.ibd.from.1015,genetic.value.non.ibd.from.1017)

#cor(genetic.value.all.from.1015,genetic.value.all.from.1016)
#cor(genetic.value.ibd.from.1015,genetic.value.ibd.from.1016)
#cor(genetic.value.non.ibd.from.1015,genetic.value.non.ibd.from.1016)

#save(genetic.value.all,genetic.value.ibd,genetic.value.non.ibd,file=paste(substr(ff1,1,4),"_all_ibd_no_ibd.RData",sep=""))

#print(ls()[1])
#print(ls()[2])

#n=dim(wema.1.t)[1]
#m=dim(wema.2.t)[1]

#cat(n,"\n")
#cat(m,"\n")

#wema.1.2<-rbind(wema.1.t[8:n,],wema.2.t[8:m,])
#nm=dim(wema.1.2)[1]
#save(wema.1.2,file=paste("wema_",substr(ff,6,9),"_",nm,"_955690.RData",sep=""))

all.element<-ls()

print(all.element)

q("no")
