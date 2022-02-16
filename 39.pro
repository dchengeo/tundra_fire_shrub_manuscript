pro ABOVE_tundra_fire_drop_no_vegetation_type_sample_points_V14d
infile='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_max_NDVI_merged_with_fireyear_severity_V14_refined.csv'
outfile='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_max_NDVI_merged_with_fireyear_severity_V14d_refined.csv'

indata=read_csv(infile, header=header)
nc=n_tags(indata)
nr=file_lines(infile)-1
content=fltarr(nc, nr)
for k=0, nc-1 do content[k, *]=indata.(k)

pidlist=indata.field1

infile_water='D:\lobodagp\dchen\Tony\ABOVE\GIS\burned_unburned_background_sample_points_V10.csv'
indata_csv=read_csv(infile_water)
pidlist_water=indata_csv.field3
watervalue_list=indata_csv.field8

infile_vegetation='D:\lobodagp\dchen\Tony\ABOVE\tundra_wide_analysis\MTBS\clipped\merged\clipped_to_subregion\random_points\MTBS_burned_area_random_points_merged_joined_with_BID_year.csv'
indata_csv=read_csv(infile_vegetation)
pidlist_veg=indata_csv.field3
vegvalue_list1=indata_csv.field6
vegvalue_list2=indata_csv.field7

outdata=fltarr(9, 1)
outdata_preserved=lonarr(1, 1)

for PID=100000, 119999 do begin
    if vegvalue_list1[where(pidlist_veg eq PID)] eq -9999 then continue
    
    index_water1=where(pidlist_water eq pid, c_water1)
    if c_water1 ne 1 then message, 'error!'
    index_water2=where(pidlist_water eq pid+100000, c_water1)
    index_water3=where(pidlist_water eq pid+200000, c_water1)
    
    watervalue1=watervalue_list[index_water1]
    watervalue2=watervalue_list[index_water2]
    watervalue3=watervalue_list[index_water3]
    
    
    if total([watervalue1, watervalue2, watervalue3]) eq 0 then begin
        index=where(pidlist eq PID or pidlist eq PID+100000 or pidlist eq PID+200000, c)
        temp=fltarr(9, c)
        temp[0:6, *]=content[*, index]
        temp[7, *]=vegvalue_list1[where(pidlist_veg eq PID)]
        temp[8, *]=vegvalue_list2[where(pidlist_veg eq PID)]
        
        
        outdata=[[outdata], [temp]]
        
        temp_preserved=lonarr(1, 3)
        temp_preserved[0]=PID
        temp_preserved[1]=PID+100000
        temp_preserved[2]=PID+200000
        outdata_preserved=[[outdata_preserved], [temp_preserved]]
    endif 
    progress_bar, PID, 100000, 119999
endfor

outdata=outdata[*, 1:-1]
outdata_preserved=outdata_preserved[*, 1:-1]

outfile_preserved='C:\Users\itscd\Dropbox\Tables\ABoVE_Tundra_Fire\extracted_max_NDVI_merged_with_fireyear_severity_V14d_refined_preserved_PIDs.csv'
write_csv, outfile, outdata, header=[header, 'VegType_5class', 'VegType_16class']
write_csv, outfile_preserved, outdata_preserved
print, outfile+' is done!'

end




