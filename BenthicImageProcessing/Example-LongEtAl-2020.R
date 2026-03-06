# load map library
require(terra)
require(leaflet)

# load station data
d<-read.csv("https://raw.githubusercontent.com/cyesson/Training/master/BenthicImageProcessing/Stations-LongEtAl-2020.csv")

# convert points to a spatial grid
d.sp<-vect(d, geom=c("Long", "Lat"), crs="+proj=longlat +datum=WGS84")
d.sp

# plot points over satellite map, scale points to coral density
leaflet(d.sp) %>% 
  addProviderTiles(providers$Esri.WorldImagery, group="Satellite") %>%
  addCircleMarkers(radius = ~(5*Cauliflower.Corals),
                   label = ~paste("Station =",Station, ", N=", Cauliflower.Corals, sep=""))


# scatter plot of depth vs density 
plot(d$Depth, d$Cauliflower.Corals, pch=16, cex=2, col="purple3",
     xlab="Depth (m)", ylab="Density /m2", 
     main="Coral density and depth")

# simple smooth line showing changing relationship of depth & density 
s<-smooth.spline(d$Depth, d$Cauliflower.Corals)
lines(predict(s, min(d$Depth):max(d$Depth)), col="purple4", lwd=4)
