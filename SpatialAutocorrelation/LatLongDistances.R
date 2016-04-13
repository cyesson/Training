# calculate distances from lat/long coordinates

# settings for fake dataset
n<-10
set.seed(321)

# fake some lat/longs around the globe
GlobeLong<-sample(seq(-180,180,0.1),n,T)
GlobeLat<-sample(seq(-90,90,0.1),n,T)
d<-data.frame(Long=GlobeLong,Lat=GlobeLat)

# get good geographic distances from lat/long coordinates
require(geosphere)

# I'm not aware of a directly equivalent function to dist
# we have to create a list of all pairwise combinations of points
# and work out distances for each pair

# row numbers of all pairwise combinations 1-n
p.combo<-expand.grid(1:nrow(d),1:nrow(d))

# lat/longs for each pairwise combo
p1<-d[c("Long","Lat")][p.combo[,1],]
p2<-d[c("Long","Lat")][p.combo[,2],]

# calculate pairwise distances and put into square matrix
geodist<-as.matrix(distGeo(p1,p2))
# make a square matrix
dim(geodist)<-c(nrow(d),nrow(d))

# simple euclidean distance from lat/longs
lldist<-dist(d[c("Long","Lat")])

# compare 'good' and 'bad' distance measures
# colour by latitude - red=high
plot(geodist,as.matrix(lldist),xlab="geographic distance (m)",
     ylab="Coordinate distance (degrees)",cex=2,pch=16,
     col=rev(heat.colors(5))[as.numeric(cut(abs(d$Lat),5))])
