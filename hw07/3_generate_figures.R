# Load package
library(tidyverse)
library(ggthemes)

# Read data
gap_bfit <- read.delim("gap_bfit.tsv")

# Generate figures
pc1 <- gap_bfit %>% 
  filter(continent=="Africa") %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)+  
  facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Africa")

ggsave("Africa.png", plot=pc1)

pc2 <- gap_bfit %>% 
  filter(continent=="Asia") %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)+
  facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Asia")

ggsave("Aisa.png", plot=pc2)

pc3 <- gap_bfit %>% 
  filter(continent=="Americas") %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)  +
  facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Americas")

ggsave("Americas.png", plot=pc3)

pc4 <- gap_bfit %>% 
  filter(continent=="Europe") %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)+
  facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Europe")

ggsave("Europe.png", plot=pc4)

pc5 <- gap_bfit %>% 
  filter(continent=="Oceania") %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)  +
  facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Oceania")

ggsave("Oceania.png", plot=pc5)