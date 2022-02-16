library(ggplot2)
library(scales)
library(ggpubr)

infile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/extracted_NDVImax_anomaly_trajectory_by_subregion_by_severity_by_vegetation_V14d_burned_vs_unburned.csv'

indata=read.csv(infile, header=TRUE)
indata=indata[(indata$C>9),]
indata_high=indata[(indata$Severity=="High"),]
data1=indata_high[indata_high$Region == 'North Slope',]
data2=indata_high[indata_high$Region == 'Noatak',]
data3=indata_high[indata_high$Region == 'Seward',]
data4=indata_high[indata_high$Region == 'South West',]


infile_pie='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/number_of_observation_each_vegtation_type_with_severity_V14d.csv'
indata_pie=read.csv(infile_pie, header=TRUE)
data1_pie=indata_pie[indata_pie$Region == 'North Slope' & indata_pie$Severity == 'High',]
data2_pie=indata_pie[indata_pie$Region == 'Noatak' & indata_pie$Severity == 'High',]
data3_pie=indata_pie[indata_pie$Region == 'Seward' & indata_pie$Severity == 'High',]
data4_pie=indata_pie[indata_pie$Region == 'South West' & indata_pie$Severity == 'High',]

g1=ggplot(data1, aes(x=Age, y=Mean, group=VegType, color=VegType, na.rm=TRUE)) + 
  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =VegType), alpha=0.3,  show.legend = F)+
  geom_point()+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-10, 35))+
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(-0.25, 0.3))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  scale_color_manual(values=c('#ac92eb', '#4fc1e8', '#ed5564'), limits=c('Graminoid Tundra', 'Erect-shrub Tundra', 'Wetland'))+
  labs(color='Physiognomic Type')+theme_classic()
  

g2=ggplot(data2, aes(x=Age, y=Mean, group=VegType, color=VegType, na.rm=TRUE)) + 
  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =VegType), alpha=0.3,  show.legend = F)+
  geom_point()+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-10, 35))+
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(-0.25, 0.3))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  scale_color_manual(values=c('#ac92eb', '#4fc1e8', '#ed5564'), limits=c('Graminoid Tundra', 'Erect-shrub Tundra', 'Wetland'))+
  labs(color='Physiognomic Type')+theme_classic()


g3=ggplot(data3, aes(x=Age, y=Mean, group=VegType, color=VegType, na.rm=TRUE)) + 
  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =VegType), alpha=0.3,  show.legend = F)+
  geom_point()+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-10, 35))+
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(-0.25, 0.3))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  # scale_colour_discrete(name  ="VegType", breaks=c('Barren', 'Graminoid Tundra', 'Erect-shrub Tundra', 'Wetland'))+
  scale_color_manual(values=c('#ac92eb', '#4fc1e8', '#ed5564'), limits=c('Graminoid Tundra', 'Erect-shrub Tundra', 'Wetland'))+
  labs(color='Physiognomic Type')+theme_classic()

g4=ggplot(data4, aes(x=Age, y=Mean, group=VegType, color=VegType, na.rm=TRUE)) + 
  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =VegType), alpha=0.3,  show.legend = F)+
  geom_point()+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-10, 35))+
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(-0.25, 0.3))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  scale_color_manual(values=c('#ac92eb', '#4fc1e8', '#ed5564'), limits=c('Graminoid Tundra', 'Erect-shrub Tundra', 'Wetland'))+
  labs(color='Physiognomic Type')+theme_classic()


b1=ggplot(data1_pie, aes(x='', y=Count, fill=VegType)) +
  geom_bar(stat="identity", width=1, color="white") +
  scale_fill_manual(values=c('#ac92eb', '#4fc1e8', '#ed5564', 'gold'), limits=c('Graminoid Tundra', 'Erect-shrub Tundra', 'Wetland', 'Prostrate-shrub Tundra'))+
  coord_polar("y", start=0)+ 
  theme_void()

b2=ggplot(data2_pie, aes(x='', y=Count, fill=VegType)) +
  geom_bar(stat="identity", width=1, color="white") +
  scale_fill_manual(values=c('#ac92eb', '#4fc1e8', '#ed5564', 'gold'), limits=c('Graminoid Tundra', 'Erect-shrub Tundra', 'Wetland', 'Prostrate-shrub Tundra'))+
  coord_polar("y", start=0)+ 
  theme_void()

b3=ggplot(data3_pie, aes(x='', y=Count, fill=VegType)) +
  geom_bar(stat="identity", width=1, color="white") +
  scale_fill_manual(values=c('#ac92eb', '#4fc1e8', '#ed5564', 'gold'), limits=c('Graminoid Tundra', 'Erect-shrub Tundra', 'Wetland', 'Prostrate-shrub Tundra'))+
  coord_polar("y", start=0)+ 
  theme_void()

b4=ggplot(data4_pie, aes(x='', y=Count, fill=VegType)) +
  geom_bar(stat="identity", width=1, color="white") +
  scale_fill_manual(values=c('#ac92eb', '#4fc1e8', '#ed5564', 'gold'), limits=c('Graminoid Tundra', 'Erect-shrub Tundra', 'Wetland', 'Prostrate-shrub Tundra'))+
  coord_polar("y", start=0)+ 
  theme_void()

ggarrange(NULL, NULL, g1, b1, NULL, NULL, g2, b2, NULL, NULL, g3, b3, NULL, NULL, g4, b4, ncol=2, nrow=8, 
          heights=c(0.1, 1, 0.1, 1, 0.1, 1, 0.1, 1), 
          widths=c(4, 1),
          common.legend=T, 
          legend="bottom", labels = c("a) North Slope", "",  "",  "", "b) Noatak",   "",  "",  "", "c) Seward", "",  "",  "", "d) South West",   "",  "",  ""), 
          # hjust=c(0, -0.5, -0.5, -0.5, 0, -0.5, -0.5, -0.5, 0, -0.5, -0.5, -0.5, 0, -0.5, -0.5, -0.5), font.label = list(size = 10, color="black"))
          font.label = list(size = 10, color="black"))

ggsave(file='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/point_plots_NDVI_trajectory_burned_anomaly_vs_age_with_vegType_with_SE_error_bars_V14d_high_severity_with_pie_chart.png', width=8, height=8, dpi=300)

