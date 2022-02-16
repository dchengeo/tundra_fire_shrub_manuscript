import arcpy
import glob
import os

inpath=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\clipped_to_subregion\random_points\random_points_V10\\'
outfile=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\clipped_to_subregion\random_points\random_points_V10\merged\unburned_random_sample_points_merged_V10.shp'
infilelist=sorted(glob.glob(inpath+'*.shp'))
arcpy.Merge_management(infilelist, outfile)

print outfile + ' is done!'
