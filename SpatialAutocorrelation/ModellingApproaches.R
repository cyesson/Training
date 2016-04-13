################################################################
# approaches to deal with spatial autocorrelation in models

# fake dataset
set.seed(243)
n<-10 # number of samples
d<-data.frame(Long=runif(100,-180,180),Lat=runif(100,-90,90)) # lat/longs
d$Temp<-(1-(abs(d$Lat)/90))*runif(100,5,20) # temp correlated with lat
d$Precip<-runif(100,0,1) # uncorrelated variable
d$Abundance<-(d$Temp/20)*d$Precip*runif(100,0,0.25)*(1-(abs(d$Long)/180)) # abundance related to temp and precip

# look at the data
plot(d$Long,d$Lat,col=rev(heat.colors(10))[as.numeric(cut(d$Temp,10))],cex=1+d$Precip,pch=16,xlab="Longitude",ylab="Latitude")
legend("topright",legend=c("Temp=0C","Temp=20C","Precip=0mm","Precip=1mm"),pt.cex=c(1.5,1.5,1,2),pch=c(16,16,1,1),col=c("yellow","red","black","black"))

# simple model of abundance
mod.ab<-lm(Abundance~Temp+Precip,data=d)
summary(mod.ab)
# looks OK but what about spatial autorrelation?

# look at spatial lag in our data
require(ncf)
# no pattern for precip variable
plot(lag<-correlog(d$Long,d$Lat,d$Precip,increment=1000,latlon=T,resamp=100))
# significant patterns for temp & abundance
plot(lag<-correlog(d$Long,d$Lat,d$Temp,increment=1000,latlon=T,resamp=100))
# looks like distance of around 5-8000 (km) is where autocorrelation ends

# library for serious spatial analysis
require(spdep)

# need a matrix specifing what to consider as nearby for correlation test
xy.dist<-dnearneigh(as.matrix(d[c("Long","Lat")]),longlat=T,
                    0,5000) # everyone between 0 and 5000 is 'nearby'
# check for spatial autocorrelation of residuals
lm.morantest(mod.ab, nb2listw(xy.dist, style="W"),alternative="two.sided")
# p value shows significant spatial autocorrelation of residuals


################################################################
# adjust samples

# we can thin out our data to sample once every 5000 km
require(spThin)
# need a 'species' column in our data
d$Spec<-rep("sp.x",nrow(d))
# spatial thinning by distance
d.thin<-thin(d,lat.col="Lat",long.col="Long",spec.col="Spec",
             write.files=F,locs.thinned.list.return=T,
             reps=2, # number of replicates to return
             thin.par=5000) # distance to apply

# subset original data for thinned out samples (thinned set 1)
d2<-d[rownames(d.thin[[1]]),]
# no lag is evident
plot(lag<-correlog(d2$Long,d2$Lat,d2$Temp,increment=1000,latlon=T,resamp=100))

# look back at the data
plot(d$Long,d$Lat,col=rev(heat.colors(10))[as.numeric(cut(d$Temp,10))],cex=1+d$Precip,pch=16,xlab="Longitude",ylab="Latitude")
# see which points are selected
points(d2$Long,d2$Lat,pch=4)
legend("topright",
       legend=c("Temp=0C","Temp=20C","Precip=0mm",
           "Precip=1mm","Thinned samples"),
       pt.cex=c(1.5,1.5,1,2,1),pch=c(16,16,1,1,4),
       col=c("yellow","red","black","black","black"))

# this example has significant and unsatisfactory reduction in the dataset size
# the revised model may not show the same pattern as the original model
print(summary(lm(Abundance~Temp+Precip,data=d2)))
# and the choice of samples selected can influence the results (thinned set 2)
print(summary(lm(Abundance~Temp+Precip,data=d[rownames(d.thin[[2]]),])))


################################################################
# adjust model

# use a model that incorporates spatial correlation structure
# we need the distance matrix for nearby samples again
xy.dist<-dnearneigh(as.matrix(d[c("Long","Lat")]),longlat=T,
                    0,5000)
# the spautolm function in spdep fits a spatial correlation structure to a linear model
mod.ab.sp<-spautolm(Abundance~Temp+Precip,data=d,
                    listw=nb2listw(xy.dist,style="W"))
# look at results
summary(mod.ab.sp,Nagelkerke=T)
# lambda is the parameter describing spatial autocorrelation
# lambda is highly significant

# we can perform a likelihood ratio test on the nested models
LR.sarlm(mod.ab,mod.ab.sp)
# the model with autocorrelation has significantly higher log likelihood


################################################################
# it is possible to fit a spatial correlation structure into a mixed model
# the nlme package has a corSpatial object that does this

# library(nlme)
# spcor<-corSpatial(value=<lag distance>,form=~X+Y) # set up cor structure
# spcor<-Intitialize(spcor,<dataset>)               # initialise structure
# glmmPQL(<formula>,random=<random>,cor=spcor,...)  # run model
