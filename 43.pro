pro ABOVE_tundra_fire_count_number_of_observation_each_vegtation_type_with_high_severity_V14d_base_on_PIDs
infile='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\NDVImax_anomaly_V14d.csv'
;infile="/home/chend/extracted_max_NDVI_merged_with_fireyear_severity_V14d_refined.csv"
indata=read_csv(infile, header=header)
nc=n_tags(indata)
nr=file_lines(infile)-1
content=strarr(nc, nr)
for k=0, nc-1 do content[k, *]=indata.(k)

PIDlist=long(content[0, *])
severitylist=fix(content[5, *])
regionlist=fix(content[6, *])
vegtypelist=fix(content[7, *])

RGlist=['Noatak', 'North Slope', 'Seward', 'South West']
vegTypeRef=[1, 2, 3, 4, 5]
SVlist=['Low', 'Moderate', 'High']
VGlist=['Barren', 'Graminoid Tundra', 'Prostrate-shrub Tundra', 'Erect-shrub Tundra', 'Wetland']
outdata=strarr(4, 1)

for region=1, 4 do begin
    for i=0, 4 do begin
        vegtype=vegTypeRef[i]
        for severity=2, 4 do begin
            index=where(severitylist eq severity and regionlist eq region and vegtypelist eq vegtype, c)
            
            if c eq 0 then continue
            
            PID_selected=PIDlist[index]
            
            unique_PIDlist=unique(PID_selected, /sort, c_unique)
            n_unique_PIDlist=n_elements(unique_PIDlist)
            
            temp=strarr(4, 1)
            temp[0]=RGlist[region-1]
            temp[1]=VGlist[i]
            temp[2]=SVlist[severity-2]
            temp[3]=n_unique_PIDlist
            
            outdata=[[outdata],[temp]]
        endfor
    endfor
endfor
    
outdata=outdata[*, 1:-1]

outfile='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\number_of_observation_each_vegtation_type_with_severity_V14d.csv'
write_csv, outfile, outdata, header=['Region', 'VegType', 'Severity', 'Count']
print, outfile+ ' is done!'
end
