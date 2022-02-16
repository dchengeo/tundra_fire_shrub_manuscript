pro ABOVE_tundra_fire_calculate_NDVImax_anomaly_trajectory_by_subregion_by_severity_V14

infile_csv='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\NDVImax_anomaly_V14.csv'
indata_csv=read_csv(infile_csv, header=header)

agelist=indata_csv.field11
regionlist=indata_csv.field07
anomalylist_burned_unburned=indata_csv.field08
anomalylist_background_unburned=indata_csv.field09
anomalylist_burned_background=indata_csv.field10
severitylist=indata_csv.field06
RGlist=['Noatak', 'North Slope', 'Seward', 'South West']
SVlist=['Low', 'Moderate', 'High']

outdata1=strarr(10,1)
outdata2=strarr(10,1)
outdata3=strarr(10,1)

for i=1, 4 do begin
    RG=RGlist[i-1]
    for age=-32, 36 do begin
        index=where(regionlist eq i and agelist eq age, c)
        if c eq 0 then continue
        m1=mean(anomalylist_burned_unburned[index])
        sd1=stddev(anomalylist_burned_unburned[index])
        se1=sd1/sqrt(c)

        temp1=strarr(10,1)
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
        outdata1=[[outdata1], [temp1]]
        
        m2=mean(anomalylist_background_unburned[index])
        sd2=stddev(anomalylist_background_unburned[index])
        se2=sd2/sqrt(c)

        temp2=strarr(10,1)
        temp2[0]=RG
        temp2[1]=age
        temp2[2]=m2
        temp2[3]=c
        temp2[4]=sd2
        temp2[5]=se2
        temp2[6]=m2+se2
        temp2[7]=m2-se2
        temp2[8]=m2+sd2
        temp2[9]=m2-sd2
        outdata2=[[outdata2], [temp2]]
        
        m3=mean(anomalylist_burned_background[index])
        sd3=stddev(anomalylist_burned_background[index])
        se3=sd3/sqrt(c)

        temp3=strarr(10,1)
        temp3[0]=RG
        temp3[1]=age
        temp3[2]=m3
        temp3[3]=c
        temp3[4]=sd3
        temp3[5]=se3
        temp3[6]=m3+se3
        temp3[7]=m3-se3
        temp3[8]=m3+sd3
        temp3[9]=m3-sd3
        outdata3=[[outdata3], [temp3]]
    endfor
endfor

outdata1=outdata1[*, 1:-1]
outdata2=outdata2[*, 1:-1]
outdata3=outdata3[*, 1:-1]
outfile1='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_NDVImax_anomaly_trajectory_by_subregion_V14_burned_vs_unburned.csv'
write_csv, outfile1, outdata1, header=['Region', 'Age', 'Mean', 'C', 'SD', 'SE', 'Upper_SE', 'Lower_SE', 'Upper_SD', 'Lower_SD']
print, outfile1+' is done!'

outfile2='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_NDVImax_anomaly_trajectory_by_subregion_V14_background_vs_unburned.csv'
write_csv, outfile2, outdata2, header=['Region', 'Age', 'Mean', 'C', 'SD', 'SE', 'Upper_SE', 'Lower_SE', 'Upper_SD', 'Lower_SD']
print, outfile2+' is done!'

outfile3='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_NDVImax_anomaly_trajectory_by_subregion_V14_burned_background.csv'
write_csv, outfile3, outdata3, header=['Region', 'Age', 'Mean', 'C', 'SD', 'SE', 'Upper_SE', 'Lower_SE', 'Upper_SD', 'Lower_SD']
print, outfile3+' is done!'


outdata1=strarr(11,1)
outdata2=strarr(11,1)
outdata3=strarr(11,1)
for i=1, 4 do begin
    RG=RGlist[i-1]
    for severity=2, 4 do begin
        SV=SVlist[severity-2]
        for age=-32, 36 do begin
            index=where(regionlist eq i and agelist eq age and severitylist eq severity, c)
            if c eq 0 then continue
            m1=mean(anomalylist_burned_unburned[index])
            sd1=stddev(anomalylist_burned_unburned[index])
            se1=sd1/sqrt(c)
            temp1=strarr(11,1)
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
            outdata1=[[outdata1], [temp1]]
            
            m2=mean(anomalylist_background_unburned[index])
            sd2=stddev(anomalylist_background_unburned[index])
            se2=sd2/sqrt(c)

            temp2=strarr(11,1)
            temp2[0]=RG
            temp2[1]=SV
            temp2[2]=age
            temp2[3]=m2
            temp2[4]=c
            temp2[5]=sd2
            temp2[6]=se2
            temp2[7]=m2+se2
            temp2[8]=m2-se2
            temp2[9]=m2+sd2
            temp2[10]=m2-sd2
            outdata2=[[outdata2], [temp2]]
            
            m3=mean(anomalylist_background_unburned[index])
            sd3=stddev(anomalylist_background_unburned[index])
            se3=sd3/sqrt(c)

            temp3=strarr(11,1)
            temp3[0]=RG
            temp3[1]=SV
            temp3[2]=age
            temp3[3]=m3
            temp3[4]=c
            temp3[5]=sd3
            temp3[6]=se3
            temp3[7]=m3+se3
            temp3[8]=m3-se3
            temp3[9]=m3+sd3
            temp3[10]=m3-sd3
            outdata3=[[outdata3], [temp3]]
        endfor
    endfor
endfor

outdata1=outdata1[*, 1:-1]
outdata2=outdata2[*, 1:-1]
outdata3=outdata3[*, 1:-1]
outfile1='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_NDVImax_anomaly_trajectory_by_subregion_by_severity_V14_burned_vs_unburned.csv'
write_csv, outfile1, outdata1, header=['Region', 'Severity', 'Age', 'Mean', 'C', 'SD', 'SE', 'Upper_SE', 'Lower_SE', 'Upper_SD', 'Lower_SD']
print, outfile1+' is done!'

outfile2='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_NDVImax_anomaly_trajectory_by_subregion_by_severity_V14_background_vs_unburned.csv'
write_csv, outfile2, outdata2, header=['Region', 'Severity', 'Age', 'Mean', 'C', 'SD', 'SE', 'Upper_SE', 'Lower_SE', 'Upper_SD', 'Lower_SD']
print, outfile2+' is done!'

outfile3='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_NDVImax_anomaly_trajectory_by_subregion_by_severity_V14_burned_background.csv'
write_csv, outfile3, outdata3, header=['Region', 'Severity', 'Age', 'Mean', 'C', 'SD', 'SE', 'Upper_SE', 'Lower_SE', 'Upper_SD', 'Lower_SD']
print, outfile3+' is done!'

end