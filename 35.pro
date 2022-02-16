pro ABOVE_tundra_fire_calculate_NDVI_anomaly_and_year_since_fire_V14c
vegTypeRef=[1, 2, 3, 4, 5]

infile='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_max_NDVI_merged_with_fireyear_severity_V14c_refined.csv'
indata=read_csv(infile, header=header)
nc=n_tags(indata)
nr=file_lines(infile)-1
content=strarr(nc, nr)
for k=0, nc-1 do content[k, *]=indata.(k)

PIDlist=long(content[0, *])
ndvilist=float(content[1, *])
datayearlist=fix(content[2, *])
fireyearlist=fix(content[3, *])
vegTypelist=fix(content[7, *])

unique_PID_list=unique(PIDlist, /sort)
index_burned_PID=where(unique_PID_list lt 200000, c_burned_PID)

outdata=fltarr(12, 1)

for i=0, c_burned_PID-1 do begin
    PID=unique_PID_list[index_burned_PID[i]]
    for year=1985, 2020 do begin
        index1=where(PIDlist eq PID and datayearlist eq year, c1)
        if c1 eq 0 then continue
        index2=where(PIDlist eq PID+100000 and datayearlist eq year, c2)
        index3=where(PIDlist eq PID+200000 and datayearlist eq year, c3)
        
        if c1 ne 1 or c2 ne 1 or c3 ne 1 then message, 'error!'
        
        NDVI_anomaly_burned_unburned=ndvilist[index1]-ndvilist[index2]
        NDVI_anomaly_background_unburned=ndvilist[index3]-ndvilist[index2]
        NDVI_anomaly_burned_background=ndvilist[index1]-ndvilist[index3]
        
        temp=fltarr(12, 1)
        temp[0:7]=content[*, index1]
        temp[8]=NDVI_anomaly_burned_unburned
        temp[9]=NDVI_anomaly_background_unburned
        temp[10]=NDVI_anomaly_burned_background
        temp[11]=year-fireyearlist[index1]
        outdata=[[outdata], [temp]]
        print, strcompress(string(PID)+'; '+string(year)+ ' done!')
    endfor
endfor

outdata=outdata[*, 1:-1]

outfile='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\NDVImax_anomaly_V14c.csv'
write_csv, outfile, outdata, header=[header, 'NDVI_anomaly_burned_unburned', 'NDVI_anomaly_background_unburned', 'NDVI_anomaly_burned_background', 'Age']
print, outfile+ ' is done!'
end
