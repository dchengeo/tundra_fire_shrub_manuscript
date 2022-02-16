import arcpy
import glob
import os 
from datetime import datetime
from arcpy.sa import *

regionList=['noatak', 'north_slope', 'seward', 'south_west']

infile = r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\mtbs_AK_1984_2017_clipped_tundra_refined_merged_single_burn.shp'
inpath_shp=r'D:\lobodagp\dchen\Tony\Alaska_tundra_fire_regime\GIS\\'

inpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\\'
outpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\clipped_to_subregion\\'

for region in regionList:
    infile_shp = inpath_shp + 'subregion_' + region + '.shp'
    outfile=outpath+'\mtbs_AK_1984_2017_clipped_tundra_refined_merged_single_burn_'+region+'.shp'

    if os.path.isfile(outfile) == False:
        arcpy.Clip_analysis(infile,  infile_shp ,outfile)
        if arcpy.management.GetCount(outfile)[0] == '0':
            arcpy.Delete_management(outfile)
        else:
            print outfile + ' is done!'
