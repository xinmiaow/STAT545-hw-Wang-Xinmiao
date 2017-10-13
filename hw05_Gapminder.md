STAT545 HW05
================
Xinmiao Wang
2017-10-12

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
gapminder %>% 
  mutate(continent=fct_reorder(continent, gdpPercap, mean, .desc=TRUE) ) %>% 
  group_by(continent) %>% 
  summarise(mean_gdpPercap = mean(gdpPercap, na.rm=TRUE)) %>% 
  knitr::kable()
```

| continent |  mean\_gdpPercap|
|:----------|----------------:|
| Oceania   |        18621.609|
| Europe    |        14469.476|
| Asia      |         7902.150|
| Americas  |         7136.110|
| Africa    |         2193.755|

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
gap_asia_2007 <- gapminder %>% filter(year == 2007, continent == "Asia")

ggplot(gap_asia_2007, aes(x = pop, y = country)) + geom_point()
```

![](hw05_Gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-1.png)

``` r
gap_asia_2007 %>% 
  ggplot(aes(x = pop, y = fct_reorder(country, pop, max))) +
  geom_point()
```

![](hw05_Gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-2.png)

``` r
gap_asia_2007 %>% 
  arrange(country, desc(pop)) %>% 
  ggplot(aes(x = pop, y =country)) +
  geom_point()
```

![](hw05_Gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-3.png)

``` r
gap_asia_2007 %>% 
  mutate(country = fct_reorder(country, pop, max)) %>% 
  arrange(country, desc(pop)) %>% 
  ggplot(aes(x = pop, y =country)) +
  geom_point()
```

![](hw05_Gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-4.png)

File I/O
========

Visualization Design
====================

Writing Figures to File
=======================

Clean up your repo
==================

Revalue a Factor
================

Report your Process
===================

Reference
=========