import arcpy
import glob
import os

inpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\\'
outpath=inpath

for year in range(1984, 2018):
    infile=inpath+'mtbs_AK_'+str(year)+'_clipped_tundra_buffered_50m.shp'
    if os.path.isfile(infile)==False: continue

    outfile=inpath+'mtbs_AK_'+str(year)+'_clipped_tundra_buffered_50m_single_parts.shp'
    if os.path.isfile(outfile) == False:
        arcpy.MultipartToSinglepart_management(infile, outfile)

    print(outfile+' is done!')