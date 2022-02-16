pro ABOVE_tundra_fire_attach_fireyear_severity_to_extracted_max_NDVI_V14
infile='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_max_NDVI_merged_V10.csv'
indata=read_csv(infile)
PIDlist=indata.field1
NDVIlist=indata.field2
datayearlist=indata.field3

infile_year='D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\clipped_to_subregion\random_points\MTBS_burned_unburned_random_points_merged_with_year.csv'
indata_csv=read_csv(infile_year)
PIDlist_ref=indata_csv.field3
classlist_ref=indata_csv.field5
fireyearlist_ref=indata_csv.field6

outdata=fltarr(7, n_elements(PIDlist))
outdata[0, *]=PIDlist
outdata[1, *]=NDVIlist
outdata[2, *]=datayearlist


for PID=100000, 119999 do begin
    
    index=where(PIDlist eq PID, c)
    
    if c eq 0 then continue
    outdata[3, index]=fireyearlist_ref[where(PIDlist_ref eq PID)]
    outdata[4, index]=byte(long(PID) / 100000)
    outdata[5, index]=classlist_ref[where(PIDlist_ref eq PID)]
    
    index_unburned=where(PIDlist eq PID+100000, c)
    outdata[3, index_unburned]=fireyearlist_ref[where(PIDlist_ref eq PID)]
    outdata[4, index_unburned]=byte(long(PID+100000) / 100000)
    outdata[5, index_unburned]=classlist_ref[where(PIDlist_ref eq PID)]
    
    index_background=where(PIDlist eq PID+200000, c)
    outdata[3, index_background]=fireyearlist_ref[where(PIDlist_ref eq PID)]
    outdata[4, index_background]=byte(long(PID+200000) / 100000)
    outdata[5, index_background]=classlist_ref[where(PIDlist_ref eq PID)]
    
    progress_bar, pid, 100000, 119999
endfor

;Region number: 1: Noatak, 2: North Slope, 3: Seward, 4: South West
outdata[6,*]=(long(outdata[0,*])mod 100000)/5000+1

outfile='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_max_NDVI_merged_with_fireyear_severity_V14_all.csv'
;write_csv, outfile, outdata, header=['PID', 'NDVI', 'DataYear', 'FireYear', 'Type', 'Severity', 'Region']

PIDlist_all=outdata[0, *]
NDVIlist_all=outdata[1, *]
datayear_list_all=outdata[2, *]

outdata_refined=fltarr(7, 1)
for PID=100000, 119999 do begin
    for year=1985, 2020 do begin
        index1=where(PIDlist_all eq PID and datayear_list_all eq year, c1)
        index2=where(PIDlist_all eq PID+100000 and datayear_list_all eq year, c2)
        index3=where(PIDlist_all eq PID+200000 and datayear_list_all eq year, c3)
        if c1 eq 0 or c2 eq 0 or c3 eq 0 then continue
        
        index_new=[index1, index2, index3]
        if n_elements(index_new) ne 3 then message, 'error!'
        if NDVIlist_all[index1] ne -2 and NDVIlist_all[index2] ne -2 and NDVIlist_all[index3] ne -2 then outdata_refined=[[outdata_refined], [outdata[*, index_new]]]
        print, string(PID)+' done!'
    endfor
endfor
outdata_refined=outdata_refined[*, 1:-1]
outfile_refined='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_max_NDVI_merged_with_fireyear_severity_V14_refined.csv'
write_csv, outfile_refined, outdata_refined, header=['PID', 'NDVI', 'DataYear', 'FireYear', 'Type', 'Severity', 'Region']

end
