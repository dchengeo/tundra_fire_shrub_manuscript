pro ABOVE_tundra_fire_calculate_NDVImax_anomaly_trajectory_by_subregion_by_severity_V14c

infile_csv='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\NDVImax_anomaly_V14c.csv'
indata_csv=read_csv(infile_csv, header=header)

agelist=indata_csv.field12
regionlist=indata_csv.field07
anomalylist_burned_unburned=indata_csv.field09
veglist=indata_csv.field08
severitylist=indata_csv.field06
RGlist=['Noatak', 'North Slope', 'Seward', 'South West']
SVlist=['Low', 'Moderate', 'High']
vegTypeRef=[2, 3, 4, 5]
vegTypelist=['Riverine', 'Lowland', 'Upland', 'Alpine']

outdata1=strarr(12,1)

for i=1, 4 do begin
    RG=RGlist[i-1]
    for j=0, 3 do begin
        veg=vegTypelist[j]
    
        for severity=2, 4 do begin
            SV=SVlist[severity-2]
            for age=-32, 36 do begin
                index=where(regionlist eq i and agelist eq age and severitylist eq severity and veglist eq vegTypeRef[j], c)
                if c eq 0 then continue
                m1=mean(anomalylist_burned_unburned[index])
                sd1=stddev(anomalylist_burned_unburned[index])
                se1=sd1/sqrt(c)
                temp1=strarr(12,1)
                temp1[0]=RG
                temp1[1]=SV
                temp1[2]=age
                temp1[3]=m1
                temp1[4]=c
                temp1[5]=sd1
                temp1[6]=se1
                temp1[7]=m1+se1
                temp1[8]=m1-se1
                temp1[9]=m1+sd1
                temp1[10]=m1-sd1
                temp1[11]=veg
                outdata1=[[outdata1], [temp1]]
            
            endfor
        endfor
    endfor
endfor

outdata1=outdata1[*, 1:-1]

outfile1='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_NDVImax_anomaly_trajectory_by_subregion_by_severity_V14c_burned_vs_unburned.csv'
write_csv, outfile1, outdata1, header=['Region', 'Severity', 'Age', 'Mean', 'C', 'SD', 'SE', 'Upper_SE', 'Lower_SE', 'Upper_SD', 'Lower_SD', 'VegType']
print, outfile1+' is done!'



outdata1=strarr(11,1)

for i=1, 4 do begin
  RG=RGlist[i-1]
  for j=0, 3 do begin
    veg=vegTypelist[j]

      for age=-32, 36 do begin
        index=where(regionlist eq i and agelist eq age and veglist eq vegTypeRef[j], c)
        if c eq 0 then continue
        m1=mean(anomalylist_burned_unburned[index])
        sd1=stddev(anomalylist_burned_unburned[index])
        se1=sd1/sqrt(c)
        temp1=strarr(11,1)
        temp1[0]=RG
        temp1[1]=age
        temp1[2]=m1
        temp1[3]=c
        temp1[4]=sd1
        temp1[5]=se1
        temp1[6]=m1+se1
        temp1[7]=m1-se1
        temp1[8]=m1+sd1
        temp1[9]=m1-sd1
        temp1[10]=veg
        outdata1=[[outdata1], [temp1]]

    endfor
  endfor
endfor

outdata1=outdata1[*, 1:-1]

outfile1='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_NDVImax_anomaly_trajectory_by_subregion_all_severity_V14c_burned_vs_unburned.csv'
write_csv, outfile1, outdata1, header=['Region', 'Age', 'Mean', 'C', 'SD', 'SE', 'Upper_SE', 'Lower_SE', 'Upper_SD', 'Lower_SD', 'VegType']
print, outfile1+' is done!'

end