# A brief introduction to QGIS

[QGIS](http://qgis.org/ "QGIS Homepage") (short for Quantum GIS) is a user friendly open source Geographic Information System. The QGIS project has been running since 2002 and has tens of thousands of users [around the world](http://plugins.qgis.org/community-map/ "map of registered users"). This open source software is free to download, distribute and use. It is designed to be available on almost all operating systems with a standardized interface. It is a direct competitor to commercial GIS applications such as Arcgis. There is an active developer community working on analytical tool development, and a simple plugin interface that enables users/researchers to write their own 'plugin' tools in the python programming language.

# A first project in QGIS

This tutorial will introduce the QGIS interface and show you how to create a project, load & format layers and navigate around the map window. We assume no prior knowledge. We will load in all the layers in the zip file Introduction2QGIS.zip and produce a project looking something like this.

![Screenshot from practical](https://github.com/cyesson/Training/blob/master/GIS/Introduction2QGIS/Introduction2QGIS-screenshot.png)

## Layers

* Tanzania.gpkg - Geopackage (vector layer) outlining the country of Tanzania (really old, low resolution file, can't remember where its from)
* AdministrativeAreas.shp - Shapefile (vector) showing administrative areas within Tanzania (source [DIVA GIS](http://www.diva-gis.org/Data))
* ProtectedAreas.shp - Shapefile (vector layer) showing various kinds of protected areas within the country (old, out of date data - get the latest data from [Protected Planet](https://www.protectedplanet.net/))
* Lakes.kml - KML (vector layer) of lakes in Tanzania (source [DIVA GIS](http://www.diva-gis.org/Data))
* Satellite.tif - GeoTiff (raster layer) colour 'image' of Tanzania extracted from a very old WSIEarth picture of the world
* Diospyros.txt - Text file (vector layer) point locations of [Diospyros loureiriana](http://www.zimbabweflora.co.zw/speciesdata/species.php?species_id=143990), a small tree/shrub. This is an old extract from [GBIF](http://www.gbif.org/)

## Acknowledgements

This practical was first designed & conducted by QGIS developer and all round GIS expert [Tim Sutton](https://twitter.com/timlinux?lang=en).

