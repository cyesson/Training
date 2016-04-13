# Performing a mantel test (of spatial autocorrelation) in R

# create a random dataset of coordinates and values
set.seed(1) # ensure we all look at the same thing
n<-100 # set the number of samples
d<-data.frame(X=sample(1:100,n,T),Y=sample(1:100,n,T),Z=runif(n))

# its always a good idea to look at your data
plot(d$X,d$Y,pch=16,col=heat.colors(5)[as.numeric(cut(d$Z,5))])

# create a distance matrix based on coordinate locations
# warning! the dist function is not suitable for lat/long coordinates
# but is OK for X,Y values from a good region-specific UTM grid
geodist<-dist(d[c("X","Y")])

# create a distance matrix based on attribute values
zdist<-dist(d$Z)

# we can 'eyeball' the correlation by plotting the two
plot(geodist, zdist,main="compare geographic and attribute distance",
     xlab="geographic distance",ylab="attribute distance")

# regression or peason correlation are not statistically valid measures
# so we need a mantel test which is available from many packages
# package mantel.test in package ncf is simple to use
require(ncf)

# mantel is permutation test on the correlation between (dis)similarity matrices
# matrices are randomly permuted
# the observed correlation value is compared to replicates
mt<-mantel.test(x=d$X,y=d$Y,z=d$Z,resamp=100) # use latlon=T as required
# Correlation coefficient - very close to zero = no correlation
print(mt$correlation)
# p value - small p implies significant correlation
print(mt$p)

# try again with spatially autocorrelated data
# create correlated attribute (nearby things are more similar)
d$Z2<-d$X^2+d$Y^2
# create distance matrix
z2dist<-dist(d$Z2)
# eyeball
plot(geodist, z2dist,main="obvious correlation",
     xlab="geographic distance",ylab="attribute distance")

# do the test
mt<-mantel.test(x=d$X,y=d$Y,z=d$Z2,resamp=100)
# Correlation coefficient
print(mt$correlation)
# p value
print(mt$p) ## highly significant

