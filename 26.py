import glob
import os 
from datetime import datetime
from osgeo import gdal, ogr

infile='/gpfs/data1/lobodagp/dchen/Datasets/JRC_water/mosaic/JRC_water_occurrence_alaska_V1.3_GE50.tif'
outfile='/gpfs/data1/lobodagp/dchen/Datasets/JRC_water/mosaic/JRC_water_occurrence_alaska_V1.3_GE50_alaska_albers.tif'

os.system('gdalwarp -of GTIFF -t_srs EPSG:3338 -r near  -tr 30 30  ' + infile + ' ' + outfile)
print(outfile + ' is done!')
