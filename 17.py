import arcpy
import glob
import os 
from datetime import datetime
regionList=['noatak', 'north_slope', 'seward', 'south_west']

inpath=r'D:\lobodagp\dchen\Datasets\ASTER_DEM_Alaska\clipped_to_subregions\\'
outpath=r'D:\lobodagp\dchen\Datasets\ASTER_DEM_Alaska\clipped_to_subregions\random_points\\'
if os.path.isdir(outpath)== False:
    os.makedirs(outpath)

for region in regionList:
    infile=inpath+'ASTER_30m_DEM_Alaska_AK_albers_below300m_'+region+'_intersected_water_free_burned_area_free_tundra_only.shp'

    outfile='background_random_points_'+region+'_V10.shp'

    if os.path.isfile(outfile) == False:
        arcpy.CreateRandomPoints_management(outpath, outfile, infile, "", 5000, 30, "POINT", "")
    print outfile + ' is done!'


