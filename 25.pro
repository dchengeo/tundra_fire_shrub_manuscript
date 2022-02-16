pro ABOVE_tundra_fire_extract_above_50percent_water_mask
infile='/gpfs/data1/lobodagp/dchen/Datasets/JRC_water/mosaic/JRC_water_occurrence_alaska_V1.3.tif'
indata=read_tiff(infile)
ref=QUERY_TIFF(infile, GEOTIFF=map_info)

outdata=indata ge 50 and indata le 100
outfile='/gpfs/data1/lobodagp/dchen/Datasets/JRC_water/mosaic/JRC_water_occurrence_alaska_V1.3_GE50.tif'
write_tiff, outfile, outdata, GEOTIFF=map_info
end