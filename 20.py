import arcpy
import glob
import os

infile1=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\clipped_to_subregion\random_points\MTBS_burned_area_random_points_merged_joined_with_BID_year.shp'
infile2=r'D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\clipped_to_subregion\random_points\random_points_V10\merged\unburned_random_sample_points_merged_V10.shp'
infile3=r'D:\lobodagp\dchen\Datasets\ASTER_DEM_Alaska\clipped_to_subregions\random_points\background_random_points_merged_V10.shp'
outfile=r'D:\lobodagp\dchen\Tony\ABOVE\GIS\burned_unburned_background_sample_points_V10.shp'

infilelist=[infile1, infile2, infile3]
arcpy.Merge_management(infilelist, outfile)

print outfile + ' is done!'
