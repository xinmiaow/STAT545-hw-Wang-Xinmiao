# Load package
library(broom)
library(tidyverse)
library(ggthemes)

# Read dataset
gap_re_continent <- readRDS("gap_re_continent.rds")

# Fit model
## Define a function
## Input: mydat(a dataset), offeset(=1952)
## Output: A data frame(Interpect, Slope, RSD)
lm_ly <- function(mydat, offset=1952){
  fit <- lm(lifeExp ~ I(year-offset), data=mydat)
  beta0 <- coef(fit)[1]
  beta1 <- coef(fit)[2]
  res_SD <- summary(fit)$sigma
  output <- as.data.frame(list("Interpect"=beta0, "Slope"=beta1, "RSD"=res_SD))
  return(output)
}

lm_ly(gap_re_continent %>% filter(country == "Zimbabwe"))

myfits <- gap_re_continent %>% 
  group_by(country, continent) %>% 
  do(lm_ly(.))

# Write a file
write.table(myfits, "lm_fits.tsv",
            sep = "\t", row.names = FALSE, quote = FALSE)

# Select Top 4 countries for Each Continent
myfit_clean <- myfits %>% 
  group_by(continent) %>% 
  mutate(order_RSD = order(RSD)) %>% 
  filter(order_RSD<=4) %>% 
  select(-order_RSD)

# Generate figures
pc1 <- gap_re_continent %>% 
  filter(continent=="Africa", country %in% myfit_clean$country) %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)  
  facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Africa")
  
ggsave("Africa.png", plot=pc1)

pc2 <- gap_re_continent %>% 
  filter(continent=="Asia", country %in% myfit_clean$country) %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)  
  facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Asia")
  
ggsave("Aisa.png", plot=pc2)

pc3 <- gap_re_continent %>% 
  filter(continent=="Americas", country %in% myfit_clean$country) %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)  
  facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Americas")

ggsave("Americas.png", plot=pc3)

pc4 <- gap_re_continent %>% 
  filter(continent=="Europe", country %in% myfit_clean$country) %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)  
  facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Europe")

ggsave("Europe.png", plot=pc4)

pc5 <- gap_re_continent %>% 
  filter(continent=="Oceania", country %in% myfit_clean$country) %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_point(aes(group=country))+
  geom_smooth(method = "lm", se=FALSE)  
  facet_wrap(~country)+
  theme_calc()+
  ggtitle("The Scatterplot of LifeExp over Years in Oceania")

ggsave("Oceania.png", plot=pc5)
