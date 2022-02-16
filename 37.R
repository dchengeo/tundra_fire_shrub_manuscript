
TPlist=c('Burned', 'Unburned')
RGlist=c('Noatak', 'North Slope')
VegList=c(3, 4)
vegetationnamelist=c('Lowland', 'Upland')
SVlist=c('Low', 'Moderate', 'High')

infile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/extracted_max_NDVI_merged_with_fireyear_severity_V14c_refined.csv'
indata=read.csv(infile, header=TRUE)
indata$Age=indata$DataYear-indata$FireYear


outdata=data.frame(matrix(NA, nrow = 1, ncol = 10))
for (i in seq(4)){
    for (k in seq(2)){
        veg=VegList[k]
        for (j in seq(-10, 36)){
            for (m in seq(3)){
                SV=SVlist[m]
                
                burned=indata[indata$Type==1 & indata$Region==i & indata$Age==j & indata$Severity == m+1 & indata$VegType == veg,]$NDVI
                unburned=indata[indata$Type==2 & indata$Region==i & indata$Age==j & indata$Severity == m+1 & indata$VegType == veg,]$NDVI
                ttest= try(t.test(burned, unburned,  paired = TRUE), silent =TRUE)
                if (length(ttest) == 1){
                    next
                }
                t=ttest$statistic
                p=ttest$p.value
                
                data=data.frame(matrix(NA, nrow = 1, ncol = 10))
                
                data[1]=RGlist[i]
                data[2]=j
                data[3]=SV
                data[4]=mean(burned)
                data[5]=length(burned)
                data[6]=mean(unburned)
                data[7]=length(unburned)
                data[8]=vegetationnamelist[k]
                data[9]=t
                data[10]=p
                
                outdata=rbind(outdata, data) 
                
                print(paste0(str(i), vegetationnamelist[k], str(j), ' is done!'))
            }
        }
    }

}

colnames(outdata) <- c('Region', 'Age', 'Severity', 'Burned Mean', 'Burned Count', 'Unburned Mean', 'Unburned Count', 'Vegetation', 't-stat', 'p-value')

outdata=na.omit(outdata) 

outdata[is.na(outdata$`p-value`), 10]=1
outfile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/max_NDVI_burned_unburned_high_severity_t_test_results_V14c_two_side.csv'
write.csv(outdata, file=outfile, row.names = FALSE)

