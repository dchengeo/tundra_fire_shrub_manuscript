import glob
import os 
import arcpy

regionList=['noatak', 'north_slope', 'seward', 'south_west']

inpath=r'D:\lobodagp\dchen\Datasets\ASTER_DEM_Alaska\clipped_to_subregions\\'
outpath=inpath

for region in regionList:
    infile=inpath+'ASTER_30m_DEM_Alaska_AK_albers_below300m_'+region+'_intersected_water_free_burned_area_free.shp'
    infile_extent=r'C:\CD\Circumpolar_Arctic_Vegetation_Map\Alaska_tundra_merged.shp'
    infilelist=[infile, infile_extent]
    outfile=outpath+'ASTER_30m_DEM_Alaska_AK_albers_below300m_'+region+'_intersected_water_free_burned_area_free_tundra_only.shp'
    arcpy.Intersect_analysis(infilelist, outfile)


