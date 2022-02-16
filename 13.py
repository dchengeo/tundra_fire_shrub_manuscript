import arcpy
import glob
import os 
from datetime import datetime
regionList=['noatak', 'north_slope', 'seward', 'south_west']

inpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\clipped_to_subregion\\'
outpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\clipped_to_subregion\random_points\\'
if os.path.isdir(outpath)== False:
    os.makedirs(outpath)

for region in regionList:
    infile=inpath+'mtbs_AK_1984_2017_clipped_tundra_refined_merged_single_burn_'+region+'.shp'
    outfile_dissolved = inpath + 'mtbs_AK_1984_2017_clipped_tundra_refined_merged_single_burn_' + region + '_dissolved.shp'
    arcpy.Dissolve_management(infile, outfile_dissolved, '', '', 'MULTI_PART')

    outfile='MTBS_burned_area_random_points_'+region+'.shp'

    if os.path.isfile(outfile) == False:
        arcpy.CreateRandomPoints_management(outpath, outfile, outfile_dissolved, "", 5000, 30, "POINT", "")

    print outfile + ' is done!'


