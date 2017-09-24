STAT545 HW02
================
Xinmiao Wang
2017-09-24

Bring Rectangular Data in
=========================

In this module, we intend to explore Gapminder data and practice the functions in dplyr, which can be loaded from gapminder package and tidyverse package in R. Please make it sure that those package have been installed before we load them.

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

Smell Test the Data
===================

1.  Is it a data.frame, a matrix, a vector, a list?

``` r
gapminder
```

    ## # A tibble: 1,704 × 6
    ##        country continent  year lifeExp      pop gdpPercap
    ##         <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
    ## 1  Afghanistan      Asia  1952  28.801  8425333  779.4453
    ## 2  Afghanistan      Asia  1957  30.332  9240934  820.8530
    ## 3  Afghanistan      Asia  1962  31.997 10267083  853.1007
    ## 4  Afghanistan      Asia  1967  34.020 11537966  836.1971
    ## 5  Afghanistan      Asia  1972  36.088 13079460  739.9811
    ## 6  Afghanistan      Asia  1977  38.438 14880372  786.1134
    ## 7  Afghanistan      Asia  1982  39.854 12881816  978.0114
    ## 8  Afghanistan      Asia  1987  40.822 13867957  852.3959
    ## 9  Afghanistan      Asia  1992  41.674 16317921  649.3414
    ## 10 Afghanistan      Asia  1997  41.763 22227415  635.3414
    ## # ... with 1,694 more rows

``` r
str(gapminder)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    1704 obs. of  6 variables:
    ##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
    ##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
    ##  $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
    ##  $ gdpPercap: num  779 821 853 836 740 ...

1.  What’s its class?

``` r
class(gapminder)
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

1.  How many variables/columns?

``` r
ncol(gapminder)
```

    ## [1] 6

1.  How many rows/observations?

``` r
nrow(gapminder)
```

    ## [1] 1704

1.  Can you get these facts about “extent” or “size” in more than one way?

``` r
dim(gapminder) # number of observations and number of variables
```

    ## [1] 1704    6

``` r
length(gapminder) # number of variables
```

    ## [1] 6

1.  Can you imagine different functions being useful in different contexts?

2.  What data type is each variable?

``` r
attach(gapminder)
a <- rbind(names(gapminder), c(typeof(country), typeof(continent), typeof(year), typeof(lifeExp), typeof(pop), typeof(gdpPercap)))
as.data.frame(a, row.names=c("Variables", "Type"))
```

    ##                V1        V2      V3      V4      V5        V6
    ## Variables country continent    year lifeExp     pop gdpPercap
    ## Type      integer   integer integer  double integer    double

Explore individual variables
============================

1.  Categorical Variable

2.  quantitative Variable
