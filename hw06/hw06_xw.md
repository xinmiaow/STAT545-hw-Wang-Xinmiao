STAT545 HW06
================
Xinmiao Wang
November 4, 2017

Navigation
==========

-   The main repo for homework: [here](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao)

-   Requirement for Homework 06: click [here](http://stat545.com/hw06_data-wrangling-conclusion.html)

-   hw06 folder: [here](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/tree/master/hw06).

-   Files inside hw06:

1.  [README.md](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw06/README.md)
2.  [hw06\_xw.Rmd](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw06/hw06_xw.Rmd)
3.  [hw06\_xw.md](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw06/hw06_xw.md)

Introduction
============

Load package
------------

``` r
suppressPackageStartupMessages(library(dplyr))
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
library(stringr)
library(broom)
library(gapminder)
```

Character data
==============

14.2.5 Exercises
----------------

#### 1. In code that doesn’t use stringr, you’ll often see paste() and paste0(). What’s the difference between the two functions? What stringr function are they equivalent to? How do the functions differ in their handling of NA?

**Differences**

-   `paste(...)` separate each inputs with a space automatically; `paste0(...)` can not do that, but it works more efficient when you want to combine inputs as one character.
-   In `paste(...)`, you can control how the inputs are separated by argument `sep=...`; `paste0(...)` can not do that.
-   For, vectored inputs, `paste(...)` and `paste0(...)` have the same result by using the same argument `collapse = " "` inside each function.

**Equivalent function in Stringr**

-   For multiple non-vectored inputs, `paste(...)` has the same result as `str_c(..., sep=" ")`; `paste0(...)` has the same result as `str_c(...)`
-   For vectored inputs, `paste(...)`, `paste0(...)` and `str_c(...)` have the same result by setting the argument `collapse = " "`.

**Handling of `NA`**

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

#### 2. In your own words, describe the difference between the sep and collapse arguments to str\_c().

**Difference**

-   the argument `sep = ...` is used to combine multiple inputs with length 1

-   the argument `collapse = ...` is used to combine the elements in one vectored input

``` r
str_c(string[1], string[2], sep=" ")
```

    ## [1] "This is my repo for HW06"

``` r
str_c(string, collapse=" ")
```

    ## [1] "This is my repo for HW06"

#### 3. Use str\_length() and str\_sub() to extract the middle character from a string. What will you do if the string has an even number of characters?

-   For a string with odd number of characters, I divide the length of the string by 2 and round it to integer. Then, I return the middle character

-   For a string with even number of characters, I think it make sense if I return the two characters in the middle of the string.

``` r
string3 <- "STAT545"

string4 <- "STAT547M"

l3 <- round(str_length(string3)/2)

l4 <- round(str_length(string4)/2)

str_sub(string3, l3, l3)
```

    ## [1] "T"

``` r
str_sub(string4, l4, l4 + 1)
```

    ## [1] "T5"

#### 4. What does str\_wrap() do? When might you want to use it?

-   `str_wrap()`, in my view, divides the input into several subsets with a specific width which is defined by argument `width = ...`, and then insert the `\n` at the end of each subsets so that each subset will be displayed staring with a line.

-   `str_wrap()` could be used to design the format of a paragraph.

``` r
string5 <- "This is my repo for HW06. I am currently working on Question4 in part I."

str_wrap(string5)
```

    ## [1] "This is my repo for HW06. I am currently working on Question4 in part I."

``` r
str_wrap(string5, width = 20)
```

    ## [1] "This is my repo for\nHW06. I am currently\nworking on Question4\nin part I."

``` r
cat(str_wrap(string5, width = 20), "\n")
```

    ## This is my repo for
    ## HW06. I am currently
    ## working on Question4
    ## in part I.

#### 5. What does str\_trim() do? What’s the opposite of str\_trim()?

-   `str_trim()` will trim white space from the start and end of a string. You can choose the side on which to remove white space by the argument `side = "..."`

-   `str_pad()` will add space or any symbol into a string such that the length of the string equals to the width we defined by argument `width = ...`

``` r
str_trim("\n\  This is my repo for HW06.     ", side = "right")
```

    ## [1] "\n  This is my repo for HW06."

``` r
str_trim("\n\  This is my repo for HW06.     ", side = "left")
```

    ## [1] "This is my repo for HW06.     "

``` r
str_trim("\n\  This is my repo for HW06.     ", side = "both")
```

    ## [1] "This is my repo for HW06."

``` r
str_pad("This is my repo for HW06.", 50, side = "left")
```

    ## [1] "                         This is my repo for HW06."

``` r
str_pad("This is my repo for HW06.", 50, side = "right")
```

    ## [1] "This is my repo for HW06.                         "

``` r
str_pad("This is my repo for HW06.", 50, side = "both", pad=",")
```

    ## [1] ",,,,,,,,,,,,This is my repo for HW06.,,,,,,,,,,,,,"

``` r
str_pad(string, 20, side = "right", pad="?")
```

    ## [1] "This is my??????????" "repo for HW06???????"

#### 6. Write a function that turns (e.g.) a vector c("a", "b", "c") into the string a, b, and c. Think carefully about what it should do if given a vector of length 0, 1, or 2.

In this function, first I check the length of a given vector, and divide this problem into four sub-problems.

If the length of the vector is greater than or equal to 3, then this function will return what the question required.

If the length of the vector is 2, we just collapse the two element in this vector by `and`.

If the length of the vector is 1, we just return it as a string with consideration about NA

If the length of the vector is 0, then an error will be returned.

``` r
str_xw <- function(x){
  l <- length(x)
  if (l >= 3){
    x.sub <- x[1:l-1]
    x.temp <- str_c(str_replace_na(x.sub), collapse = ", ")
    x.new <- str_c(x.temp, ", and ", str_replace_na(x[l]))
  } else if (l == 2){
    x.new <- str_c(str_replace_na(x), collapse = " and ")
  } else if (l == 1){
    x.new <- str_replace_na(x)
  } else {
    stop("I am so sorry, but this function only work for the vetcors with length more than 1")
  }
  return(x.new)
}

my.vec <- c("a", "b", "c")

str_xw(my.vec)
```

    ## [1] "a, b, and c"

``` r
my.vec1 <- c("a", "b")

str_xw(my.vec1)
```

    ## [1] "a and b"

``` r
my.vec2 <- c("A")

str_xw(my.vec2)
```

    ## [1] "A"

Writing functions
=================

``` r
lm_gm <- function(mydat, offset=1952){
  fit <- lm(log(lifeExp) ~ I(year-offset)*gdpPercap, data=mydat)
  coef(fit)
}
```
