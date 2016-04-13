# an alternative correlation measure is Moran's I

require(ape)

# use the same fake data as the Mantel example
set.seed(1) # ensure we all look at the same thing
n<-100 # set the number of samples
d<-data.frame(X=sample(1:100,n,T),Y=sample(1:100,n,T),Z=runif(n))
d$Z2<-d$X^2+d$Y^2

# Moran's I requires an distance matrix based on inverse geodistances
inv.geodist<-as.matrix(1/dist(d[c("X","Y")]))
diag(inv.geodist)<-0 # ignore self-comparison

# uncorrelated variable - correlation almost zero - not significant
print(Moran.I(d$Z,inv.geodist))

# correlated variable - highly significant
print(Moran.I(d$Z2,as.matrix(inv.geodist)))

################################################################

# We know there is autocorrelation for variable Z2
# so nearby things are more similar
# but what distance constitutes nearby?
# spatial lag analysis can give us some insight

# this examines correlation (Moran's I) at different distance classes
lagtest <- correlog(d$X, d$Y, d$Z2, resamp=100,
                    increment=5) # what distance intervals to examine

# look at results
plot(lagtest)
arrows(which(lagtest$p==max(lagtest$p))*5,0.5,y1=0)
text(lagtest$x.intercept,0.5,"Distance where \nno correlation \nis seen",adj=c(0,0))

# first distance class with no correlation (the spatial lag)
print(lagtest$x.intercept)
