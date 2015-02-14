#R --slave --args file < ~/ReadEachNewMatrixData.R
myarg <- commandArgs()
#cat(s,"\n")

ff <- myarg[4:4]

library(gdata,quietly = T)

load(ff)

ls()
ll(dim=T)

q("no")
