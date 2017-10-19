STAT545 HW05
================
Xinmiao Wang
2017-10-19

Navigation
==========

-   The main repo for homework: [here](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao)

-   Requirement for Homework 05: click [here](http://stat545.com/hw05_factor-figure-boss-repo-hygiene.html)

-   hw05 folder: [here](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/tree/master/hw05).

-   Files inside hw05:

1.  [README.md](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw05/README.md)
2.  \[hw05\_Gapminder.Rmd\]
3.  \[hw05\_Gapminder.md\]

Induction
=========

In this Homework, we still work on Gapminder dataset, and are going to manage the factors and the figure for this dataset. Before we move to the exploration, we are going to load all the packages we need.

Load Package
============

Here, we load packages that we gonna use later.

``` r
#load packages
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
library(gapminder)
library(devtools)
library(forcats)
library(ggthemes)
```

Factor Management
=================

Drop Oceania
------------

``` r
my_dat <- gapminder %>% 
  filter(continent != "Oceania")


levels(my_dat$continent)
```

    ## [1] "Africa"   "Americas" "Asia"     "Europe"   "Oceania"

``` r
my_dat_dropped <- my_dat %>% 
  droplevels()

levels(my_dat_dropped$continent)
```

    ## [1] "Africa"   "Americas" "Asia"     "Europe"

Reorder the levels of `conitnent`
---------------------------------

``` r
gapminder %>% 
  group_by(continent) %>% 
  summarise(mean_gdpPercap = mean(gdpPercap, na.rm=TRUE)) %>% 
  knitr::kable()
```

| continent |  mean\_gdpPercap|
|:----------|----------------:|
| Africa    |         2193.755|
| Americas  |         7136.110|
| Asia      |         7902.150|
| Europe    |        14469.476|
| Oceania   |        18621.609|

``` r
gapminder$continent %>% 
  fct_reorder(gapminder$gdpPercap, mean, .desc=TRUE) %>% 
  levels()
```

    ## [1] "Oceania"  "Europe"   "Asia"     "Americas" "Africa"

Reorder the levels of `country`
-------------------------------

``` r
# Reorder the levels of country based on the maximum populations of each country 
gapminder$country %>% 
  fct_reorder(gapminder$pop, max) %>% 
  levels() %>% 
  head()
```

    ## [1] "Sao Tome and Principe" "Iceland"               "Djibouti"             
    ## [4] "Equatorial Guinea"     "Bahrain"               "Comoros"

Effects of `arrange()`
----------------------

``` r
interest_country <- c("United States", "Canada", "Mexico")

gapminder %>% 
  filter(country%in%interest_country) %>% 
  mutate(country = fct_reorder(country, lifeExp, max, .desc=TRUE)) %>% 
  knitr::kable()
```

| country       | continent |  year|  lifeExp|        pop|  gdpPercap|
|:--------------|:----------|-----:|--------:|----------:|----------:|
| Canada        | Americas  |  1952|   68.750|   14785584|  11367.161|
| Canada        | Americas  |  1957|   69.960|   17010154|  12489.950|
| Canada        | Americas  |  1962|   71.300|   18985849|  13462.486|
| Canada        | Americas  |  1967|   72.130|   20819767|  16076.588|
| Canada        | Americas  |  1972|   72.880|   22284500|  18970.571|
| Canada        | Americas  |  1977|   74.210|   23796400|  22090.883|
| Canada        | Americas  |  1982|   75.760|   25201900|  22898.792|
| Canada        | Americas  |  1987|   76.860|   26549700|  26626.515|
| Canada        | Americas  |  1992|   77.950|   28523502|  26342.884|
| Canada        | Americas  |  1997|   78.610|   30305843|  28954.926|
| Canada        | Americas  |  2002|   79.770|   31902268|  33328.965|
| Canada        | Americas  |  2007|   80.653|   33390141|  36319.235|
| Mexico        | Americas  |  1952|   50.789|   30144317|   3478.126|
| Mexico        | Americas  |  1957|   55.190|   35015548|   4131.547|
| Mexico        | Americas  |  1962|   58.299|   41121485|   4581.609|
| Mexico        | Americas  |  1967|   60.110|   47995559|   5754.734|
| Mexico        | Americas  |  1972|   62.361|   55984294|   6809.407|
| Mexico        | Americas  |  1977|   65.032|   63759976|   7674.929|
| Mexico        | Americas  |  1982|   67.405|   71640904|   9611.148|
| Mexico        | Americas  |  1987|   69.498|   80122492|   8688.156|
| Mexico        | Americas  |  1992|   71.455|   88111030|   9472.384|
| Mexico        | Americas  |  1997|   73.670|   95895146|   9767.298|
| Mexico        | Americas  |  2002|   74.902|  102479927|  10742.441|
| Mexico        | Americas  |  2007|   76.195|  108700891|  11977.575|
| United States | Americas  |  1952|   68.440|  157553000|  13990.482|
| United States | Americas  |  1957|   69.490|  171984000|  14847.127|
| United States | Americas  |  1962|   70.210|  186538000|  16173.146|
| United States | Americas  |  1967|   70.760|  198712000|  19530.366|
| United States | Americas  |  1972|   71.340|  209896000|  21806.036|
| United States | Americas  |  1977|   73.380|  220239000|  24072.632|
| United States | Americas  |  1982|   74.650|  232187835|  25009.559|
| United States | Americas  |  1987|   75.020|  242803533|  29884.350|
| United States | Americas  |  1992|   76.090|  256894189|  32003.932|
| United States | Americas  |  1997|   76.810|  272911760|  35767.433|
| United States | Americas  |  2002|   77.310|  287675526|  39097.100|
| United States | Americas  |  2007|   78.242|  301139947|  42951.653|

``` r
gapminder %>% 
  filter(country%in%interest_country) %>% 
  group_by(country, year) %>% 
  arrange(country, lifeExp) %>% 
  knitr::kable()
```

| country       | continent |  year|  lifeExp|        pop|  gdpPercap|
|:--------------|:----------|-----:|--------:|----------:|----------:|
| Canada        | Americas  |  1952|   68.750|   14785584|  11367.161|
| Canada        | Americas  |  1957|   69.960|   17010154|  12489.950|
| Canada        | Americas  |  1962|   71.300|   18985849|  13462.486|
| Canada        | Americas  |  1967|   72.130|   20819767|  16076.588|
| Canada        | Americas  |  1972|   72.880|   22284500|  18970.571|
| Canada        | Americas  |  1977|   74.210|   23796400|  22090.883|
| Canada        | Americas  |  1982|   75.760|   25201900|  22898.792|
| Canada        | Americas  |  1987|   76.860|   26549700|  26626.515|
| Canada        | Americas  |  1992|   77.950|   28523502|  26342.884|
| Canada        | Americas  |  1997|   78.610|   30305843|  28954.926|
| Canada        | Americas  |  2002|   79.770|   31902268|  33328.965|
| Canada        | Americas  |  2007|   80.653|   33390141|  36319.235|
| Mexico        | Americas  |  1952|   50.789|   30144317|   3478.126|
| Mexico        | Americas  |  1957|   55.190|   35015548|   4131.547|
| Mexico        | Americas  |  1962|   58.299|   41121485|   4581.609|
| Mexico        | Americas  |  1967|   60.110|   47995559|   5754.734|
| Mexico        | Americas  |  1972|   62.361|   55984294|   6809.407|
| Mexico        | Americas  |  1977|   65.032|   63759976|   7674.929|
| Mexico        | Americas  |  1982|   67.405|   71640904|   9611.148|
| Mexico        | Americas  |  1987|   69.498|   80122492|   8688.156|
| Mexico        | Americas  |  1992|   71.455|   88111030|   9472.384|
| Mexico        | Americas  |  1997|   73.670|   95895146|   9767.298|
| Mexico        | Americas  |  2002|   74.902|  102479927|  10742.441|
| Mexico        | Americas  |  2007|   76.195|  108700891|  11977.575|
| United States | Americas  |  1952|   68.440|  157553000|  13990.482|
| United States | Americas  |  1957|   69.490|  171984000|  14847.127|
| United States | Americas  |  1962|   70.210|  186538000|  16173.146|
| United States | Americas  |  1967|   70.760|  198712000|  19530.366|
| United States | Americas  |  1972|   71.340|  209896000|  21806.036|
| United States | Americas  |  1977|   73.380|  220239000|  24072.632|
| United States | Americas  |  1982|   74.650|  232187835|  25009.559|
| United States | Americas  |  1987|   75.020|  242803533|  29884.350|
| United States | Americas  |  1992|   76.090|  256894189|  32003.932|
| United States | Americas  |  1997|   76.810|  272911760|  35767.433|
| United States | Americas  |  2002|   77.310|  287675526|  39097.100|
| United States | Americas  |  2007|   78.242|  301139947|  42951.653|

``` r
p1 <- gapminder %>%
  filter(country%in%interest_country) %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_line()+
  geom_point()

p2 <- gapminder %>% 
  filter(country%in%interest_country) %>% 
  mutate(country = fct_reorder(country, lifeExp, max, .desc=TRUE)) %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_line()+
  geom_point()

p3 <- gapminder %>% 
  filter(country%in%interest_country) %>% 
  arrange(country, lifeExp) %>% 
  ggplot(aes(x=year, y=lifeExp, color=country))+
  geom_line()+
  geom_point()

multiplot(p1, p2, p3, cols=3)
```

    ## Loading required package: grid

![](hw05_Gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-1.png)

File I/O
========

``` r
gap_re_country <- gapminder %>% 
  mutate(country=fct_reorder(country, pop, max) ) %>% 
  group_by(country) %>% 
  summarise(max_pop = max(pop))


write_csv(gap_re_country, "gap_re_country.csv")

temp <- read_csv("gap_re_country.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   country = col_character(),
    ##   max_pop = col_integer()
    ## )

``` r
temp %>% 
  head() %>% 
  knitr::kable()
```

| country               |  max\_pop|
|:----------------------|---------:|
| Sao Tome and Principe |    199579|
| Iceland               |    301931|
| Djibouti              |    496374|
| Equatorial Guinea     |    551201|
| Bahrain               |    708573|
| Comoros               |    710960|

``` r
str(temp)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    142 obs. of  2 variables:
    ##  $ country: chr  "Sao Tome and Principe" "Iceland" "Djibouti" "Equatorial Guinea" ...
    ##  $ max_pop: int  199579 301931 496374 551201 708573 710960 720230 798094 1133066 1191336 ...
    ##  - attr(*, "spec")=List of 2
    ##   ..$ cols   :List of 2
    ##   .. ..$ country: list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ max_pop: list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   ..$ default: list()
    ##   .. ..- attr(*, "class")= chr  "collector_guess" "collector"
    ##   ..- attr(*, "class")= chr "col_spec"

``` r
saveRDS(gap_re_country, "gap_re_country.rds")

temp2 <- readRDS("gap_re_country.rds")

temp2 %>% 
  head() %>% 
  knitr::kable()
```

| country               |  max\_pop|
|:----------------------|---------:|
| Sao Tome and Principe |    199579|
| Iceland               |    301931|
| Djibouti              |    496374|
| Equatorial Guinea     |    551201|
| Bahrain               |    708573|
| Comoros               |    710960|

``` r
str(temp2)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    142 obs. of  2 variables:
    ##  $ country: Factor w/ 142 levels "Sao Tome and Principe",..: 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ max_pop: int  199579 301931 496374 551201 708573 710960 720230 798094 1133066 1191336 ...

Visualization Design
====================

``` r
gapminder %>%
  ggplot(aes(x=gdpPercap,y=lifeExp))+
  geom_point(aes(colour=year))+
  scale_x_log10()
```

![](hw05_Gapminder_files/figure-markdown_github-ascii_identifiers/visualization_design-1.png)

``` r
gapminder %>%
  ggplot(aes(x=gdpPercap,y=lifeExp))+
  geom_point(aes(colour=pop))+
  scale_x_log10()+
  scale_color_gradient(low="yellow", high="purple")
```

![](hw05_Gapminder_files/figure-markdown_github-ascii_identifiers/visualization_design-2.png)

Writing Figures to File
=======================

``` r
p <- gapminder %>% 
  filter(year==2007, continent!="Oceania") %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp))+
  geom_point(aes(size=pop, fill=country), pch=21, show.legend = F)+
  scale_size_continuous(range = c(1,40))+
  scale_x_log10(limits = c(230, 63000))+
  ylim(c(39, 100))+
  facet_wrap(~continent)+
  scale_fill_manual(values = country_colors)

ggsave("img.png", plot=p)
```

    ## Saving 7 x 5 in image

Display the figure we saved.

![The Plot of Life Expectancy vs GDP per capita in 2007](img.png)

Clean up your repo
==================

Revalue a Factor
================

Report your Process
===================

Reference
=========

-   [Taking control of qualitative colors in ggplot2](http://stat545.com/block019_enforce-color-scheme.html)
