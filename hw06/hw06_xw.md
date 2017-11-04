STAT545 HW06
================
Xinmiao Wang
November 4, 2017

Navigation
==========

-   The main repo for homework: [here](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao)

-   Requirement for Homework 05: click [here](http://stat545.com/hw06_data-wrangling-conclusion.html)

-   hw05 folder: [here](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/tree/master/hw06).

-   Files inside hw06:

1.  [README.md](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw06/README.md)
2.  [hw06\_xw.Rmd](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw06/hw06_xw.Rmd)
3.  [hw06\_xw.md](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw06/hw06_xw.md)

Introduction
============

Load package
------------

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

``` r
library(stringr)
```

    ## Warning: package 'stringr' was built under R version 3.3.3

``` r
library(gapminder)
```

    ## Warning: package 'gapminder' was built under R version 3.3.3

Character data
==============

14.2.5 Exercises
----------------

### 1. In code that doesn’t use stringr, you’ll often see paste() and paste0(). What’s the difference between the two functions? What stringr function are they equivalent to? How do the functions differ in their handling of NA?

**ANS:** 1. Differences

-   `paste(...)` separate each inputs with a space automatically; `paste0(...)` can not do that, but it works more efficient when you want to combine inputs as one character.
-   In `paste(...)`, you can control how the inputs are separated by arguement `sep=...`; `paste0(...)` can not do that

1.  Equivalent function in Stringr

-   `paste(...)` has the same result as `str_c(..., sep=" ")`
-   `paste0(...)` has the same result as `str_c(...)`

1.  Handling of `NA`

-   `paste(...)` and `paste0(...)` treat `NA` as a character
-   `str_c(...)` will return `NA` if any input is `NA` inside of this function
-   You can use `str_replace_na()` inside the function `str_c(...)` so that the input `NA` can be treated as a character

``` r
string <- c("This is my", "repo for HW06")

# Combine Multiple inputs
paste(string[1], string[2])
```

    ## [1] "This is my repo for HW06"

``` r
str_c(string[1], string[2],  sep = " ")
```

    ## [1] "This is my repo for HW06"

``` r
paste0(string[1], string[2])
```

    ## [1] "This is myrepo for HW06"

``` r
str_c(string[1], string[2])
```

    ## [1] "This is myrepo for HW06"

``` r
# Combine Multiple elemnts in a vectorized input
paste(string, collapse = " ")
```

    ## [1] "This is my repo for HW06"

``` r
paste0(string, collapse = " ")
```

    ## [1] "This is my repo for HW06"

``` r
str_c(string, collapse = " ")
```

    ## [1] "This is my repo for HW06"

``` r
# with input NA

string2 <- c("This is my", NA, "?")

paste(string2, collapse = " ")
```

    ## [1] "This is my NA ?"

``` r
paste0(string2, collapse = " ")
```

    ## [1] "This is my NA ?"

``` r
str_c(string2, collapse = " ")
```

    ## [1] NA

``` r
str_c(str_replace_na(string2), collapse = " ")
```

    ## [1] "This is my NA ?"

### 2. In your own words, describe the difference between the sep and collapse arguments to str\_c().

``` r
str_c(string, collapse=" ")
```

    ## [1] "This is my repo for HW06"

### 3. Use str\_length() and str\_sub() to extract the middle character from a string. What will you do if the string has an even number of characters?

### 4. What does str\_wrap() do? When might you want to use it?

### 5. What does str\_trim() do? What’s the opposite of str\_trim()?

### 6. Write a function that turns (e.g.) a vector c("a", "b", "c") into the string a, b, and c. Think carefully about what it should do if given a vector of length 0, 1, or 2.

Writing functions
=================
