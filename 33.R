library(ggplot2)
library(scales)
library(ggpubr)

infile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/extracted_NDVImax_anomaly_trajectory_by_subregion_by_severity_V14_burned_vs_unburned.csv'

indata=read.csv(infile, header=TRUE)
indata=indata[(indata$Age>-11),]
indata[indata$SD == "NaN", ]$Mean=NA
indata[indata$SD == "NaN", ]$SD=NA
data1=indata[indata$Region == 'North Slope',]
data2=indata[indata$Region == 'Noatak',]
data3=indata[indata$Region == 'Seward',]
data4=indata[indata$Region == 'South West',]

infile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/max_NDVI_burned_unburned_all_severity_t_test_results_V14_twoside_paired.csv'
indata_t=read.csv(infile, header=TRUE)
indata_t=na.omit(indata_t) 

pvalue_age=data.frame(matrix(NA, nrow = 1, ncol = 5))

for (row in 1:nrow(indata_t)) {
  p=indata_t[row, 'p.value']
  region=indata_t[row, 'Region']
  age=indata_t[row, 'Age']
  severity=indata_t[row, 'Severity']
  
  if (p > 0.05){
    next
  }
  
  ndvi=indata[indata$Age==age & indata$Region==region & indata$Severity == severity,]$Mean
  
  data=data.frame(matrix(NA, nrow = 1, ncol = 5))
  
  data[1]=region
  data[2]=age
  data[3]=severity
  data[4]=p
  data[5]=ndvi

  pvalue_age=rbind(pvalue_age, data) 
}

colnames(pvalue_age) <- c('Region',  'Age', 'Severity', 'p.value', 'Mean')

data_t1=pvalue_age[pvalue_age$Region == 'North Slope',]
data_t2=pvalue_age[pvalue_age$Region == 'Noatak',]
data_t3=pvalue_age[pvalue_age$Region == 'Seward',]
data_t4=pvalue_age[pvalue_age$Region == 'South West',]


ymin=-0.2
ymax=0.2
g1=ggplot(data1, aes(x=Age, y=Mean, group=Severity, color=Severity, na.rm=TRUE)) + 
  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Severity), alpha=0.3,  show.legend = F)+
  geom_point()+geom_point(data=data_t1, aes(x=Age, y=Mean),shape=4, size=2, color='black', alpha=0.8)+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-11, 37))+
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(ymin, ymax), breaks = seq(-0.4, 0.4,by = 0.1))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  scale_colour_discrete(name  ="Severity", breaks=c("High", "Moderate", "Low"))+
  labs(color='Severity', fill='Severity')+theme_classic()
  

ymin=-0.1
ymax=0.1
g2=ggplot(data2, aes(x=Age, y=Mean, group=Severity, color=Severity, na.rm=TRUE)) + 
  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Severity), alpha=0.3,  show.legend = F)+
  geom_point()+geom_point(data=data_t2, aes(x=Age, y=Mean),shape=4, size=2, color='black', alpha=0.8)+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-11, 37))+
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(ymin, ymax), breaks = seq(-0.4, 0.4,by = 0.1))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  labs(color='Severity', fill='Severity')+theme_classic()

ymin=-0.15
ymax=0.15
g3=ggplot(data3, aes(x=Age, y=Mean, group=Severity, color=Severity, na.rm=TRUE)) + 
  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Severity), alpha=0.3,  show.legend = F)+
  geom_point()+geom_point(data=data_t3, aes(x=Age, y=Mean),shape=4, size=2, color='black', alpha=0.8)+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-11, 37))+
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(ymin, ymax), breaks = seq(-0.4, 0.4,by = 0.1))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  labs(color='Severity', fill='Severity')+theme_classic()

ymin=-0.2
ymax=0.35
g4=ggplot(data4, aes(x=Age, y=Mean, group=Severity, color=Severity, na.rm=TRUE)) + 
  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Severity), alpha=0.3,  show.legend = F)+
  geom_point()+geom_point(data=data_t4, aes(x=Age, y=Mean),shape=4, size=2, color='black', alpha=0.8)+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-11, 37))+
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(ymin, ymax), breaks = seq(-0.4, 0.4,by = 0.1))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  labs(color='Severity', fill='Severity')+theme_classic()

ggarrange(NULL, g1, NULL, g2, NULL, g3, NULL, g4, ncol=1, nrow=8, heights=c(0.15, 1, 0.15, 1, 0.15, 1, 0.15, 1), common.legend=T, 
          legend="bottom", labels = c("a) North Slope", "", "b) Noatak",  "", "c) Seward", "", "d) South West",  ""), 
          hjust=c(0, -0.5, 0, -0.5, 0, -0.5, 0, -0.5), font.label = list(size = 10, color="black"))

   
ggsave(file='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/line_plots_NDVI_trajectory_burned_anomaly_vs_age_with_severity_with_SE_error_bars_V14V3.png', width=8, height=8, dpi=300)

