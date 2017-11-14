# Load package
library(tidyverse)
library(ggthemes)

# Read data
gap_bfit <- read.delim("./hw07/gap.bit.tsv")

# Generate figures
pc1 <- gap_bfit %>% 
  filter(continent=="Africa") %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)+  
  facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Africa")

ggsave("./hw07/Africa.png", plot=pc1)

pc2 <- gap_bfit %>% 
  filter(continent=="Asia") %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)  
facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Asia")

ggsave("./hw07/Aisa.png", plot=pc2)

pc3 <- gap_bfit %>% 
  filter(continent=="Americas") %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)  
facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Americas")

ggsave("./hw07/Americas.png", plot=pc3)

pc4 <- gap_bfit %>% 
  filter(continent=="Europe") %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)  
facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Europe")

ggsave("./hw07/Europe.png", plot=pc4)

pc5 <- gap_bfit %>% 
  filter(continent=="Oceania") %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)  
facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Oceania")

ggsave("./hw07/Oceania.png", plot=pc5)