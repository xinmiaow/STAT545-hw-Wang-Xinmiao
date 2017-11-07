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
lm_ly <- function(mydat, inyear=2007, offset=1952){
  dat_train <- mydat %>% filter(year!=inyear)
  dat_test <- mydat %>% filter(year==inyear)
  fit <- lm(lifeExp ~ I(year-offset) + I(year-offset)^2, data=dat_train)
  pred_value <- predict(fit, dat_test[, c("year")])
  pred_error <- pred_value - dat_test$lifeExp
  setNames(data.frame(t(c(pred_value, pred_error))), c("Predicted Value", "Predicted Error") )
}

lm_ly(gapminder %>% filter(country == "Zimbabwe"))
```

    ## Warning: package 'bindrcpp' was built under R version 3.3.3

    ##   Predicted Value Predicted Error
    ## 1        52.87265        9.385655

``` r
my_pred <- gapminder %>% 
  group_by(country, continent) %>% 
  do(lm_ly(.))

knitr::kable(my_pred)
```

| country                  | continent |  Predicted Value|  Predicted Error|
|:-------------------------|:----------|----------------:|----------------:|
| Afghanistan              | Asia      |         45.56155|        1.7335455|
| Albania                  | Europe    |         78.14425|        1.7212545|
| Algeria                  | Africa    |         75.68245|        3.3814545|
| Angola                   | Africa    |         44.02062|        1.2896182|
| Argentina                | Americas  |         75.47940|        0.1594000|
| Australia                | Oceania   |         80.79582|       -0.4391818|
| Austria                  | Europe    |         79.72836|       -0.1006364|
| Bahrain                  | Asia      |         79.64438|        4.0093818|
| Bangladesh               | Asia      |         63.31133|       -0.7506727|
| Belgium                  | Europe    |         79.37091|       -0.0700909|
| Benin                    | Africa    |         58.49125|        1.7632545|
| Bolivia                  | Americas  |         66.54491|        0.9909091|
| Bosnia and Herzegovina   | Europe    |         78.36073|        3.5087273|
| Botswana                 | Africa    |         58.58173|        7.8537273|
| Brazil                   | Americas  |         73.20824|        0.8182364|
| Bulgaria                 | Europe    |         74.06182|        1.0568182|
| Burkina Faso             | Africa    |         55.71042|        3.4154182|
| Burundi                  | Africa    |         48.83691|       -0.7430909|
| Cambodia                 | Asia      |         58.39995|       -1.3230545|
| Cameroon                 | Africa    |         56.92178|        6.4917818|
| Canada                   | Americas  |         81.03400|        0.3810000|
| Central African Republic | Africa    |         50.67371|        5.9327091|
| Chad                     | Africa    |         55.02864|        4.3776364|
| Chile                    | Americas  |         81.37678|        2.8237818|
| China                    | Asia      |         77.80948|        4.8484778|
| Colombia                 | Americas  |         74.98704|        2.0980364|
| Comoros                  | Africa    |         64.60671|       -0.5452909|
| Congo, Dem. Rep.         | Africa    |         47.40427|        0.9422727|
| Congo, Rep.              | Africa    |         58.93135|        3.6093455|
| Costa Rica               | Americas  |         82.29360|        3.5116000|
| Cote d'Ivoire            | Africa    |         53.57311|        5.2451091|
| Croatia                  | Europe    |         76.46851|        0.7205091|
| Cuba                     | Americas  |         80.54736|        2.2743636|
| Czech Republic           | Europe    |         75.07764|       -1.4083636|
| Denmark                  | Europe    |         77.44527|       -0.8867273|
| Djibouti                 | Africa    |         57.19247|        2.4014727|
| Dominican Republic       | Americas  |         75.46305|        3.2280545|
| Ecuador                  | Americas  |         77.22664|        2.2326364|
| Egypt                    | Africa    |         71.59327|        0.2552727|
| El Salvador              | Americas  |         73.12135|        1.2433455|
| Equatorial Guinea        | Africa    |         51.45235|       -0.1266545|
| Eritrea                  | Africa    |         55.57695|       -2.4630545|
| Ethiopia                 | Africa    |         52.91345|       -0.0335455|
| Finland                  | Europe    |         79.62764|        0.3146364|
| France                   | Europe    |         81.01255|        0.3555455|
| Gabon                    | Africa    |         66.33702|        9.6020182|
| Gambia                   | Africa    |         60.79924|        1.3512364|
| Germany                  | Europe    |         79.28504|       -0.1209636|
| Ghana                    | Africa    |         61.67644|        1.6544364|
| Greece                   | Europe    |         80.78224|        1.2992364|
| Guatemala                | Americas  |         71.79125|        1.5322545|
| Guinea                   | Africa    |         54.46924|       -1.5377636|
| Guinea-Bissau            | Africa    |         46.80702|        0.4190182|
| Haiti                    | Americas  |         61.15475|        0.2387455|
| Honduras                 | Americas  |         73.95796|        3.7599636|
| Hong Kong, China         | Asia      |         84.12116|        1.9131636|
| Hungary                  | Europe    |         72.56582|       -0.7721818|
| Iceland                  | Europe    |         80.76745|       -0.9895455|
| India                    | Asia      |         68.05116|        3.3531636|
| Indonesia                | Asia      |         72.26444|        1.6144364|
| Iran                     | Asia      |         72.85044|        1.8864364|
| Iraq                     | Asia      |         64.51578|        4.9707818|
| Ireland                  | Europe    |         78.32913|       -0.5558727|
| Israel                   | Asia      |         81.09424|        0.3492364|
| Italy                    | Europe    |         81.80091|        1.2549091|
| Jamaica                  | Americas  |         75.78724|        3.2202364|
| Japan                    | Asia      |         85.33836|        2.7353636|
| Jordan                   | Asia      |         76.75264|        4.2176364|
| Kenya                    | Africa    |         60.13722|        6.0272182|
| Korea, Dem. Rep.         | Asia      |         74.40502|        7.1080182|
| Korea, Rep.              | Asia      |         80.96513|        2.3421273|
| Kuwait                   | Asia      |         81.55513|        3.9671273|
| Lebanon                  | Asia      |         73.48347|        1.4904727|
| Lesotho                  | Africa    |         56.83500|       14.2430000|
| Liberia                  | Africa    |         44.88109|       -0.7969091|
| Libya                    | Africa    |         77.57460|        3.6226000|
| Madagascar               | Africa    |         58.63478|       -0.8082182|
| Malawi                   | Africa    |         50.41580|        2.1128000|
| Malaysia                 | Asia      |         78.23027|        3.9892727|
| Mali                     | Africa    |         53.48671|       -0.9802909|
| Mauritania               | Africa    |         64.75193|        0.5879273|
| Mauritius                | Africa    |         75.26116|        2.4601636|
| Mexico                   | Americas  |         78.48862|        2.2936182|
| Mongolia                 | Asia      |         68.43569|        1.6326909|
| Montenegro               | Europe    |         79.95153|        5.4085273|
| Morocco                  | Africa    |         73.09675|        1.9327455|
| Mozambique               | Africa    |         48.42247|        6.3404727|
| Myanmar                  | Asia      |         66.55440|        4.4854000|
| Namibia                  | Africa    |         62.75149|        9.8454909|
| Nepal                    | Asia      |         63.43900|       -0.3460000|
| Netherlands              | Europe    |         79.25909|       -0.5029091|
| New Zealand              | Oceania   |         78.91073|       -1.2932727|
| Nicaragua                | Americas  |         73.96931|        1.0703091|
| Niger                    | Africa    |         52.75380|       -4.1132000|
| Nigeria                  | Africa    |         50.32524|        3.4662364|
| Norway                   | Europe    |         79.16836|       -1.0276364|
| Oman                     | Asia      |         81.36604|        5.7260364|
| Pakistan                 | Asia      |         66.27511|        0.7921091|
| Panama                   | Americas  |         78.38116|        2.8441636|
| Paraguay                 | Americas  |         70.87887|       -0.8731273|
| Peru                     | Americas  |         74.18649|        2.7654909|
| Philippines              | Asia      |         72.88233|        1.1943273|
| Poland                   | Europe    |         75.57709|        0.0140909|
| Portugal                 | Europe    |         80.35982|        2.2618182|
| Puerto Rico              | Americas  |         78.43987|       -0.3061273|
| Reunion                  | Africa    |         80.48235|        4.0403455|
| Romania                  | Europe    |         72.67909|        0.2030909|
| Rwanda                   | Africa    |         37.70344|       -8.5385636|
| Sao Tome and Principe    | Africa    |         67.99153|        2.4635273|
| Saudi Arabia             | Asia      |         78.11842|        5.3414182|
| Senegal                  | Africa    |         65.10867|        2.0466727|
| Serbia                   | Europe    |         76.22238|        2.2203818|
| Sierra Leone             | Africa    |         42.69156|        0.1235636|
| Singapore                | Asia      |         80.85498|        0.8829818|
| Slovak Republic          | Europe    |         74.26491|       -0.3980909|
| Slovenia                 | Europe    |         76.77607|       -1.1499273|
| Somalia                  | Africa    |         46.94353|       -1.2154727|
| South Africa             | Africa    |         62.53667|       13.1976727|
| Spain                    | Europe    |         82.34218|        1.4011818|
| Sri Lanka                | Asia      |         73.62227|        1.2262727|
| Sudan                    | Africa    |         59.08187|        0.5258727|
| Swaziland                | Africa    |         56.63682|       17.0238182|
| Sweden                   | Europe    |         80.69255|       -0.1914545|
| Switzerland              | Europe    |         81.66618|       -0.0348182|
| Syria                    | Asia      |         77.61478|        3.4717818|
| Taiwan                   | Asia      |         79.72727|        1.3272727|
| Tanzania                 | Africa    |         52.79958|        0.2825818|
| Thailand                 | Asia      |         72.21582|        1.5998182|
| Togo                     | Africa    |         63.52551|        5.1055091|
| Trinidad and Tobago      | Americas  |         72.35002|        2.5310182|
| Tunisia                  | Africa    |         78.12605|        4.2030545|
| Turkey                   | Europe    |         74.03689|        2.2598909|
| Uganda                   | Africa    |         50.72009|       -0.8219091|
| United Kingdom           | Europe    |         78.87424|       -0.5507636|
| United States            | Americas  |         78.66909|        0.4270909|
| Uruguay                  | Americas  |         75.58636|       -0.7976364|
| Venezuela                | Americas  |         76.44298|        2.6959818|
| Vietnam                  | Asia      |         76.65980|        2.4108000|
| West Bank and Gaza       | Asia      |         78.29620|        4.8742000|
| Yemen, Rep.              | Asia      |         63.73689|        1.0388909|
| Zambia                   | Africa    |         45.15036|        2.7663636|
| Zimbabwe                 | Africa    |         52.87265|        9.3856545|
