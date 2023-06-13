# Coordinate Reference Systems

We can represent points on the globe using many different coordinate systems. I hope you will have heard of Degrees, Minutes and Seconds as a way of specifying a location. If you have been out walking you may have used an Ordnance Survey map, which uses a different set of coordinates to locate places in the UK.

This practical will introduce the concept of Coordinate Reference Systems (CRS also called spatial reference systems / SRS) and show how the choice of CRS will impact how your map is displayed / interpretted.

You should keep in mind that there are 3 fundamental properties that a coordinate reference system could have, but will likely only have one of these intact:

* Equal AREA - Similar sized areas look the same size on your map
* Fidelity of DISTANCE - Distances from a particular point on your map are proportional to the 'real world' distances
* Fidelity of DIRECTION - Directions between locations are accurate

![screenshot from practical](https://github.com/cyesson/Training/blob/master/GIS/CoordinateReferenceSystems/CRS-screenshot.png)


## Layers

* Countries.shp - Very old countries of the world shape file (vector) - you can get a recent version from [arcgis hub](https://hub.arcgis.com/datasets/esri::world-countries-generalized/explore)
* UK.gml - (GML file - vector data) Extract of countries layer for UK
* UKGrid10k.gml (GML file - vector) 10km grid squares around UK
* UKGrid1Deg.gml (GML file - vector) 1 degree grid squares around UK
* GlobalGrid30Deg.gml (GML file - vector) global 30 degree grid squares
* GoogleMaps-World.png (PNG image - raster) Base image from source [google maps](http://maps.google.co.uk/)
* LochroleuchaOSGB.csv (text file - vector) Point data of the golden kelp in the UK based on Ordance Survey grid references (source [Yesson et al 2015](http://www.sciencedirect.com/science/article/pii/S0272771415000219) & [National Biodiversity Network](https://nbnatlas.org/) )
* UndariaLL.csv (text file - vector) Point data of Undaria in the UK based on a Latitude/Longitude grid (source [Yesson et al 2015](http://www.sciencedirect.com/science/article/pii/S0272771415000219) & [National Biodiversity Network](https://nbnatlas.org/))

## Links

* [QGIS documentation](http://docs.qgis.org/2.0/en/docs/gentle_gis_introduction/coordinate_reference_systems.html) - A nice introduction to CRS/SRS with some links
* [spatialreference.org](http://spatialreference.org/) - A comprehensive list of difference spatial reference systems.
* [Geeky Examples of CRS](https://xkcd.com/977/)
* [Clip from West Wing where the Gall-Peters projection is explained](https://www.youtube.com/watch?v=OH1bZ0F3zVU)
* [ArcGIS data hub - lots of downloadable layers](https://hub.arcgis.com/datasets/)
