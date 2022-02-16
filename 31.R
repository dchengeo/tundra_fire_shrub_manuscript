
TPlist=c('Burned', 'Unburned')
RGlist=c('Noatak', 'North Slope', 'Seward', 'South West')
SVlist=c('Low', 'Moderate', 'High')

infile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/extracted_max_NDVI_merged_with_fireyear_severity_V14_refined_waterfree.csv'
indata=read.csv(infile, header=TRUE)
indata$Age=indata$DataYear - indata$FireYear
outdata=data.frame(matrix(NA, nrow = 1, ncol = 7))

for (i in seq(4)){
  for (k in seq(3)){
    SV=SVlist[k]
    severity=k+1
    for (j in seq(69)){
        age=j-33

        unburned=indata[indata$Type==2 & indata$Region==i & indata$Age==age & indata$Severity==severity,]$NDVI
        burned=indata[indata$Type==1 & indata$Region==i & indata$Age==age & indata$Severity==severity,]$NDVI
        ttest= try(t.test(burned, unburned, paired = TRUE), silent =TRUE)
        if (length(ttest) == 1){
            next
        }
        t=ttest$statistic
        p=ttest$p.value

        data=data.frame(matrix(NA, nrow = 1, ncol = 7))
        data[1]=RGlist[i]
        data[2]=age
        data[3]=SV
        data[4]=length(burned)
        data[5]=length(unburned)
        data[6]=t
        data[7]=p
        
        outdata=rbind(outdata, data) 
        
        print(paste0(str(i), str(age), ' is done!'))
      }
  }
}
colnames(outdata) <- c('Region', 'Age', 'Severity', 'burnedCount', 'UnburnedCount', 't-stat', 'p-value')

outdata[is.na(outdata$`p-value`), 7]=1
outfile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/max_NDVI_burned_unburned_all_severity_t_test_results_V14_twoside_paired.csv'
write.csv(outdata, file=outfile, row.names = FALSE)


outdata=data.frame(matrix(NA, nrow = 69*4, ncol = 6))
colnames(outdata) <- c('Region', 'Age', 'burnedCount', 'UnburnedCount', 't-stat', 'p-value')
for (i in seq(4)){
  for (j in seq(69)){
    age=j-33
    outdata[(i-1)*69+j, 1]=RGlist[i]
    outdata[(i-1)*69+j, 2]=age
    
    unburned=indata[indata$Type==2 & indata$Region==i & indata$Age==age ,]$NDVI
    burned=indata[indata$Type==1 & indata$Region==i & indata$Age==age,]$NDVI
    ttest= try(t.test(burned, unburned, alternative="greater", paired = TRUE), silent =TRUE)
    if (length(ttest) == 1){
      next
    }
    t=ttest$statistic
    p=ttest$p.value
    
    outdata[(i-1)*69+j, 3]=length(burned)
    outdata[(i-1)*69+j, 4]=length(unburned)
    outdata[(i-1)*69+j, 5]=t
    outdata[(i-1)*69+j, 6]=p
    print(paste0(str(i), str(age), ' is done!'))
  }
  
}

outdata[is.na(outdata$`p-value`), 6]=1
outfile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/max_NDVI_burned_unburned_all_severity_t_test_results_V14_oneside_paired.csv'
write.csv(outdata, file=outfile, row.names = FALSE)
