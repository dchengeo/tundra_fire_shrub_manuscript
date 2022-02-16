library(ggplot2)
library(scales)
library(ggpubr)

# 
# infile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/1985_2020_annual_burned_unburned_background_NDVImax_mean_GEE_V14_pre2000_fires.csv'
# indata=read.csv(infile, header=TRUE)
# 
# data1=indata[indata$Region == 'North Slope',]
# data2=indata[indata$Region == 'Noatak',]
# data3=indata[indata$Region == 'Seward',]
# data4=indata[indata$Region == 'South West',]
# 
# 
# 
# g1=ggplot(data1, aes(group=Type, x=DataYear, y=Mean, color=Type)) +  geom_line()+
#   geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Type), alpha=0.3,  show.legend = F)+
#   geom_point()+
#   scale_x_continuous(name ='Year', breaks = seq(2005, 2020, by = 5), limits = c(2005, 2021))+
#   scale_y_continuous(name='North Slope', limits = c(0.5, 0.9))+scale_color_manual(values=c('red', 'green', 'blue'), breaks=c('Burned', 'Unburned', 'Background'))+
#   theme_classic()
# 
# g2=ggplot(data2, aes(group=Type, x=DataYear, y=Mean, color=Type)) +  geom_line()+
#   geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Type), alpha=0.3,  show.legend = F)+
#   geom_point()+
#   scale_x_continuous(name ='Year', breaks = seq(2005, 2020, by = 5), limits = c(2005, 2021))+
#   scale_y_continuous(name='Noatak', limits = c(0.5, 0.9))+scale_color_manual(values=c('red', 'green', 'blue'), breaks=c('Burned', 'Unburned', 'Background'))+
#   theme_classic()
# 
# g3=ggplot(data3, aes(group=Type, x=DataYear, y=Mean, color=Type)) +  geom_line()+
#   geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Type), alpha=0.3,  show.legend = F)+
#   geom_point()+
#   scale_x_continuous(name ='Year', breaks = seq(2005, 2020, by = 5), limits = c(2005, 2021))+
#   scale_y_continuous(name='Seward', limits = c(0.5, 0.9))+scale_color_manual(values=c('red', 'green', 'blue'), breaks=c('Burned', 'Unburned', 'Background'))+
#   theme_classic()
# 
# g4=ggplot(data4, aes(group=Type, x=DataYear, y=Mean, color=Type))  +  geom_line()+
#   geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Type), alpha=0.3,  show.legend = F)+
#   geom_point()+
#   scale_x_continuous(name ='Year', breaks = seq(2005, 2020, by = 5), limits = c(2005, 2021))+
#   scale_y_continuous(name='South West', limits = c(0.5, 0.9))+scale_color_manual(values=c('red', 'green', 'blue'), breaks=c('Burned', 'Unburned', 'Background'))+
#   theme_classic()
# 
# ggarrange(g1, g2, g3, g4, ncol=1, nrow=4, common.legend=TRUE, legend="bottom")
# 
# ggsave(file='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/line_plots_NDVI_trajectory_burned_unburned_background_by_subregion_V14_pre2000_fires.png', width=8, height=8, dpi=300)


infile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/1985_2020_annual_burned_unburned_background_NDVImax_mean_GEE_V14_pre2000_fires_by_severity.csv'
indata=read.csv(infile, header=TRUE)

data1=indata[indata$Region == 'North Slope',]
data2=indata[indata$Region == 'Noatak',]
data3=indata[indata$Region == 'Seward',]
data4=indata[indata$Region == 'South West',]


g1=ggplot(data1, aes(group=Type, x=DataYear, y=Mean, color=Type)) +  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Type), alpha=0.3,  show.legend = F)+
  geom_point()+
  scale_x_continuous(name ='Year', breaks = seq(2005, 2020, by = 5), limits = c(2005, 2021))+
  scale_y_continuous(name="NDVImax", limits = c(0.5, 0.9))+scale_color_manual(values=c('red', 'orange', 'limegreen', 'deepskyblue'), breaks=c('High Severity', 'Moderate/Low Severity', 'Unburned', 'Background'))+
  theme_classic()

g2=ggplot(data2, aes(group=Type, x=DataYear, y=Mean, color=Type)) +  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Type), alpha=0.3,  show.legend = F)+
  geom_point()+
  scale_x_continuous(name ='Year', breaks = seq(2005, 2020, by = 5), limits = c(2005, 2021))+
  scale_y_continuous(name="NDVImax", limits = c(0.5, 0.9))+scale_color_manual(values=c('red', 'orange', 'limegreen', 'deepskyblue'), breaks=c('High Severity', 'Moderate/Low Severity', 'Unburned', 'Background'))+
  theme_classic()

g3=ggplot(data3, aes(group=Type, x=DataYear, y=Mean, color=Type)) +  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Type), alpha=0.3,  show.legend = F)+
  geom_point()+
  scale_x_continuous(name ='Year', breaks = seq(2005, 2020, by = 5), limits = c(2005, 2021))+
  scale_y_continuous(name="NDVImax", limits = c(0.5, 0.9))+scale_color_manual(values=c('red', 'orange', 'limegreen', 'deepskyblue'), breaks=c('High Severity', 'Moderate/Low Severity', 'Unburned', 'Background'))+
  theme_classic()

g4=ggplot(data4, aes(group=Type, x=DataYear, y=Mean, color=Type))  +  geom_line()+
  geom_errorbar(aes(ymin=Mean-SE, ymax=Mean+SE, group =Type), alpha=0.3,  show.legend = F)+
  geom_point()+
  scale_x_continuous(name ='Year', breaks = seq(2005, 2020, by = 5), limits = c(2005, 2021))+
  scale_y_continuous(name="NDVImax", limits = c(0.5, 0.9))+scale_color_manual(values=c('red', 'orange', 'limegreen', 'deepskyblue'), breaks=c('High Severity', 'Moderate/Low Severity', 'Unburned', 'Background'))+
  theme_classic()

ggarrange(NULL, NULL, g1, g2, NULL,  NULL, g3,g4, ncol=2, nrow=4, heights=c(0.05, 1, 0.05, 1), common.legend=T, 
          legend="bottom", labels = c("a) North Slope", "b) Noatak", "",  "", "c) Seward", "d) South West","",   ""), 
          hjust=c(0, 0, -0.5, -0.5, 0, 0, -0.5, -0.5), font.label = list(size = 10, color="black"))

ggsave(file='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/line_plots_NDVI_trajectory_unburned_background_by_subregion_V14_pre2000_fires_by_severity.png', width=8, height=8, dpi=300)
