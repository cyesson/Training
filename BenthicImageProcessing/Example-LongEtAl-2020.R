# load map library
require(terra)

# load station data
d<-read.csv("https://raw.githubusercontent.com/cyesson/Training/master/BenthicImageProcessing/Stations-LongEtAl-2020.csv")

# read example bathymetry grid
r<-rast("https://github.com/cyesson/Training/raw/master/BenthicImageProcessing/Example-Bathymetry.tif")

# convert points to a spatial grid
d.sp<-vect(d, geom=c("Long", "Lat"), crs="+proj=longlat +datum=WGS84")

# crop raster grid to around the points
r.crop<-crop(r, ext(buffer(d.sp,5000)))

# plot the grid 
plot(r.crop, main="Coral density")

# add station points - sized proportional to coral density
points(d.sp, pch=16, col="darkred", cex=d$Cauliflower.Corals)

# overlay station locations (show zeros)
points(d.sp, pch="x", col="black")

# add legend
legend("topright", title="per (m2)", legend=1:3, pt.cex=1:3, pch=16, col="red")


# scatter plot of depth vs density 
plot(d$Depth, d$Cauliflower.Corals, pch=16, cex=2, col="purple3",
     xlab="Depth (m)", ylab="Density /m2", 
     main="Coral density and depth")

# simple smooth line showing changing relationship of depth & density 
s<-smooth.spline(d$Depth, d$Cauliflower.Corals)
lines(predict(s, min(d$Depth):max(d$Depth)), col="purple4", lwd=4)

