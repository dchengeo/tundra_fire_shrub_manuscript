import arcpy
import glob
import os

inpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\\'
outpath=inpath

for year in range(1984, 2018):
    infile=inpath+'mtbs_AK_'+str(year)+'_clipped_tundra.shp'
    if os.path.isfile(infile)==False: continue

    outfile=inpath+'mtbs_AK_'+str(year)+'_clipped_tundra_buffered_50m.shp'
    if os.path.isfile(outfile) == False:
        arcpy.Buffer_analysis(infile, outfile, 50, '', '', 'ALL')

    outfile=inpath+'mtbs_AK_'+str(year)+'_clipped_tundra_buffered_1000m.shp'
    if os.path.isfile(outfile) == False:
        arcpy.Buffer_analysis(infile, outfile, 1000, '', '', 'ALL')

    print(outfile+' is done!')