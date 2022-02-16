pro ABOVE_tundra_fire_calculate_GEE_burned_unburned_background_NDVImax_trajectory_by_subregion_V14_pre2000_fire

infile_csv='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_max_NDVI_merged_with_fireyear_severity_V14_refined_waterfree.csv'
indata_csv=read_csv(infile_csv, header=header)

nc=n_tags(indata_csv)
nr=file_lines(infile_csv)-1
content=fltarr(nc, nr)
for k=0, nc-1 do content[k, *]=indata_csv.(k)

regionlist=content[6, *]
severitylist=content[5, *]
typelist=content[4, *]
datayearlist=content[2, *]
fireyearlist=content[3, *]

TPlist=['Burned', 'Unburned', 'Background']
RGlist=['Noatak', 'North Slope', 'Seward', 'South West']

outdata_summary=strarr(8, 1)
for k=0, 2 do begin
    TP=TPlist[k]
    for i=1, 4 do begin
        RG=RGlist[i-1]
        for j=0, 35 do begin
            data_year=j+1985
            if data_year le 2005 then continue

            index=where(fireyearlist le 2000 and datayearlist eq data_year  and regionlist eq i and typelist eq k+1, c)
            
            m=mean(content[1, index])
            sd=stddev(content[1, index])
            se=sd/sqrt(c)
            
            temp_summary=strarr(8, 1)
            temp_summary[0, 0]=RG
            temp_summary[1, 0]=m
            temp_summary[2, 0]=c
            temp_summary[3, 0]=sd
            temp_summary[4, 0]=se
            temp_summary[5, 0]=data_year
            temp_summary[6, 0]=TP
            temp_summary[7, 0]=strcompress(RG+'-'+TP)
            
            outdata_summary=[[outdata_summary],[temp_summary]]
            print, RG+'; '+TP+'; '+string(data_year)+ ' is done!'
        endfor
    endfor
endfor

outdata_summary=outdata_summary[*, 1:-1]

outfile_summary='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\1985_2020_annual_burned_unburned_background_NDVImax_mean_GEE_V14_pre2000_fires.csv'
write_csv, outfile_summary, outdata_summary, header=['Region', 'Mean', 'Count', 'SD', 'SE', 'DataYear', 'Type', 'RegionType']





TPlist=['High Severity', 'Moderate/Low Severity', 'Unburned', 'Background']
SVlist=[4, 3, 2]


outdata_summary=strarr(8, 1)
for k=0, 3 do begin
  TP=TPlist[k]
  for i=1, 4 do begin
    RG=RGlist[i-1]
    for j=0, 35 do begin
      data_year=j+1985
      if data_year le 2005 then continue

      if k eq 0 then index=where(fireyearlist le 2000 and datayearlist eq data_year  and regionlist eq i and typelist eq 1 and severitylist eq 4, c) 
      if k eq 1 then index=where(fireyearlist le 2000 and datayearlist eq data_year  and regionlist eq i and typelist eq 1 and (severitylist eq 2 or severitylist eq 3), c) 
      if k eq 2 then index=where(fireyearlist le 2000 and datayearlist eq data_year  and regionlist eq i and typelist eq 2 , c) 
      if k eq 3 then index=where(fireyearlist le 2000 and datayearlist eq data_year  and regionlist eq i and typelist eq 3 , c) 
      

      m=mean(content[1, index])
      sd=stddev(content[1, index])
      se=sd/sqrt(c)

      temp_summary=strarr(8, 1)
      temp_summary[0, 0]=RG
      temp_summary[1, 0]=m
      temp_summary[2, 0]=c
      temp_summary[3, 0]=sd
      temp_summary[4, 0]=se
      temp_summary[5, 0]=data_year
      temp_summary[6, 0]=TP
      temp_summary[7, 0]=strcompress(RG+'-'+TP)

      outdata_summary=[[outdata_summary],[temp_summary]]
      print, RG+'; '+TP+'; '+string(data_year)+ ' is done!'
    endfor
  endfor
endfor

outdata_summary=outdata_summary[*, 1:-1]

outfile_summary='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\1985_2020_annual_burned_unburned_background_NDVImax_mean_GEE_V14_pre2000_fires_by_severity.csv'
write_csv, outfile_summary, outdata_summary, header=['Region', 'Mean', 'Count', 'SD', 'SE', 'DataYear', 'Type', 'RegionType']
end