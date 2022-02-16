pro ABOVE_tundra_fire_merge_extracted_max_NDVI_V10
inpath='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\GEE_results\V10\'
outpath='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\'

outdata=fltarr(3, 1)

for i=0, 35 do begin
    year=i+1985

    infile=strcompress(inpath+string(year)+'_L8_NDVImax.csv', /remove_all)
    if file_test(infile) eq 0 then begin
        infile=strcompress(inpath+string(year)+'_L57_NDVImax.csv', /remove_all)
        if file_test(infile) eq 0 then continue
        
        indata=read_csv(infile, header=header)
        
        NDVIlist=indata.field2
        pidlist=indata.field6
        
        unique_PIDlist=unique(pidlist, /sort)
        temp=fltarr(3, 60000)

        for j=0, n_elements(unique_PIDlist)-1 do begin
            unique_PID=unique_PIDlist[j]
            
            ndvi=(strsplit((strsplit(NDVIlist[where(pidlist eq unique_PID)], '=', /extract))[1], '}', /extract))
            if ndvi eq 'null' then ndvi=-2 else ndvi=float(ndvi)
            temp[0, j]=unique_PID
            temp[1, j]=ndvi
            temp[2, j]=year
        endfor
    endif else begin
        infile1=strcompress(inpath+string(year)+'_L57_NDVImax.csv', /remove_all)
        indata1=read_csv(infile1, header=header)
        NDVIlist1=indata1.field2
        pidlist1=indata1.field6
        
        infile2=strcompress(inpath+string(year)+'_L8_NDVImax.csv', /remove_all)
        indata2=read_csv(infile2, header=header)
        NDVIlist2=indata2.field2
        pidlist2=indata2.field6

        unique_PIDlist=unique(pidlist1, /sort)
        temp=fltarr(3, 60000)
        
        for j=0, n_elements(unique_PIDlist)-1 do begin
            unique_PID=unique_PIDlist[j]
  
            ndvi1=(strsplit((strsplit(NDVIlist1[where(pidlist1 eq unique_PID)], '=', /extract))[1], '}', /extract))
            if ndvi1 eq 'null' then ndvi1=-2 else ndvi1=float(ndvi1)
            
            ndvi2=(strsplit((strsplit(NDVIlist2[where(pidlist2 eq unique_PID)], '=', /extract))[1], '}', /extract))
            if ndvi2 eq 'null' then ndvi2=-2 else ndvi2=float(ndvi2)
            
            temp[0, j]=unique_PID
            temp[1, j]=max([ndvi1, ndvi2])
            temp[2, j]=year
        endfor
    endelse
    
    outdata=[[outdata], [temp]]
    
    progress_bar, i, 0, 35
endfor

outdata=outdata[*, 1:-1]
NDVI=outdata[1, *]
index_valid=where(NDVI gt -1 and NDVI lt 1)
outdata=outdata[*, index_valid]

outfile=strcompress(outpath+'extracted_max_NDVI_merged_V10.csv', /remove_all)

write_csv, outfile, outdata, header=['PID', 'NDVI', 'DataYear']
end
