

import arcpy
import glob
import os 
from datetime import datetime

print 'Program starts at', str(datetime.now())  

inpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\\'
outpath=inpath

for year in range(1984, 2018):
    infile=inpath+'mtbs_AK_'+str(year)+'_clipped_tundra.shp'
    if os.path.isfile(infile) == False: continue
    outfile=outpath+'mtbs_AK_'+str(year)+'_clipped_tundra_refined.shp'
    if os.path.isfile(outfile) == True: continue

    field_name = 'Area'
    field_type = 'FLOAT'
    try:   arcpy.AddField_management(infile, field_name, field_type, '', '', '', '', '', '', '')
    except: pass

    field_name = 'Year'
    field_type = 'SHORT'
    try:   arcpy.AddField_management(infile, field_name, field_type, '', '', '', '', '', '', '')
    except: pass
    # with arcpy.da.UpdateCursor(infile, ['Area', 'SHAPE@AREA']) as cursor:
    #     for row in cursor:
    #         row[0]=row[1]

    arcpy.CalculateField_management(infile,'Area','!shape.area!','PYTHON')
    arcpy.CalculateField_management(infile, 'Year', str(year), 'PYTHON')
    layer_name = str(year)

    arcpy.MakeFeatureLayer_management(infile, layer_name)
    arcpy.SelectLayerByAttribute_management(layer_name, "NEW_SELECTION", '"gridcode" >= 2 And "gridcode" <= 4 And "Area" >= 3600'  )
    arcpy.CopyFeatures_management(layer_name, outfile)

    print(outfile+' is done!')

print 'Program ends at', str(datetime.now())  
                                   