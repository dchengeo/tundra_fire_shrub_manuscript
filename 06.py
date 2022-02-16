import arcpy
import glob
import os 
from datetime import datetime

inpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\\'
outpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\\'

infile_extent=r'C:\CD\Circumpolar Arctic Vegetation Map\Alaska_tundra_merged.shp'

for year in range(1984, 2018):
    infile=inpath+'mtbs_AK_'+str(year)+'.shp'
    outfile=outpath+'mtbs_AK_'+str(year)+'_clipped_tundra.shp'
    if os.path.isfile(infile) == False: continue
    if os.path.isfile(outfile)==True: continue
    arcpy.Clip_analysis(infile, infile_extent, outfile)
    if arcpy.management.GetCount(outfile)[0] == "0":
        print outfile + ' is skipped!'
        arcpy.Delete_management(outfile)
    else: print outfile+' is done!'
