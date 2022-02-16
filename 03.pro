pro ABOVE_tundra_fire_link_field_vegetation_cover_with_NDVImax
infile='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\field_data_point_list.csv'
indata=read_csv(infile, header=header)
nc=n_tags(indata)
nr=file_lines(infile)-1
content=strarr(nc, nr)
for k=0, nc-1 do content[k, *]=indata.(k)

outdata=strarr(nc+1, nr)
outdata[0:nc-1, *]=content

PIDlist=indata.field03
yearlist=indata.field07
shrubvaluelist=indata.field08
graminioidvaluelist=indata.field09

for pid=1, 492 do begin
    
    year=yearlist[where(pidlist eq pid)]
    
    infile_list=file_search(strcompress('C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\GEE_results\'+string(year)+'*_NDVImax.csv', /remove_all), count=c)
    if c ne 1 then message, 'error!'
    infile_ndvi=infile_list[0]
    
    indata_ndvi=read_csv(infile_ndvi)
    pidlist_ndvi=indata_ndvi.field08
    ndvilist=indata_ndvi.field02
    
    index=where(pidlist_ndvi eq pid, c_valid)
    if c_valid ne 1 then message, 'error!'
    
    ndvi=strsplit((strsplit(ndvilist[index], '=', /extract))[1], '}', /extract)
    
    outdata[-1, where(pidlist eq pid)]=ndvi
    progress_bar, pid, 1, 492
endfor
outfile='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\field_data_point_with_NDVImax.csv'
write_csv, outfile, outdata, header=[header, 'NDVImax']


end