library(ggplot2)
library(scales)
library(ggpubr)


infile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/extracted_NDVImax_anomaly_trajectory_by_subregion_V14_burned_vs_unburned.csv'
indata=read.csv(infile, header=TRUE)
indata=indata[(indata$Age>-11),]

data1=indata[indata$Region == 'North Slope',]
data2=indata[indata$Region == 'Noatak',]
data3=indata[indata$Region == 'Seward',]
data4=indata[indata$Region == 'South West',]

ymin=-0.2
ymax=0.2
g1=ggplot(data1, aes(x=Age, y=Mean)) +  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE), alpha=0.3,  show.legend = F)+
  geom_point()+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-11, 37))+
  annotate("rect",
           xmin = c(-8.5, 2.5, 18.5 ),
           xmax = c(-0.5, 13.5, 35),
           ymin = ymin, ymax = ymax,
           alpha = 0.2, fill = c("gray42")) +
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(ymin, ymax), breaks = seq(-0.4, 0.4,by = 0.1))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  theme_classic()

ymin=-0.1
ymax=0.1
g2=ggplot(data2, aes(x=Age, y=Mean)) + geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE), alpha=0.3,  show.legend = F)+
  geom_point()+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-11, 37))+
  annotate("rect",
           xmin = c(-10, 2.5, 11.5, 21.5),
           xmax = c(-0.5, 10.5, 12.5, 35),
           ymin = ymin, ymax = ymax,
           alpha = 0.2, fill = c("gray42")) +
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(ymin, ymax), breaks = seq(-0.4, 0.4,by = 0.1))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  theme_classic()

ymin=-0.15
ymax=0.15
g3=ggplot(data3, aes(x=Age, y=Mean)) + geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE), alpha=0.3,  show.legend = F)+
  geom_point()+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-11, 37))+
  annotate("rect",
           xmin = c(4.5,9.5, 12.5, 29.5, 32.5),
           xmax = c(8.5, 10.5, 16.5, 30.5, 34.5),
           ymin = ymin, ymax = ymax,
           alpha = 0.2, fill = c("gray42")) +
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(ymin, ymax), breaks = seq(-0.4, 0.4,by = 0.1))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  theme_classic()

ymin=-0.2
ymax=0.35
g4=ggplot(data4, aes(x=Age, y=Mean)) + geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE), alpha=0.3,  show.legend = F)+
  geom_point()+
  scale_x_continuous(name ='Year since Fire', breaks = seq(-40, 40, by = 10), limits = c(-11, 37))+
  annotate("rect",
           xmin = c(14.5, 19.5, 24.5, 29.5, 31.5 ),
           xmax = c(18.5, 23.5, 27.5, 30.5, 36),
           ymin = ymin, ymax = ymax,
           alpha = 0.2, fill = c("gray42")) +
  scale_y_continuous(name=expression(Delta*"NDVImax"), limits = c(ymin, ymax), breaks = seq(-0.4, 0.4,by = 0.1))+ 
  geom_hline(yintercept=0, color='gray42')+ geom_vline(xintercept=0, color='gray42')+
  theme_classic()

ggarrange(NULL, g1, NULL, g2, NULL, g3, NULL, g4, ncol=1, nrow=8, heights=c(0.15, 1, 0.15, 1, 0.15, 1, 0.15, 1), common.legend=T, 
          legend="bottom", labels = c("a) North Slope", "", "b) Noatak",  "", "c) Seward", "", "d) South West",  ""), 
          hjust=c(0, -0.5, 0, -0.5, 0, -0.5, 0, -0.5), font.label = list(size = 10, color="black"))



ggsave(file='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/line_plots_NDVI_trajectory_burned_anomaly_vs_age_with_SE_error_bars_V14V2.png', width=8, height=8, dpi=300)






