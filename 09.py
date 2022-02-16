import arcpy
import glob
import os

inpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\\'
outfile=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\mtbs_AK_1984_2017_clipped_tundra_buffered_50m_single_parts_merged.shp'

for year in range(1984, 2018):
    infile=inpath+'mtbs_AK_'+str(year)+'_clipped_tundra_buffered_50m_single_parts.shp'
    if os.path.isfile(infile) == False: continue

    field_name = 'Year'
    field_type = 'SHORT'
    try:
        arcpy.AddField_management(infile, field_name, field_type, '', '', '', '', '', '', '')
    except:
        pass

    arcpy.CalculateField_management(infile, 'Year', str(year), 'Python')

infilelist=sorted(glob.glob(inpath+'*_50m_single_parts.shp'))
arcpy.Merge_management(infilelist, outfile)

field_name = 'BID'
field_type = 'SHORT'
try:
    arcpy.AddField_management(outfile, field_name, field_type, '', '', '', '', '', '', '')
except:
    pass

arcpy.CalculateField_management(outfile, 'BID', '1+!FID!', 'Python')
print outfile + ' is done!'
