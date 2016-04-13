# Spatial Autocorrelation #

Waldo Tobler's first law of geography says "Everything is related to everything else, but near things are more related than distant things."

This effect can create problems for analysis, particularly if we have spatially biased samples.

The most common issue arises from biased geographic sampling.  If we have positive spatial autocorrelation (nearby things are more similar), then we may exaggerate (overweight) the importance of spatially clustered samples by wrongly treating them as independent.


## Spatial clustering of our samples ##

Sampling strategies typically fit one of these patterns:

 * uniformly spaced samples
 * randomly spaced samples
 * any data we can botch together

If we don't have perfect sampling, then we can test whether the spatial spread of our data fits a regular or clustered spatial pattern using a Clark-Evans test.

[Example SpatialClusteringTest.R](https://github.com/cyesson/Training/blob/master/SpatialAutocorrelation/SpatialClusteringTest.R)


## Measuring spatial autocorrelation ##

Just because we have some spatial clustering, it doesn't neccessarily mean our analysis will be affected.  We can investigate spatial structure by comparing geographic distance and sample similarity.

There are a number of correlation metrics that describe the relationship between geographic distance and variable similarity. Moran's I, Mantel and Geary's C are common measures.

The Mantel test examines then correlation between 2 'distance' matrices (comparing geographic distances with an attribute of our samples). It is used for the Isolation by Distance Test in population genetics.  Significance of the Mantel test is based on a randomisation of matrices and a comparison of the observed correlation value with the randomisation replicates.

[Example MantelTest.R](https://github.com/cyesson/Training/blob/master/SpatialAutocorrelation/MantelTest.R)

Moran's I is an extension of Pearson's correlation coefficient, that weights sample pairs proportional to the inverse of their geographic distance (nearby comparisons have more weight).

[Example MoransIandSpatialLag.R](https://github.com/cyesson/Training/blob/master/SpatialAutocorrelation/MoransIandSpatialLag.R)


## Spatial Lag ##

Spatial autocorrelation may not follow a uniform linear pattern. At some distance X there may no longer be any detectable similarity between samples.  This distance can be regarded as the spatial lag. Sampling intervals of this distance ought to negate spatial autocorrelation.  We can do a simple analysis to guess this distance, by dividing our samples into similar distance classess and examining the correlation (a spatial lag test).

[Example MoransIandSpatialLag.R](https://github.com/cyesson/Training/blob/master/SpatialAutocorrelation/MoransIandSpatialLag.R)


## Models ##

If we have spatial autocorrelation we should think how this might affect any model trying to describe a relationships between variables.  Some approaches are:

 * do nothing
 * check our model for spatial patterns (autocorrelation of residuals)
 * adjust sampling (i.e. thin/filter our samples)
 * adjust the model to incorporate autocorrelation

[Example ModellingApproaches.R](https://github.com/cyesson/Training/blob/master/SpatialAutocorrelation/ModellingApproaches.R)
