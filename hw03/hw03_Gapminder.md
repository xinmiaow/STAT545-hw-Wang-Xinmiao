STAT HW03
================
Xinmiao Wang
2017-10-01

Navigation
==========

-   The main repo for homework: [here](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao)

-   Requirement for Homework 03: click [here](http://stat545.com/hw03_dplyr-and-more-ggplot2.html)

-   hw03 folder: [here](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/tree/master/hw03).

-   Files inside hw03:

1.  \[README.md\]
2.  \[hw03\_Gapminder.md\]

Induction
=========

In this module, the main goal is to pracitce dplyr as our manipulation tool with ggplot2 as our visulization tool. We conitnue to explore Gapminder dataset. Those can be loaded from tidyverse package and gapminder package in R. Please make it sure that those package have been installed before we load them.

Load Package
============

Install `gapminder` from CRAN:

``` r
install.packages("gapminder")
```

Install `tidyverse` from CRAN:

``` r
install.packages("tidyverse")
```

Here, we load those two packages.

``` r
#load packages
library(gapminder)
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
library(ggthemes)
```

Get the maximum and minimum of GDP per capita for all continents
================================================================

``` r
gtbl <- tbl_df(gapminder)

tbl1 <- gtbl %>% group_by(continent) %>% summarise_each(funs(mean, median), gdpPercap) 

knitr::kable(tbl1) 
```

| continent |       mean|     median|
|:----------|----------:|----------:|
| Africa    |   2193.755|   1192.138|
| Americas  |   7136.110|   5465.510|
| Asia      |   7902.150|   2646.787|
| Europe    |  14469.476|  12081.749|
| Oceania   |  18621.609|  17983.304|

``` r
ggplot(gtbl, aes(x = continent, y = gdpPercap, color = continent)) +
  geom_point() + ggtitle("GDP per cap by continent") 
```

![](hw03_Gapminder_files/figure-markdown_github-ascii_identifiers/max_min-1.png)

Look at the spread of GDP per capita within the continents.
===========================================================

Compute a trimmed mean of life expectancy for different years. Or a weighted mean, weighting by population.
===========================================================================================================

How is life expectancy changing over time on different continents?
==================================================================

Report the absolute and/or relative abundance of countries with low life expectancy over time by continent: Compute some measure of worldwide life expectancy – you decide – a mean or median or some other quantile or perhaps your current age. Then determine how many countries on each continent have a life expectancy less than this benchmark, for each year.
=====================================================================================================================================================================================================================================================================================================================================================================

Find countries with interesting stories
=======================================
