# spatially clustered data is more likely to suffer from autocorrelation issues
# we can test for spatial clustering with a clark-evans test

require(spatstat)

# fake some spatially clumped samples
set.seed(123)
# coordinates clustered around 2 centres
xy.clmp<-data.frame(X=c(rnorm(50,2.5,0.5),rnorm(50,7.5,0.5)),
                    Y=c(rnorm(50,2.5,0.5),rnorm(50,7.5,0.5)))

# need a point pattern object for the test
# this is just points plus the extent of the study area
# we can load a shapefile or just use a bounding box
xy.pp<-ppp(xy.clmp$X,xy.clmp$Y,window=bounding.box.xy(xy.clmp))

# its always a good idea to look at your data
plot(xy.pp, main="two clusters of points and their bounding box")

# run clark-evans test to check for spatial clustering
clarkevans.test(xy.pp,alternative="clustered")
# unsurprisingly we see a significant result p<<0.001

# if you are worried about an edge effect then do this (takes a bit longer)
# clarkevans.test(xy.pp,alternative="clustered", correction="cdf")

################################################################
# try again with evenly spaced samples
xy.ev<-expand.grid(1:10,1:10)
names(xy.ev)<-c("X","Y")

# define region of study
xy.pp<-ppp(xy.ev$X,xy.ev$Y,window=bounding.box.xy(xy.ev))
plot(xy.pp, main="evenly spaced samples")

# run clark-evans test
clarkevans.test(xy.pp,alternative="clustered")
# you can 'reverse' the test and check if its a regular pattern
clarkevans.test(xy.pp,alternative="regular")

################################################################




