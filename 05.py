import arcpy
import glob
import os

inpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\\'
outpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\\'
if os.path.isdir(outpath)== False:
    os.makedirs(outpath)

for year in range(1984, 2018):
    infile=inpath+'mtbs_AK_'+str(year)+'.tif'
    if os.path.isfile(infile) == 0: continue

    outfile=inpath+'mtbs_AK_'+str(year)+'.shp'
    if os.path.isfile(outfile) == False:
        arcpy.RasterToPolygon_conversion(infile, outfile, "NO_SIMPLIFY", "VALUE")

    print(outfile+' is done!')