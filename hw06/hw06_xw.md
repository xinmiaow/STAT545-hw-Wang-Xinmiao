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

In this assignment, we practice some function about dealing with strings and lists, and also writing functions.

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
library(singer)
library(repurrrsive)
library(purrr)
library(listviewer)
library(tibble)
```

Character data
==============

14.2.5 Exercises
----------------

#### 1. In code that doesn't use stringr, you'll often see paste() and paste0(). What's the difference between the two functions? What stringr function are they equivalent to? How do the functions differ in their handling of NA?

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

#### 5. What does str\_trim() do? What's the opposite of str\_trim()?

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

    ##   Predicted Value Predicted Error
    ## 1        52.87265        9.385655

``` r
my_pred <- gapminder %>% 
  group_by(country, continent) %>% 
  do(lm_ly(.))

knitr::kable(head(my_pred))
```

| country     | continent |  Predicted Value|  Predicted Error|
|:------------|:----------|----------------:|----------------:|
| Afghanistan | Asia      |         45.56155|        1.7335455|
| Albania     | Europe    |         78.14425|        1.7212545|
| Algeria     | Africa    |         75.68245|        3.3814545|
| Angola      | Africa    |         44.02062|        1.2896182|
| Argentina   | Americas  |         75.47940|        0.1594000|
| Australia   | Oceania   |         80.79582|       -0.4391818|

Working with a list
===================

I choose the lesson, [Simplifying data from a list of GitHub users](https://jennybc.github.io/purrr-tutorial/ls02_map-extraction-advanced.html), for [purrr toturial](https://jennybc.github.io/purrr-tutorial/index.html).

Exercises: Get several GitHub users
-----------------------------------

#### 1. Read the documentation on str(). What does max.level control? Do str(gh\_users, max.level = i) for i in 0,1, and 2.

**max.level**

-   The argument, `max.level`, determine the maximum level of nested structures being displayed.

-   `max.level = 0`: display how many lists are there in the nested list.

-   `max.level = 1`: display not only the number of lists in the nested list, but also the number of variables in each sub-list.

-   `max.level = 2`: display the first two levels of the nested list, and also list the variables in each sub-list. Because the output is too long when we set max.level as 2, I only display the first sub-list, which is similar to the output when max.level is 2.

``` r
str(gh_users, max.level = 0)
```

    ## List of 6

``` r
str(gh_users, max.level = 1)
```

    ## List of 6
    ##  $ :List of 30
    ##  $ :List of 30
    ##  $ :List of 30
    ##  $ :List of 30
    ##  $ :List of 30
    ##  $ :List of 30

``` r
str(gh_users[[1]])
```

    ## List of 30
    ##  $ login              : chr "gaborcsardi"
    ##  $ id                 : int 660288
    ##  $ avatar_url         : chr "https://avatars.githubusercontent.com/u/660288?v=3"
    ##  $ gravatar_id        : chr ""
    ##  $ url                : chr "https://api.github.com/users/gaborcsardi"
    ##  $ html_url           : chr "https://github.com/gaborcsardi"
    ##  $ followers_url      : chr "https://api.github.com/users/gaborcsardi/followers"
    ##  $ following_url      : chr "https://api.github.com/users/gaborcsardi/following{/other_user}"
    ##  $ gists_url          : chr "https://api.github.com/users/gaborcsardi/gists{/gist_id}"
    ##  $ starred_url        : chr "https://api.github.com/users/gaborcsardi/starred{/owner}{/repo}"
    ##  $ subscriptions_url  : chr "https://api.github.com/users/gaborcsardi/subscriptions"
    ##  $ organizations_url  : chr "https://api.github.com/users/gaborcsardi/orgs"
    ##  $ repos_url          : chr "https://api.github.com/users/gaborcsardi/repos"
    ##  $ events_url         : chr "https://api.github.com/users/gaborcsardi/events{/privacy}"
    ##  $ received_events_url: chr "https://api.github.com/users/gaborcsardi/received_events"
    ##  $ type               : chr "User"
    ##  $ site_admin         : logi FALSE
    ##  $ name               : chr "G谩bor Cs谩rdi"
    ##  $ company            : chr "Mango Solutions, @MangoTheCat "
    ##  $ blog               : chr "http://gaborcsardi.org"
    ##  $ location           : chr "Chippenham, UK"
    ##  $ email              : chr "csardi.gabor@gmail.com"
    ##  $ hireable           : NULL
    ##  $ bio                : NULL
    ##  $ public_repos       : int 52
    ##  $ public_gists       : int 6
    ##  $ followers          : int 303
    ##  $ following          : int 22
    ##  $ created_at         : chr "2011-03-09T17:29:25Z"
    ##  $ updated_at         : chr "2016-10-11T11:05:06Z"

#### 2. What does the list.len argument of str() control? What is it's default value? Call str() on gh\_users and then on a single component of gh\_users with list.len set to a value much smaller than the default.

**list.len**

-   The argument, `list.len`, determine the maximum number of list elements to display within a level

-   The default value seems to be the maximum number of list elements.

``` r
str(gh_users[[1]], list.len = 2)
```

    ## List of 30
    ##  $ login              : chr "gaborcsardi"
    ##  $ id                 : int 660288
    ##   [list output truncated]

#### 3. Call str() on gh\_users, specifying both max.level and list.len.

``` r
str(gh_users, max.level = 1, list.len = 3)
```

    ## List of 6
    ##  $ :List of 30
    ##   .. [list output truncated]
    ##  $ :List of 30
    ##   .. [list output truncated]
    ##  $ :List of 30
    ##   .. [list output truncated]
    ##   [list output truncated]

``` r
str(gh_users, max.level = 2, list.len = 3)
```

    ## List of 6
    ##  $ :List of 30
    ##   ..$ login              : chr "gaborcsardi"
    ##   ..$ id                 : int 660288
    ##   ..$ avatar_url         : chr "https://avatars.githubusercontent.com/u/660288?v=3"
    ##   .. [list output truncated]
    ##  $ :List of 30
    ##   ..$ login              : chr "jennybc"
    ##   ..$ id                 : int 599454
    ##   ..$ avatar_url         : chr "https://avatars.githubusercontent.com/u/599454?v=3"
    ##   .. [list output truncated]
    ##  $ :List of 30
    ##   ..$ login              : chr "jtleek"
    ##   ..$ id                 : int 1571674
    ##   ..$ avatar_url         : chr "https://avatars.githubusercontent.com/u/1571674?v=3"
    ##   .. [list output truncated]
    ##   [list output truncated]

#### 4. Recall the list and vector indexing techniques. Inspect elements 1, 2, 6, 18, 21, and 24 of the list component for the 5th GitHub user. One of these should be the URL for the user's profile on GitHub.com. Go there and compare info you see there with the info you just extracted from gh\_users.

``` r
user5 <-gh_users[[5]]

user5[c(1, 2, 6, 18, 21, 24)]
```

    ## $login
    ## [1] "leeper"
    ## 
    ## $id
    ## [1] 3505428
    ## 
    ## $html_url
    ## [1] "https://github.com/leeper"
    ## 
    ## $name
    ## [1] "Thomas J. Leeper"
    ## 
    ## $location
    ## [1] "London, United Kingdom"
    ## 
    ## $bio
    ## [1] "Political scientist and R hacker. Interested in open science, public opinion research, surveys, experiments, crowdsourcing, and cloud computing."

``` r
gh_users[[5]]$html_url
```

    ## [1] "https://github.com/leeper"

#### 5. Consider the interactive view of gh\_users here. Or, optionally, install the listviewer package via install.packages("listviewer") and call jsonedit(gh\_users) to run this widget locally. Can you find the same info you extracted in the previous exercise? The same info you see in user's GitHub.com profile?

I check the list 5 and find the user's in list 5 is different from what I extracted by `gh_users[[5]]`. However, the list 4 is the same as what I extracted in last question.

Because `jsonedit()` is a html format, I did not display the result here.

``` r
jsonedit(gh_users)
```

Exercises: Name and position shortcuts
--------------------------------------

#### 1. Use names() to inspect the names of the list elements associated with a single user. What is the index or position of the created\_at element? Use the character and position shortcuts to extract the created\_at elements for all 6 users.

By using `names()`, I find the position of `created_at` is 29, and then I use `map()` to extract them for the list.

``` r
names(gh_users[[1]])
```

    ##  [1] "login"               "id"                  "avatar_url"         
    ##  [4] "gravatar_id"         "url"                 "html_url"           
    ##  [7] "followers_url"       "following_url"       "gists_url"          
    ## [10] "starred_url"         "subscriptions_url"   "organizations_url"  
    ## [13] "repos_url"           "events_url"          "received_events_url"
    ## [16] "type"                "site_admin"          "name"               
    ## [19] "company"             "blog"                "location"           
    ## [22] "email"               "hireable"            "bio"                
    ## [25] "public_repos"        "public_gists"        "followers"          
    ## [28] "following"           "created_at"          "updated_at"

``` r
map(gh_users, 29)
```

    ## [[1]]
    ## [1] "2011-03-09T17:29:25Z"
    ## 
    ## [[2]]
    ## [1] "2011-02-03T22:37:41Z"
    ## 
    ## [[3]]
    ## [1] "2012-03-24T18:16:43Z"
    ## 
    ## [[4]]
    ## [1] "2015-05-19T02:51:23Z"
    ## 
    ## [[5]]
    ## [1] "2013-02-07T21:07:00Z"
    ## 
    ## [[6]]
    ## [1] "2014-08-05T08:10:04Z"

``` r
map(gh_users, "created_at")
```

    ## [[1]]
    ## [1] "2011-03-09T17:29:25Z"
    ## 
    ## [[2]]
    ## [1] "2011-02-03T22:37:41Z"
    ## 
    ## [[3]]
    ## [1] "2012-03-24T18:16:43Z"
    ## 
    ## [[4]]
    ## [1] "2015-05-19T02:51:23Z"
    ## 
    ## [[5]]
    ## [1] "2013-02-07T21:07:00Z"
    ## 
    ## [[6]]
    ## [1] "2014-08-05T08:10:04Z"

#### 2. What happens if you use the character shortcut with a string that does not appear in the lists' names?

`NULL` will be returned for each user.

``` r
map(gh_users, "Gender")
```

    ## [[1]]
    ## NULL
    ## 
    ## [[2]]
    ## NULL
    ## 
    ## [[3]]
    ## NULL
    ## 
    ## [[4]]
    ## NULL
    ## 
    ## [[5]]
    ## NULL
    ## 
    ## [[6]]
    ## NULL

#### 3. What happens if you use the position shortcut with a number greater than the length of the lists?

The output is the same as what is returned when you use a non-defined character. `NULL` will be returned for each user.

``` r
map(gh_users, 50)
```

    ## [[1]]
    ## NULL
    ## 
    ## [[2]]
    ## NULL
    ## 
    ## [[3]]
    ## NULL
    ## 
    ## [[4]]
    ## NULL
    ## 
    ## [[5]]
    ## NULL
    ## 
    ## [[6]]
    ## NULL

#### 4. What if these shortcuts did not exist? Write a function that takes a list and a string as input and returns the list element that bears the name in the string. Apply this to gh\_users via map(). Do you get the same result as with the shortcut? Reflect on code length and readability.

I create a function, `name_list`. The function takes mylist and mystring (="location") as input, and return the element called location in mylist.

When I apply the function to gh\_users, I get the same result as with the shortcut.

``` r
name_list <- function(mylist, mystring="location"){
  mylist[[mystring]]
}

map(gh_users, name_list)
```

    ## [[1]]
    ## [1] "Chippenham, UK"
    ## 
    ## [[2]]
    ## [1] "Vancouver, BC, Canada"
    ## 
    ## [[3]]
    ## [1] "Baltimore,MD"
    ## 
    ## [[4]]
    ## [1] "Salt Lake City, UT"
    ## 
    ## [[5]]
    ## [1] "London, United Kingdom"
    ## 
    ## [[6]]
    ## [1] "Barcelona, Spain"

#### 5. Write another function that takes a list and an integer as input and returns the list element at that position. Apply this to gh\_users via map(). How does this result and process compare with the shortcut?

I create a function, `int_list`. The function takes mylist and integer (= 21) as input, and return the 21th element in mylist.

When I apply the function to gh\_users, I get the same result as with the shortcut.

``` r
int_list <- function(mylist, myint=21){
  mylist[[myint]]
}

map(gh_users, int_list)
```

    ## [[1]]
    ## [1] "Chippenham, UK"
    ## 
    ## [[2]]
    ## [1] "Vancouver, BC, Canada"
    ## 
    ## [[3]]
    ## [1] "Baltimore,MD"
    ## 
    ## [[4]]
    ## [1] "Salt Lake City, UT"
    ## 
    ## [[5]]
    ## [1] "London, United Kingdom"
    ## 
    ## [[6]]
    ## [1] "Barcelona, Spain"

Exercises: Type-specific map
----------------------------

#### 1. For each user, the second element is named id". This is the user's GitHub id number, where it seems like the person with an id of, say, 10 was the 10th person to sign up for GitHub. At least, it's something like that! Use a type-specific form of map() and an extraction shortcut to extract the ids of these 6 users.

``` r
map_int(gh_users, "id")
```

    ## [1]   660288   599454  1571674 12505835  3505428  8360597

#### 2. Use your list inspection strategies to find the list element that is logical. There is one! Use a type-specific form of map() and an extraction shortcut to extract this for all 6 users.

By `str()`, I find site\_admin is logical.

``` r
str(gh_users[[1]])
```

    ## List of 30
    ##  $ login              : chr "gaborcsardi"
    ##  $ id                 : int 660288
    ##  $ avatar_url         : chr "https://avatars.githubusercontent.com/u/660288?v=3"
    ##  $ gravatar_id        : chr ""
    ##  $ url                : chr "https://api.github.com/users/gaborcsardi"
    ##  $ html_url           : chr "https://github.com/gaborcsardi"
    ##  $ followers_url      : chr "https://api.github.com/users/gaborcsardi/followers"
    ##  $ following_url      : chr "https://api.github.com/users/gaborcsardi/following{/other_user}"
    ##  $ gists_url          : chr "https://api.github.com/users/gaborcsardi/gists{/gist_id}"
    ##  $ starred_url        : chr "https://api.github.com/users/gaborcsardi/starred{/owner}{/repo}"
    ##  $ subscriptions_url  : chr "https://api.github.com/users/gaborcsardi/subscriptions"
    ##  $ organizations_url  : chr "https://api.github.com/users/gaborcsardi/orgs"
    ##  $ repos_url          : chr "https://api.github.com/users/gaborcsardi/repos"
    ##  $ events_url         : chr "https://api.github.com/users/gaborcsardi/events{/privacy}"
    ##  $ received_events_url: chr "https://api.github.com/users/gaborcsardi/received_events"
    ##  $ type               : chr "User"
    ##  $ site_admin         : logi FALSE
    ##  $ name               : chr "G谩bor Cs谩rdi"
    ##  $ company            : chr "Mango Solutions, @MangoTheCat "
    ##  $ blog               : chr "http://gaborcsardi.org"
    ##  $ location           : chr "Chippenham, UK"
    ##  $ email              : chr "csardi.gabor@gmail.com"
    ##  $ hireable           : NULL
    ##  $ bio                : NULL
    ##  $ public_repos       : int 52
    ##  $ public_gists       : int 6
    ##  $ followers          : int 303
    ##  $ following          : int 22
    ##  $ created_at         : chr "2011-03-09T17:29:25Z"
    ##  $ updated_at         : chr "2016-10-11T11:05:06Z"

``` r
map_lgl(gh_users, "site_admin")
```

    ## [1] FALSE FALSE FALSE FALSE FALSE FALSE

#### 3. Use your list inspection strategies to find elements other than id that are numbers. Practice extracting them.

By `str()`, I find that public\_repos, public\_gists, followers, and following are also integer.

``` r
map_int(gh_users, "public_repos")
```

    ## [1]  52 168  67  26  99  31

``` r
map_int(gh_users, "public_gists")
```

    ## [1]  6 54 12  4 46  0

``` r
map_int(gh_users, "followers")
```

    ## [1]  303  780 3958  115  213   34

``` r
map_int(gh_users, "following")
```

    ## [1]  22  34   6  10 230  38

Exercises: Extract multiple values
----------------------------------

#### 1. Use your list inspection skills to determine the position of the elements named "login", "name", "id", and "location". Map \[ or magrittr::extract() over users, requesting these four elements by position instead of name

By `names(gh_users[[1]])` I used before, I find the positions of these four elements are 1, 18, 2, 21.

``` r
map(gh_users, `[`, c(1, 18, 2, 21))
```

    ## [[1]]
    ## [[1]]$login
    ## [1] "gaborcsardi"
    ## 
    ## [[1]]$name
    ## [1] "G谩bor Cs谩rdi"
    ## 
    ## [[1]]$id
    ## [1] 660288
    ## 
    ## [[1]]$location
    ## [1] "Chippenham, UK"
    ## 
    ## 
    ## [[2]]
    ## [[2]]$login
    ## [1] "jennybc"
    ## 
    ## [[2]]$name
    ## [1] "Jennifer (Jenny) Bryan"
    ## 
    ## [[2]]$id
    ## [1] 599454
    ## 
    ## [[2]]$location
    ## [1] "Vancouver, BC, Canada"
    ## 
    ## 
    ## [[3]]
    ## [[3]]$login
    ## [1] "jtleek"
    ## 
    ## [[3]]$name
    ## [1] "Jeff L."
    ## 
    ## [[3]]$id
    ## [1] 1571674
    ## 
    ## [[3]]$location
    ## [1] "Baltimore,MD"
    ## 
    ## 
    ## [[4]]
    ## [[4]]$login
    ## [1] "juliasilge"
    ## 
    ## [[4]]$name
    ## [1] "Julia Silge"
    ## 
    ## [[4]]$id
    ## [1] 12505835
    ## 
    ## [[4]]$location
    ## [1] "Salt Lake City, UT"
    ## 
    ## 
    ## [[5]]
    ## [[5]]$login
    ## [1] "leeper"
    ## 
    ## [[5]]$name
    ## [1] "Thomas J. Leeper"
    ## 
    ## [[5]]$id
    ## [1] 3505428
    ## 
    ## [[5]]$location
    ## [1] "London, United Kingdom"
    ## 
    ## 
    ## [[6]]
    ## [[6]]$login
    ## [1] "masalmon"
    ## 
    ## [[6]]$name
    ## [1] "Ma毛lle Salmon"
    ## 
    ## [[6]]$id
    ## [1] 8360597
    ## 
    ## [[6]]$location
    ## [1] "Barcelona, Spain"

Exercises: Data frame output
----------------------------

NA

``` r
map_df(gh_users, `[`, c("name", "following", "created_at"))
```

    ## # A tibble: 6 x 3
    ##                     name following           created_at
    ##                    <chr>     <int>                <chr>
    ## 1           G谩bor Cs谩rdi        22 2011-03-09T17:29:25Z
    ## 2 Jennifer (Jenny) Bryan        34 2011-02-03T22:37:41Z
    ## 3                Jeff L.         6 2012-03-24T18:16:43Z
    ## 4            Julia Silge        10 2015-05-19T02:51:23Z
    ## 5       Thomas J. Leeper       230 2013-02-07T21:07:00Z
    ## 6          Ma毛lle Salmon        38 2014-08-05T08:10:04Z

Exercises: Repositories for each user
-------------------------------------

Use str(), \[, and \[\[ to explore this list, possibly in addition to the interactive list viewer.

#### 1. How many elements does gh\_repos have? How many elements does each of those elements have?

-   gh\_repos has 6 elements.

-   Five of the elements under gh\_repos have 30 elements for each, and the rest one has 26 elements.

``` r
str(gh_repos, max.level = 1)
```

    ## List of 6
    ##  $ :List of 30
    ##  $ :List of 30
    ##  $ :List of 30
    ##  $ :List of 26
    ##  $ :List of 30
    ##  $ :List of 30

``` r
# jsonedit(gh_repos)
```

#### 2. Extract a list with all the info for one repo for one user. Use str() on it. Maybe print the whole thing to screen. How many elements does this list have and what are their names? Do the same for at least one other repo from a different user and get an rough sense for whether these repo-specific lists tend to look similar.

I choose the second user from the first repo. There are 68 elements in the list. The names of those are listed below by `names()`

In addition, I choose the fifth user from the sixth repo. There are also 68 elements in the list. the names of those are the same as them in the first repo.

``` r
repo1<- gh_repos[[1]]

repo1[[2]]
```

    ## $id
    ## [1] 40500181
    ## 
    ## $name
    ## [1] "argufy"
    ## 
    ## $full_name
    ## [1] "gaborcsardi/argufy"
    ## 
    ## $owner
    ## $owner$login
    ## [1] "gaborcsardi"
    ## 
    ## $owner$id
    ## [1] 660288
    ## 
    ## $owner$avatar_url
    ## [1] "https://avatars.githubusercontent.com/u/660288?v=3"
    ## 
    ## $owner$gravatar_id
    ## [1] ""
    ## 
    ## $owner$url
    ## [1] "https://api.github.com/users/gaborcsardi"
    ## 
    ## $owner$html_url
    ## [1] "https://github.com/gaborcsardi"
    ## 
    ## $owner$followers_url
    ## [1] "https://api.github.com/users/gaborcsardi/followers"
    ## 
    ## $owner$following_url
    ## [1] "https://api.github.com/users/gaborcsardi/following{/other_user}"
    ## 
    ## $owner$gists_url
    ## [1] "https://api.github.com/users/gaborcsardi/gists{/gist_id}"
    ## 
    ## $owner$starred_url
    ## [1] "https://api.github.com/users/gaborcsardi/starred{/owner}{/repo}"
    ## 
    ## $owner$subscriptions_url
    ## [1] "https://api.github.com/users/gaborcsardi/subscriptions"
    ## 
    ## $owner$organizations_url
    ## [1] "https://api.github.com/users/gaborcsardi/orgs"
    ## 
    ## $owner$repos_url
    ## [1] "https://api.github.com/users/gaborcsardi/repos"
    ## 
    ## $owner$events_url
    ## [1] "https://api.github.com/users/gaborcsardi/events{/privacy}"
    ## 
    ## $owner$received_events_url
    ## [1] "https://api.github.com/users/gaborcsardi/received_events"
    ## 
    ## $owner$type
    ## [1] "User"
    ## 
    ## $owner$site_admin
    ## [1] FALSE
    ## 
    ## 
    ## $private
    ## [1] FALSE
    ## 
    ## $html_url
    ## [1] "https://github.com/gaborcsardi/argufy"
    ## 
    ## $description
    ## [1] "Declarative function argument checks"
    ## 
    ## $fork
    ## [1] FALSE
    ## 
    ## $url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy"
    ## 
    ## $forks_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/forks"
    ## 
    ## $keys_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/keys{/key_id}"
    ## 
    ## $collaborators_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/collaborators{/collaborator}"
    ## 
    ## $teams_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/teams"
    ## 
    ## $hooks_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/hooks"
    ## 
    ## $issue_events_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/issues/events{/number}"
    ## 
    ## $events_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/events"
    ## 
    ## $assignees_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/assignees{/user}"
    ## 
    ## $branches_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/branches{/branch}"
    ## 
    ## $tags_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/tags"
    ## 
    ## $blobs_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/git/blobs{/sha}"
    ## 
    ## $git_tags_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/git/tags{/sha}"
    ## 
    ## $git_refs_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/git/refs{/sha}"
    ## 
    ## $trees_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/git/trees{/sha}"
    ## 
    ## $statuses_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/statuses/{sha}"
    ## 
    ## $languages_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/languages"
    ## 
    ## $stargazers_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/stargazers"
    ## 
    ## $contributors_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/contributors"
    ## 
    ## $subscribers_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/subscribers"
    ## 
    ## $subscription_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/subscription"
    ## 
    ## $commits_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/commits{/sha}"
    ## 
    ## $git_commits_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/git/commits{/sha}"
    ## 
    ## $comments_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/comments{/number}"
    ## 
    ## $issue_comment_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/issues/comments{/number}"
    ## 
    ## $contents_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/contents/{+path}"
    ## 
    ## $compare_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/compare/{base}...{head}"
    ## 
    ## $merges_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/merges"
    ## 
    ## $archive_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/{archive_format}{/ref}"
    ## 
    ## $downloads_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/downloads"
    ## 
    ## $issues_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/issues{/number}"
    ## 
    ## $pulls_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/pulls{/number}"
    ## 
    ## $milestones_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/milestones{/number}"
    ## 
    ## $notifications_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/notifications{?since,all,participating}"
    ## 
    ## $labels_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/labels{/name}"
    ## 
    ## $releases_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/releases{/id}"
    ## 
    ## $deployments_url
    ## [1] "https://api.github.com/repos/gaborcsardi/argufy/deployments"
    ## 
    ## $created_at
    ## [1] "2015-08-10T18:56:23Z"
    ## 
    ## $updated_at
    ## [1] "2016-06-30T18:28:08Z"
    ## 
    ## $pushed_at
    ## [1] "2016-03-12T14:59:25Z"
    ## 
    ## $git_url
    ## [1] "git://github.com/gaborcsardi/argufy.git"
    ## 
    ## $ssh_url
    ## [1] "git@github.com:gaborcsardi/argufy.git"
    ## 
    ## $clone_url
    ## [1] "https://github.com/gaborcsardi/argufy.git"
    ## 
    ## $svn_url
    ## [1] "https://github.com/gaborcsardi/argufy"
    ## 
    ## $homepage
    ## NULL
    ## 
    ## $size
    ## [1] 115
    ## 
    ## $stargazers_count
    ## [1] 19
    ## 
    ## $watchers_count
    ## [1] 19
    ## 
    ## $language
    ## [1] "R"
    ## 
    ## $has_issues
    ## [1] TRUE
    ## 
    ## $has_downloads
    ## [1] TRUE
    ## 
    ## $has_wiki
    ## [1] TRUE
    ## 
    ## $has_pages
    ## [1] FALSE
    ## 
    ## $forks_count
    ## [1] 1
    ## 
    ## $mirror_url
    ## NULL
    ## 
    ## $open_issues_count
    ## [1] 6
    ## 
    ## $forks
    ## [1] 1
    ## 
    ## $open_issues
    ## [1] 6
    ## 
    ## $watchers
    ## [1] 19
    ## 
    ## $default_branch
    ## [1] "master"

``` r
str(repo1[[2]], list.len = 3)
```

    ## List of 68
    ##  $ id               : int 40500181
    ##  $ name             : chr "argufy"
    ##  $ full_name        : chr "gaborcsardi/argufy"
    ##   [list output truncated]

``` r
names(repo1[[2]])
```

    ##  [1] "id"                "name"              "full_name"        
    ##  [4] "owner"             "private"           "html_url"         
    ##  [7] "description"       "fork"              "url"              
    ## [10] "forks_url"         "keys_url"          "collaborators_url"
    ## [13] "teams_url"         "hooks_url"         "issue_events_url" 
    ## [16] "events_url"        "assignees_url"     "branches_url"     
    ## [19] "tags_url"          "blobs_url"         "git_tags_url"     
    ## [22] "git_refs_url"      "trees_url"         "statuses_url"     
    ## [25] "languages_url"     "stargazers_url"    "contributors_url" 
    ## [28] "subscribers_url"   "subscription_url"  "commits_url"      
    ## [31] "git_commits_url"   "comments_url"      "issue_comment_url"
    ## [34] "contents_url"      "compare_url"       "merges_url"       
    ## [37] "archive_url"       "downloads_url"     "issues_url"       
    ## [40] "pulls_url"         "milestones_url"    "notifications_url"
    ## [43] "labels_url"        "releases_url"      "deployments_url"  
    ## [46] "created_at"        "updated_at"        "pushed_at"        
    ## [49] "git_url"           "ssh_url"           "clone_url"        
    ## [52] "svn_url"           "homepage"          "size"             
    ## [55] "stargazers_count"  "watchers_count"    "language"         
    ## [58] "has_issues"        "has_downloads"     "has_wiki"         
    ## [61] "has_pages"         "forks_count"       "mirror_url"       
    ## [64] "open_issues_count" "forks"             "open_issues"      
    ## [67] "watchers"          "default_branch"

``` r
repo2 <- gh_repos[[6]]

str(repo2[[5]], list.len = 3)
```

    ## List of 68
    ##  $ id               : int 68307946
    ##  $ name             : chr "cpcb"
    ##  $ full_name        : chr "masalmon/cpcb"
    ##   [list output truncated]

``` r
names(repo2[[5]])
```

    ##  [1] "id"                "name"              "full_name"        
    ##  [4] "owner"             "private"           "html_url"         
    ##  [7] "description"       "fork"              "url"              
    ## [10] "forks_url"         "keys_url"          "collaborators_url"
    ## [13] "teams_url"         "hooks_url"         "issue_events_url" 
    ## [16] "events_url"        "assignees_url"     "branches_url"     
    ## [19] "tags_url"          "blobs_url"         "git_tags_url"     
    ## [22] "git_refs_url"      "trees_url"         "statuses_url"     
    ## [25] "languages_url"     "stargazers_url"    "contributors_url" 
    ## [28] "subscribers_url"   "subscription_url"  "commits_url"      
    ## [31] "git_commits_url"   "comments_url"      "issue_comment_url"
    ## [34] "contents_url"      "compare_url"       "merges_url"       
    ## [37] "archive_url"       "downloads_url"     "issues_url"       
    ## [40] "pulls_url"         "milestones_url"    "notifications_url"
    ## [43] "labels_url"        "releases_url"      "deployments_url"  
    ## [46] "created_at"        "updated_at"        "pushed_at"        
    ## [49] "git_url"           "ssh_url"           "clone_url"        
    ## [52] "svn_url"           "homepage"          "size"             
    ## [55] "stargazers_count"  "watchers_count"    "language"         
    ## [58] "has_issues"        "has_downloads"     "has_wiki"         
    ## [61] "has_pages"         "forks_count"       "mirror_url"       
    ## [64] "open_issues_count" "forks"             "open_issues"      
    ## [67] "watchers"          "default_branch"

#### 3. What are three pieces of repo information that strike you as the most useful? I.e. if you were going to make a data frame of repositories, what might the variables be?

``` r
map_df(gh_repos[[1]], magrittr::extract, c("name", "id","private", "fork", "url"))
```

    ## # A tibble: 30 x 5
    ##           name       id private  fork
    ##          <chr>    <int>   <lgl> <lgl>
    ##  1       after 61160198   FALSE FALSE
    ##  2      argufy 40500181   FALSE FALSE
    ##  3         ask 36442442   FALSE FALSE
    ##  4 baseimports 34924886   FALSE FALSE
    ##  5      citest 61620661   FALSE  TRUE
    ##  6  clisymbols 33907457   FALSE FALSE
    ##  7      cmaker 37236467   FALSE  TRUE
    ##  8       cmark 67959624   FALSE  TRUE
    ##  9  conditions 63152619   FALSE  TRUE
    ## 10      crayon 24343686   FALSE FALSE
    ## # ... with 20 more rows, and 1 more variables: url <chr>

Exercises: Vector input to extraction shortcuts
-----------------------------------------------

#### 1. Each repository carries information about its owner in a list. Use map\_chr() and the position indexing shortcut with vector input to get an atomic character vector of the 6 GitHub usernames for our 6 users: "gaborcsardi", "jennybc", etc. You will need to use your list inspection skills to figure out where this info lives.

``` r
map_chr(gh_repos, c(1, 4, 1))
```

    ## [1] "gaborcsardi" "jennybc"     "jtleek"      "juliasilge"  "leeper"     
    ## [6] "masalmon"

Report Your Process
===================

I select three tasks, including Character data, Writing functions and Work with a list. However, I only complete the last two tasks. I do partial of the first tasks. I would like to practice all six tasks by myself later.

Reference
=========

-   [R for Data Science: Strings](http://r4ds.had.co.nz/strings.html)

-   [Linear regression of life expectancy on year](http://stat545.com/block012_function-regress-lifeexp-on-year.html)

-   [Split-Apply-Combine](http://stat545.com/block024_group-nest-split-map.html)
