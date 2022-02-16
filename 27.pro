pro ABOVE_tundra_fire_buffer_water_mask_V1_3for_90m

infile='/gpfs/data1/lobodagp/dchen/Datasets/JRC_water/mosaic/JRC_water_occurrence_alaska_V1.3_GE50_alaska_albers.tif'
indata=read_tiff(infile)
ref=QUERY_TIFF(infile, GEOTIFF=map_info)
ns=(size(indata))[1]
nl=(size(indata))[2]
outfile='/gpfs/data1/lobodagp/dchen/Datasets/JRC_water/mosaic/JRC_water_occurrence_alaska_V1.3_GE50_alaska_albers_buffered_90m.tif'

fillValue=0
validValue=1

data=bytarr(ns, nl, 9)
data[*,*,0]=indata
data[*,*,1]=shift(indata, 1, 0)
data[*,*,2]=shift(indata, 1, 1)
data[*,*,3]=shift(indata, -1, 0)
data[*,*,4]=shift(indata, -1, -1)
data[*,*,5]=shift(indata, 0, 1)
data[*,*,6]=shift(indata, -1, 1)
data[*,*,7]=shift(indata, 0, -1)
data[*,*,8]=shift(indata, 1, -1)

m=max(data, dimension=3)

outdata1=byte(m eq validValue)*1b

data=bytarr(ns, nl, 9)
data[*,*,0]=outdata1
data[*,*,1]=shift(outdata1, 1, 0)
data[*,*,2]=shift(outdata1, 1, 1)
data[*,*,3]=shift(outdata1, -1, 0)
data[*,*,4]=shift(outdata1, -1, -1)
data[*,*,5]=shift(outdata1, 0, 1)
data[*,*,6]=shift(outdata1, -1, 1)
data[*,*,7]=shift(outdata1, 0, -1)
data[*,*,8]=shift(outdata1, 1, -1)

m=max(data, dimension=3)

outdata2=byte(m eq validValue)*1b

data=bytarr(ns, nl, 9)
data[*,*,0]=outdata2
data[*,*,1]=shift(outdata2, 1, 0)
data[*,*,2]=shift(outdata2, 1, 1)
data[*,*,3]=shift(outdata2, -1, 0)
data[*,*,4]=shift(outdata2, -1, -1)
data[*,*,5]=shift(outdata2, 0, 1)
data[*,*,6]=shift(outdata2, -1, 1)
data[*,*,7]=shift(outdata2, 0, -1)
data[*,*,8]=shift(outdata2, 1, -1)

m=max(data, dimension=3)

outdata3=byte(m eq validValue)*1b

write_tiff, outfile, outdata3, GEOTIFF=map_info

print, outfile+' is done! at '+systime()

end




