library(ggplot2)
library(scales)
library(ggpubr)

infile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/extracted_NDVImax_anomaly_trajectory_by_subregion_by_severity_V14c_burned_vs_unburned.csv'

indata=read.csv(infile, header=TRUE)
indata=indata[(indata$C>10),]
data1=indata[indata$Region == 'North Slope' & indata$VegType == 'Lowland' ,]
data2=indata[indata$Region == 'North Slope' & indata$VegType == 'Upland' ,]
data3=indata[indata$Region == 'Noatak' & indata$VegType == 'Lowland' ,]
data4=indata[indata$Region == 'Noatak' & indata$VegType == 'Upland' ,]


infile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/max_NDVI_burned_unburned_high_severity_t_test_results_V14c_two_side.csv'
indata_t=read.csv(infile, header=TRUE)
indata_t=na.omit(indata_t) 
indata_t=indata_t[(indata_t$Burned.Count>10),]

pvalue_age=data.frame(matrix(NA, nrow = 1, ncol = 6))

for (row in 1:nrow(indata_t)) {
  p=indata_t[row, 'p.value']
  region=indata_t[row, 'Region']
  age=indata_t[row, 'Age']
  vegetation=indata_t[row, 'Vegetation']
  severity=indata_t[row, 'Severity']
  
  if (p > 0.05){
    next
  }
  
  ndvi=indata[indata$Age==age & indata$Region==region & indata$Severity == severity & indata$VegType == vegetation,]$Mean
  
  data=data.frame(matrix(NA, nrow = 1, ncol = 6))

  data[1]=region
  data[2]=vegetation
  data[3]=age
  data[4]=severity
  data[5]=p
  data[6]=ndvi
  
  pvalue_age=rbind(pvalue_age, data) 
}

colnames(pvalue_age) <- c('Region', 'VegType', 'Age', 'Severity', 'p.value', 'Mean')

data_t1=pvalue_age[pvalue_age$Region == 'North Slope' & pvalue_age$VegType == 'Lowland',]
data_t2=pvalue_age[pvalue_age$Region == 'North Slope' & pvalue_age$VegType == 'Upland',]
data_t3=pvalue_age[pvalue_age$Region == 'Noatak' & pvalue_age$VegType == 'Lowland',]
data_t4=pvalue_age[pvalue_age$Region == 'Noatak' & pvalue_age$VegType == 'Upland',]

g1=ggplot(data1, aes(x=Age, y=Mean, group=Severity, color=Severity, na.rm=TRUE)) + 
  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Severity), alpha=0.3,  show.legend = F)+
  geom_point()+geom_point(data=data_t1, aes(x=Age, y=Mean),shape=4, size=2, color='black', alpha=0.8)+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-10, 35))+
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(-0.2, 0.2))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  scale_color_manual(values=c('lightcoral', 'steelblue1', 'limegreen'), limits=c('High', 'Moderate', 'Low'))+
  labs(color='Severity')+theme_classic()
  

g2=ggplot(data2, aes(x=Age, y=Mean, group=Severity, color=Severity, na.rm=TRUE)) + 
  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Severity), alpha=0.3,  show.legend = F)+
  geom_point()+geom_point(data=data_t2, aes(x=Age, y=Mean),shape=4, size=2, color='black', alpha=0.8)+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-10, 35))+
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(-0.2, 0.2))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  scale_color_manual(values=c('lightcoral', 'steelblue1', 'limegreen'), limits=c('High', 'Moderate', 'Low'))+
  labs(color='Severity')+theme_classic()

g3=ggplot(data3, aes(x=Age, y=Mean, group=Severity, color=Severity, na.rm=TRUE)) + 
  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Severity), alpha=0.3,  show.legend = F)+
  geom_point()+geom_point(data=data_t3, aes(x=Age, y=Mean),shape=4, size=2, color='black', alpha=0.8)+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-10, 35))+
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(-0.2, 0.2))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  scale_color_manual(values=c('lightcoral', 'steelblue1', 'limegreen'), limits=c('High', 'Moderate', 'Low'))+
  labs(color='Severity')+theme_classic()

g4=ggplot(data4, aes(x=Age, y=Mean, group=Severity, color=Severity, na.rm=TRUE)) + 
  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Severity), alpha=0.3,  show.legend = F)+
  geom_point()+geom_point(data=data_t4, aes(x=Age, y=Mean),shape=4, size=2, color='black', alpha=0.8)+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-10, 35))+
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(-0.2, 0.2))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  scale_color_manual(values=c('lightcoral', 'steelblue1', 'limegreen'), limits=c('High', 'Moderate', 'Low'))+
  labs(color='Severity')+theme_classic()

ggarrange(NULL, g1, NULL, g2, NULL, g3, NULL, g4, ncol=1, nrow=8, heights=c(0.2, 1, 0.2, 1, 0.2, 1, 0.2, 1), common.legend=T, 
          legend="bottom", labels = c("a) North Slope Lowland", "", "b) North Slope Upland ",  "", "c) Noatak Lowland", "", "d) Noatak Upland",  ""), 
          hjust=c(0, -0.5, 0, -0.5, 0, -0.5, 0, -0.5), font.label = list(size = 10, color="black"))

ggsave(file='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/point_plots_NDVI_trajectory_burned_anomaly_vs_age_with_severity_with_vegType_with_SE_error_bars_with_bar_charts_V14c3.png', width=8, height=8, dpi=300)

