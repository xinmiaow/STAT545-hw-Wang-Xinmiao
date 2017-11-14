# Load package
library(tidyverse)
library(ggthemes)
library(devtools)
library(forcats)

# Read data
gapminder <- readLines("gapminder.tsv")

# Plots
## Bar chart of continent
p1 <- ggplot(gapminder, aes(x=continent))+
  geom_bar(aes(color=continent), fill=continent_colors)+
  theme_calc()+
  ggtitle("The Bar Chart of Continent")

ggsave("barchar.png", plot=p1)

## Histogram of Life Expectancy
p2 <- ggplot(gapminder, aes(x=lifeExp))+
  geom_histogram(binwidth = 1,col="red", aes(fill=..count..))+
  scale_fill_gradient("count", low = "green", high = "red")+
  theme_calc()+
  ggtitle("The Histogram of LifeExp")

ggsave("histogram.png", plot=p2)

## Time Series Plot
p3 <- ggplot(gapminder, aes(x=year, y=lifeExp, color=continent))+
  geom_point()+
  facet_wrap(~continent)+
  theme_calc()+
  ggtitle("The Plot of LifeExp over Years in Each Continent")

ggsave("timeplot_lifeExp.png", plot=p3)

## Plot Of Mean LifeExp
p4 <- gapminder %>% 
  group_by(continent, year) %>% 
  summarise(mean_le=mean(lifeExp)) %>% 
  ggplot(aes(x=year, y=mean_le, color=continent))+
  geom_point()+
  geom_line(aes(group = continent, colour = continent))+
  theme_calc()+
  ggtitle("The Plot of Mean of LifeExp over Years in Each Continent")

ggsave("timeplot_meanLifeExp.png", plot=p4)

# Reorder Contient
gap_re_continent <- gapminder %>% 
  mutate(continent=fct_reorder(continent, lifeExp, mean))

## Save dataset
saveRDS(gap_re_country, "gap_re_continent.rds")
