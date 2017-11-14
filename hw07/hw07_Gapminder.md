hw07\_Gapminder
================
Xinmiao Wang
November 14, 2017

Introduction
============

In this assignment, we practice to automate the data-analysis pipeline. First, we create Write some R scripts to carry out a small data analysis. The output of the first script must be the input of the second, and so on. After doing so, we write a Makefile to pipeline these R scripts together, and get the result of data analysis.

Load Package
============

``` r
library(tidyverse)
```

    ## Warning: package 'tidyverse' was built under R version 3.3.3

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Warning: package 'ggplot2' was built under R version 3.3.3

    ## Warning: package 'tibble' was built under R version 3.3.3

    ## Warning: package 'tidyr' was built under R version 3.3.3

    ## Warning: package 'readr' was built under R version 3.3.3

    ## Warning: package 'purrr' was built under R version 3.3.3

    ## Warning: package 'dplyr' was built under R version 3.3.3

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

Download the data
=================

First, I download the dataset, `gapminder` online, and save as `gapminder.tsv`. Let's read the dataset and have a look at it

``` r
gapminder <- read.delim("gapminder.tsv")

str(gapminder)
```

    ## 'data.frame':    1704 obs. of  6 variables:
    ##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
    ##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
    ##  $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
    ##  $ gdpPercap: num  779 821 853 836 740 ...

Perform exploratory analyses
============================

I an interested in the change of Life Expectancy over time. Hence, here I explore the visualization of continent, lifeExp.

Here is the bar chart of continent. There are six continents where we collected data, including Africa, Americas, Asia, Europe and Oceania.

![The Bar Chart of Continent](barchart.png)

Here is the Histogram of lifeExp.

![The Histogram of LifeExp](histogram.png)

To explore the change of lifeExp over time for each continent, I create the following figure. We can see the increasing trend of LifeExp in each continent.

![The Plot of LifeExp over Years in Each Continent](timeplot_lifeExp.png)

To compare the LifeExp among continent, I plot the mean of LifeExp over years for each continent. We can see the life expectancy of Oceania is always larger than other continents and there is no crossover among each lines

![The Plot of Mean of LifeExp over Years in Each Continent](timeplot_meanLifeExp.png)

Based on the figure above, I am going to reorder the level of continents by the average of lifeExp in each continent.

``` r
gap_re_continent <- readRDS("gap_re_continent.rds")

levels(gap_re_continent$continent)
```

    ## [1] "Africa"   "Asia"     "Americas" "Europe"   "Oceania"

Perform statistical analyses
============================

After reordering continent, I saved it in the first R script and read it in the second R script.

In this section, I want to fit a linear regression model for LifeExp in each country. I create a function, called `lm_ly`, which fits a linear model for lifeExp and year and return the coefficients and residual standard error.

Based on the residual standard error, I choose four countries in continent, whose residual standard error are small, as the four best countries, and four worst countries with lager residual standard error.

Here, I display four best countries in each continent.

``` r
gap_bfit <- read.delim("gap_bfit.tsv")

gap_bfit %>%
  group_by(continent, country) %>% 
  summarise(mean_lifeExp = mean(lifeExp)) %>% 
  knitr::kable()
```

| continent | country                |  mean\_lifeExp|
|:----------|:-----------------------|--------------:|
| Africa    | Equatorial Guinea      |       42.96000|
| Africa    | Ethiopia               |       44.47575|
| Africa    | Gambia                 |       44.40058|
| Africa    | Tunisia                |       60.72100|
| Americas  | Argentina              |       69.06042|
| Americas  | Bolivia                |       52.50458|
| Americas  | Brazil                 |       62.23950|
| Americas  | Haiti                  |       50.16525|
| Asia      | Iran                   |       58.63658|
| Asia      | Korea, Dem. Rep.       |       63.60733|
| Asia      | Nepal                  |       48.98633|
| Asia      | Yemen, Rep.            |       46.78042|
| Europe    | Bosnia and Herzegovina |       67.70783|
| Europe    | Denmark                |       74.37017|
| Europe    | Sweden                 |       76.17700|
| Europe    | Switzerland            |       75.56508|
| Oceania   | Australia              |       74.66292|
| Oceania   | New Zealand            |       73.98950|

Generate figures
================

In this section, I use the dataset created in the second R script, called `gap_bfit.tsv` to generate the scatterplot of lifeExp over year with a linear regression line for four countries in each continent.

I display them in the order of their mean lifeExp, which we used it before to reorder the levels of continent.

![The Scatterplot of LifeExp over Years in Africa](Africa.png)

![The Scatterplot of LifeExp over Years in Asia](Asia.png)

![The Scatterplot of LifeExp over Years in Americas](Americas.png)

![The Scatterplot of LifeExp over Years in Europe](Europe.png)

![The Scatterplot of LifeExp over Years in Oceania](Oceania.png)
