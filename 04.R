library(ggplot2)
library(scales)
library(ggpubr)

infile='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/field_data_point_with_NDVImax_V2.csv'
indata=read.csv(infile, header=TRUE)

data1=indata[indata$Region == 'North Slope',]
data2=indata[indata$Region == 'Noatak',]
data3=indata[indata$Region == 'Seward',]
data4=indata[indata$Region == 'South West',]

m1_shrub=lm(data1[data1$Type == 'Shrub',]$NDVImax ~ data1[data1$Type == 'Shrub',]$Cover)
a1_shrub = format(coef(m1_shrub)[1], digits = 3)
b1_shrub = format(coef(m1_shrub)[2], digits = 3)
r2_1_shrub = format(summary(m1_shrub)$r.squared, digits = 3)
p_1_shrub = format(summary(m1_shrub)$coefficients[,4][2], digits  = 3)

m1_graminoid=lm(data1[data1$Type == 'Graminoid',]$NDVImax ~ data1[data1$Type == 'Graminoid',]$Cover)
a1_graminoid = format(coef(m1_graminoid)[1], digits = 3)
b1_graminoid = format(coef(m1_graminoid)[2], digits = 3)
r2_1_graminoid = format(summary(m1_graminoid)$r.squared, digits = 3)
p_1_graminoid = format(summary(m1_graminoid)$coefficients[,4][2], digits = 3)


g1=ggplot(data1, aes(x=Cover, y=NDVImax, colour=Type))+geom_point(size = 2, alpha=0.3)+  labs(x = "Vegetation Cover (%)", y="NDVImax") + xlim(0, 100)+ylim(0, 1)+geom_smooth(method=lm, se = FALSE)+
  scale_color_manual(values=c('gray50', 'gold2'), breaks=c('Shrub', 'Graminoid'))+
  annotate("text", x = 75, y = 0.35, size=3, color='gray30', label = paste0("NDVImax = ", b1_shrub, " * SC + ", a1_shrub), parse=F)+
  annotate("text", x = 75, y = 0.30, size=3, color='gray30',  label = paste0('list(R^2 ==', as.character(r2_1_shrub),  ', ~p ==', as.character(p_1_shrub), ')'), parse=T)+
  annotate("text", x = 75, y = 0.95, size=3, color='gold3', label = paste0("NDVImax = ", b1_graminoid, " * GC + ", a1_graminoid ), parse=F)+
  annotate("text", x = 75, y = 0.90, size=3, color='gold3',  label = paste0('list(R^2 ==', as.character(r2_1_graminoid), ', ~p ==', as.character(p_1_graminoid), ')'), parse=T)+
  theme_classic()

m2_shrub=lm(data2[data2$Type == 'Shrub',]$NDVImax ~ data2[data2$Type == 'Shrub',]$Cover)
a2_shrub = format(coef(m2_shrub)[1], digits = 3)
b2_shrub = format(coef(m2_shrub)[2], digits = 3)
r2_2_shrub = format(summary(m2_shrub)$r.squared, digits = 3)
p_2_shrub = format(summary(m2_shrub)$coefficients[,4][2], digits  = 3)

m2_graminoid=lm(data2[data2$Type == 'Graminoid',]$NDVImax ~ data2[data2$Type == 'Graminoid',]$Cover)
a2_graminoid = format(coef(m2_graminoid)[1], digits = 3)
b2_graminoid = format(coef(m2_graminoid)[2], digits = 3)
r2_2_graminoid = format(summary(m2_graminoid)$r.squared, digits = 3)
p_2_graminoid = format(summary(m2_graminoid)$coefficients[,4][2], digits = 3)


g2=ggplot(data2, aes(x=Cover, y=NDVImax, colour=Type))+geom_point(size = 2, alpha=0.3)+  labs(x = "Vegetation Cover (%)", y="NDVImax") + xlim(0, 100)+ylim(0, 1)+geom_smooth(method=lm, se = FALSE)+
  scale_color_manual(values=c('gray50', 'gold2'), breaks=c('Shrub', 'Graminoid'))+
  annotate("text", x = 65, y = 0.95, size=3, color='gray30', label = paste0("NDVImax = ", b2_shrub, " * SC + ", a2_shrub), parse=F)+
  annotate("text", x = 65, y = 0.90, size=3, color='gray30',  label = paste0('list(R^2 ==', as.character(r2_2_shrub),  ', ~p ==', as.character(p_2_shrub), ')'), parse=T)+
  annotate("text", x = 65, y = 0.50, size=3, color='gold3', label = paste0("NDVImax = ", b2_graminoid, " * GC + ", a2_graminoid ), parse=F)+
  annotate("text", x = 65, y = 0.45, size=3, color='gold3',  label = paste0('list(R^2 ==', as.character(r2_2_graminoid), ', ~p ==', as.character(p_2_graminoid), ')'), parse=T)+
  theme_classic()

m3_shrub=lm(data3[data3$Type == 'Shrub',]$NDVImax ~ data3[data3$Type == 'Shrub',]$Cover)
a3_shrub = format(coef(m3_shrub)[1], digits = 3)
b3_shrub = format(coef(m3_shrub)[2], digits = 3)
r2_3_shrub = format(summary(m3_shrub)$r.squared, digits = 3)
p_3_shrub = format(summary(m3_shrub)$coefficients[,4][2], digits  = 3)

m3_graminoid=lm(data3[data3$Type == 'Graminoid',]$NDVImax ~ data3[data3$Type == 'Graminoid',]$Cover)
a3_graminoid = format(coef(m3_graminoid)[1], digits = 3)
b3_graminoid = format(coef(m3_graminoid)[2], digits = 3)
r2_3_graminoid = format(summary(m3_graminoid)$r.squared, digits = 3)
p_3_graminoid = format(summary(m3_graminoid)$coefficients[,4][2], digits = 3)


g3=ggplot(data3, aes(x=Cover, y=NDVImax, colour=Type))+geom_point(size = 2, alpha=0.3)+  labs(x = "Vegetation Cover (%)", y="NDVImax") + xlim(0, 100)+ylim(0, 1)+geom_smooth(method=lm, se = FALSE)+
  scale_color_manual(values=c('gray50', 'gold2'), breaks=c('Shrub', 'Graminoid'))+
  annotate("text", x = 65, y = 0.97, size=3, color='gray30', label = paste0("NDVImax = ", b3_shrub, " * SC + ", a3_shrub), parse=F)+
  annotate("text", x = 65, y = 0.92, size=3, color='gray30',  label = paste0('list(R^2 ==', as.character(r2_3_shrub),  ', ~p ==', as.character(p_3_shrub), ')'), parse=T)+
  annotate("text", x = 65, y = 0.60, size=3, color='gold3', label = paste0("NDVImax = ", b3_graminoid, " * GC + ", a3_graminoid ), parse=F)+
  annotate("text", x = 65, y = 0.55, size=3, color='gold3',  label = paste0('list(R^2 ==', as.character(r2_3_graminoid), ', ~p ==', as.character(p_3_graminoid), ')'), parse=T)+
  theme_classic()

m4_shrub=lm(data4[data4$Type == 'Shrub',]$NDVImax ~ data4[data4$Type == 'Shrub',]$Cover)
a4_shrub = format(coef(m4_shrub)[1], digits = 3)
b4_shrub = format(coef(m4_shrub)[2], digits = 3)
r2_4_shrub = format(summary(m4_shrub)$r.squared, digits = 3)
p_4_shrub = format(summary(m4_shrub)$coefficients[,4][2], digits  = 3)

m4_graminoid=lm(data4[data4$Type == 'Graminoid',]$NDVImax ~ data4[data4$Type == 'Graminoid',]$Cover)
a4_graminoid = format(coef(m4_graminoid)[1], digits = 3)
b4_graminoid = format(coef(m4_graminoid)[2], digits = 3)
r2_4_graminoid = format(summary(m4_graminoid)$r.squared, digits = 3)
p_4_graminoid = format(summary(m4_graminoid)$coefficients[,4][2], digits = 3)


g4=ggplot(data4, aes(x=Cover, y=NDVImax, colour=Type))+geom_point(size = 2, alpha=0.3)+  labs(x = "Vegetation Cover (%)", y="NDVImax") + xlim(0, 100)+ylim(0, 1)+geom_smooth(method=lm, se = FALSE)+
  scale_color_manual(values=c('gray50', 'gold2'), breaks=c('Shrub', 'Graminoid'))+
  annotate("text", x = 50, y = 0.97, size=3, color='gray30', label = paste0("NDVImax = ", b4_shrub, " * SC + ", a4_shrub), parse=F)+
  annotate("text", x = 50, y = 0.92, size=3, color='gray30',  label = paste0('list(R^2 ==', as.character(r2_4_shrub),  ', ~p ==', as.character(p_4_shrub), ')'), parse=T)+
  annotate("text", x = 70, y = 0.5, size=3, color='gold3', label = paste0("NDVImax = ", b4_graminoid, " * GC + ", a4_graminoid ), parse=F)+
  annotate("text", x = 70, y = 0.45, size=3, color='gold3',  label = paste0('list(R^2 ==', as.character(r2_4_graminoid), ', ~p ==', as.character(p_4_graminoid), ')'), parse=T)+
  theme_classic()

ggarrange(NULL, NULL, g1, g2, NULL,  NULL, g3,g4, ncol=2, nrow=4, heights=c(0.05, 1, 0.05, 1), common.legend=T, 
          legend="bottom", labels = c("a) North Slope", "b) Noatak", "",  "", "c) Seward", "d) South West","",   ""), 
          hjust=c(0, 0, -0.5, -0.5, 0, 0, -0.5, -0.5), font.label = list(size = 10, color="black"))


ggsave(file='C:/Users/itscd/Dropbox/Tables/ABoVE_Tundra_Fire/scatterplots_NDVImax_vs_field_vegetation_cover_with_linear_trend_line_and_equation.png', width=8, height=8, dpi=300)
