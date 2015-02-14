
SplitPop<-function(a){

unlist(strsplit(as.character(a),"_",fixed=TRUE))

}


pop.name<-apply(as.data.frame(pop.mapped.region[,2]),1,SplitPop)[1,]

pop.coverage<-as.data.frame(cbind(pop.name,pop.mapped.region[,3]/955690))

pdf(file="pop_coverage.pdf")
plot(pop.coverage[,2])
dev.off()


