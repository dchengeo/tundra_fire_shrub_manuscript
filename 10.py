import arcpy
import glob
import os 
from datetime import datetime
from arcpy.sa import *

infile=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\mtbs_AK_1984_2017_clipped_tundra_buffered_50m_single_parts_merged_buffered_950m.shp'
infile_extent=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\mtbs_AK_1984_2017_clipped_tundra_buffered_50m_single_parts_merged.shp'
outpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\by_BID\\'
with arcpy.da.SearchCursor(infile, ['BID', 'SHAPE@']) as cursor:
    for row in cursor:
        BID=row[0]
        layer_name = str(BID)
        arcpy.MakeFeatureLayer_management(infile_extent, layer_name)
        arcpy.SelectLayerByAttribute_management(layer_name, "NEW_SELECTION", '"BID" = '+str(BID))

        outfile=outpath+'mtbs_AK_tundra_unburned_area_BID'+str(BID).zfill(3)+'.shp'

        if os.path.isfile(outfile) == False:
            arcpy.Erase_analysis(row[1],  infile_extent ,outfile)
            if arcpy.management.GetCount(outfile)[0] == '0':
                arcpy.Delete_management(outfile)
            else:
                print outfile + ' is done!'
