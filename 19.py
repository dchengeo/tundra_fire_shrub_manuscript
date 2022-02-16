import arcpy
import glob
import os 
from datetime import datetime
regionList=['noatak', 'north_slope', 'seward', 'south_west']

inpath=r'D:\lobodagp\dchen\Datasets\ASTER_DEM_Alaska\clipped_to_subregions\random_points\\'

for i in range(0, 4):

    region = regionList[i]

    infile=inpath+'background_random_points_'+region+'_V10.shp'
    field_name = 'PID'
    field_type = 'LONG'
    try:
        arcpy.AddField_management(infile, field_name, field_type, '', '', '', '', '', '', '')
    except:
        pass

    arcpy.CalculateField_management(infile, 'PID', '300000+'+str(i)+'*5000+!FID!', 'Python')

    try: arcpy.DeleteField_management(infile, 'CID')
    except: pass

    print(infile+' is done!')

infilelist=glob.glob(inpath+'background_random_points_*.shp')
outfile=inpath+'background_random_points_merged_V10.shp'
arcpy.Merge_management(infilelist, outfile)