import arcpy
import glob
import os 
from datetime import datetime
inpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\clipped_to_subregion\random_points\random_points_V10\\'
infilelist=sorted(glob.glob(inpath+'*.shp'))
field_name = 'PID'
field_type = 'LONG'

for infile in infilelist:
    bn = os.path.splitext(os.path.basename(infile))[0]
    PID=bn[-6:]

    try:
        arcpy.AddField_management(infile, field_name, field_type, '', '', '', '', '', '', '')
    except:
        pass

    arcpy.CalculateField_management(infile, 'PID', str(PID), 'Python')

    print(infile+' is done!')
