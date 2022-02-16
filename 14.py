import arcpy
import glob
import os 

infile_burned=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\clipped_to_subregion\random_points\MTBS_burned_area_random_points_merged_joined_with_BID_year.shp'
outpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\clipped_to_subregion\random_points\random_points_V10\\'
if os.path.isdir(outpath)== False:
    os.makedirs(outpath)
inpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\by_BID\\'

with arcpy.da.SearchCursor(infile_burned, ['PID', 'Year', 'BID']) as cursor:
    for row in cursor:
        PID=row[0]
        year=row[1]
        BID=row[2]

        PID_out=PID+100000
        infile=inpath+'mtbs_AK_tundra_unburned_area_BID'+str(BID).zfill(3)+'.shp'

        outfile='unburned_random_points_V10_PID'+str(PID_out).zfill(6)+'.shp'

        if os.path.isfile(outfile) == False:
            arcpy.CreateRandomPoints_management(outpath, outfile, infile, "", 1, "", "POINT", "")
        print str(PID) + ' is done!'


