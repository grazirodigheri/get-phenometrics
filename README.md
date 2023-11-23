<h2 align="center">
  Extract phenological metrics using different algorithms
</h2>

<p align="center">
  <a href="https://github.com/grazirodigheri/get-phenometrics/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green" alt="License"></a>
  <a href="https://www.tidyverse.org/lifecycle/#maturing"><img src="https://img.shields.io/badge/lifecycle-maturing-blue.svg" alt="lifecycle"></a>
</p>

<p align="center">  
  • <a href="#paper">Paper</a> &nbsp;
  • <a href="#algorithms">Algorithms</a> &nbsp;
  • <a href="#example">Example</a> &nbsp;
</p>

<h1 align="center">
  <a><img src="https://pub.mdpi-res.com/remotesensing/remotesensing-15-05366/article_deploy/html/images/remotesensing-15-05366-ag-550.jpg?1700538472" alt="Markdownify" width="650"></a>
</h1>

## Paper:

This repository is part of the paper [Estimating Crop Sowing and Harvesting Dates Using Satellite Vegetation Index: A Comparative Analysis.](https://www.mdpi.com/2072-4292/15/22/5366)

## Algorithms:

The algorithms tested in this work included:
- [CropPhenology](https://github.com/SofanitAraya/CropPhenology)
- [Digital Earth Australia tools](https://docs.dea.ga.gov.au/notebooks/Tools/gen/dea_tools.temporal.html#dea_tools.temporal.xr_phenology)
- [greenbrown](https://greenbrown.r-forge.r-project.org/install.php)
- [phenex](https://CRAN.R-project.org/package=phenex)
- [phenofit](https://github.com/eco-hydro/phenofit)
- [rTIMESAT](https://github.com/eco-hydro/rTIMESAT).

## Example:

This repository contains a jupyter notebook [example](./example.ipynb) where you can explore functions to interpolate, smooth and extract phenological metrics from a time-serie.