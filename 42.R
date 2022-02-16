
TPlist=c('Burned', 'Unburned')
RGlist=c('Noatak', 'North Slope', 'Seward', 'South West')
VegList=c(2, 4, 5)
vegetationnamelist=c('Graminoid Tundra', 'Erect-shrub Tundra', 'Wetland')

infile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/extracted_max_NDVI_merged_with_fireyear_severity_V14d_refined.csv'
indata=read.csv(infile, header=TRUE)
indata$Age=indata$DataYear-indata$FireYear


outdata=data.frame(matrix(NA, nrow = 1, ncol = 9))
for (i in seq(4)){
    for (k in seq(3)){
        veg=VegList[k]
        for (j in seq(-10, 36)){
            

            
            burned=indata[indata$Type==1 & indata$Region==i & indata$Age==j & indata$Severity == 4 & indata$VegType_5class == veg,]$NDVI
            unburned=indata[indata$Type==2 & indata$Region==i & indata$Age==j & indata$Severity == 4 & indata$VegType_5class == veg,]$NDVI
            ttest= try(t.test(burned, unburned,  paired = TRUE), silent =TRUE)
            if (length(ttest) == 1){
                next
            }
            t=ttest$statistic
            p=ttest$p.value
            
            data=data.frame(matrix(NA, nrow = 1, ncol = 9))
            
            data[1]=RGlist[i]
            data[2]=j
            data[3]=mean(burned)
            data[4]=length(burned)
            data[5]=mean(unburned)
            data[6]=length(unburned)
            data[7]=vegetationnamelist[k]
            data[8]=t
            data[9]=p
            
            outdata=rbind(outdata, data) 
            
            print(paste0(str(i), vegetationnamelist[k], str(j), ' is done!'))
        }
    }

}

colnames(outdata) <- c('Region', 'Age', 'Burned Mean', 'Burned Count', 'Unburned Mean', 'Unburned Count', 'Vegetation', 't-stat', 'p-value')

outdata=na.omit(outdata) 

outdata[is.na(outdata$`p-value`), 9]=1
outfile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/max_NDVI_burned_unburned_high_severity_t_test_results_V14d_two_side.csv'
write.csv(outdata, file=outfile, row.names = FALSE)

