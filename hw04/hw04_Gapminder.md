STAT HW04
================
Xinmiao Wang
2017-10-07

Navigation
==========

-   The main repo for homework: [here](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao)

-   Requirement for Homework 04: click [here](http://stat545.com/hw04_tidy-data-joins.html)

-   hw04 folder: [here](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/tree/master/hw04).

-   Files inside hw04:

1.  [README.md](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw04/README.md)
2.  [hw04\_Gapminder.Rmd](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw04/hw04_Gapminder.Rmd)
3.  [hw04\_Gapminder.md](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw04/hw04_Gapminder.md)

Induction
=========

The goal of this homework is to solidify your data wrangling skills by working some realistic problems in the grey area between data aggregation and data reshaping.

In this Homework, we still work on Gapminder dataset, and are going to exploring the dataset by reshaping it. So, We need to load the packages, `gapminder`, `tidyverse` and `devtools`.

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

Install `devtools` from CRAN:

``` r
install.packages("devtools")
```

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
library(ggthemes)
library(countrycode)
library(geonames)
```

    ## No geonamesUsername set. See http://geonames.wordpress.com/2010/03/16/ddos-part-ii/ and set one with options(geonamesUsername="foo") for some services to work

General data reshaping and relationship to aggregation
======================================================

Activity 2
----------

\*Make a tibble with one row per year and columns for life expectancy for two or more countries.

-   Use knitr::kable() to make this table look pretty in your rendered homework.
-   Take advantage of this new data shape to scatterplot life expectancy for one country against that of another.

``` r
gapminder.part <- gapminder %>% 
  filter(continent == "Americas") %>% 
  select(country, lifeExp, year, gdpPercap)

dat1 <- gapminder.part %>% 
  select(country, lifeExp, year) %>% 
  spread(country, lifeExp) %>% 
  as.tbl()

knitr::kable(dat1)
```

|  year|  Argentina|  Bolivia|  Brazil|  Canada|   Chile|  Colombia|  Costa Rica|    Cuba|  Dominican Republic|  Ecuador|  El Salvador|  Guatemala|   Haiti|  Honduras|  Jamaica|  Mexico|  Nicaragua|  Panama|  Paraguay|    Peru|  Puerto Rico|  Trinidad and Tobago|  United States|  Uruguay|  Venezuela|
|-----:|----------:|--------:|-------:|-------:|-------:|---------:|-----------:|-------:|-------------------:|--------:|------------:|----------:|-------:|---------:|--------:|-------:|----------:|-------:|---------:|-------:|------------:|--------------------:|--------------:|--------:|----------:|
|  1952|     62.485|   40.414|  50.917|  68.750|  54.745|    50.643|      57.206|  59.421|              45.928|   48.357|       45.262|     42.023|  37.579|    41.912|   58.530|  50.789|     42.314|  55.191|    62.649|  43.902|       64.280|               59.100|         68.440|   66.071|     55.088|
|  1957|     64.399|   41.890|  53.285|  69.960|  56.074|    55.118|      60.026|  62.325|              49.828|   51.356|       48.570|     44.142|  40.696|    44.665|   62.610|  55.190|     45.432|  59.201|    63.196|  46.263|       68.540|               61.800|         69.490|   67.044|     57.907|
|  1962|     65.142|   43.428|  55.665|  71.300|  57.924|    57.863|      62.842|  65.246|              53.459|   54.640|       52.307|     46.954|  43.590|    48.041|   65.610|  58.299|     48.632|  61.817|    64.361|  49.096|       69.620|               64.900|         70.210|   68.253|     60.770|
|  1967|     65.634|   45.032|  57.632|  72.130|  60.523|    59.963|      65.424|  68.290|              56.751|   56.678|       55.855|     50.016|  46.243|    50.924|   67.510|  60.110|     51.884|  64.071|    64.951|  51.445|       71.100|               65.400|         70.760|   68.468|     63.479|
|  1972|     67.065|   46.714|  59.504|  72.880|  63.441|    61.623|      67.849|  70.723|              59.631|   58.796|       58.207|     53.738|  48.042|    53.884|   69.000|  62.361|     55.151|  66.216|    65.815|  55.448|       72.160|               65.900|         71.340|   68.673|     65.712|
|  1977|     68.481|   50.023|  61.489|  74.210|  67.052|    63.837|      70.750|  72.649|              61.788|   61.310|       56.696|     56.029|  49.923|    57.402|   70.110|  65.032|     57.470|  68.681|    66.353|  58.447|       73.440|               68.300|         73.380|   69.481|     67.456|
|  1982|     69.942|   53.859|  63.336|  75.760|  70.565|    66.653|      73.450|  73.717|              63.727|   64.342|       56.604|     58.137|  51.461|    60.909|   71.210|  67.405|     59.298|  70.472|    66.874|  61.406|       73.750|               68.832|         74.650|   70.805|     68.557|
|  1987|     70.774|   57.251|  65.205|  76.860|  72.492|    67.768|      74.752|  74.174|              66.046|   67.231|       63.154|     60.782|  53.636|    64.492|   71.770|  69.498|     62.008|  71.523|    67.378|  64.134|       74.630|               69.582|         75.020|   71.918|     70.190|
|  1992|     71.868|   59.957|  67.057|  77.950|  74.126|    68.421|      75.713|  74.414|              68.457|   69.613|       66.798|     63.373|  55.089|    66.399|   71.766|  71.455|     65.843|  72.462|    68.225|  66.458|       73.911|               69.862|         76.090|   72.752|     71.150|
|  1997|     73.275|   62.050|  69.388|  78.610|  75.816|    70.313|      77.260|  76.151|              69.957|   72.312|       69.535|     66.322|  56.671|    67.659|   72.262|  73.670|     68.426|  73.738|    69.400|  68.386|       74.917|               69.465|         76.810|   74.223|     72.146|
|  2002|     74.340|   63.883|  71.006|  79.770|  77.860|    71.682|      78.123|  77.158|              70.847|   74.173|       70.734|     68.978|  58.137|    68.565|   72.047|  74.902|     70.836|  74.712|    70.755|  69.906|       77.778|               68.976|         77.310|   75.307|     72.766|
|  2007|     75.320|   65.554|  72.390|  80.653|  78.553|    72.889|      78.782|  78.273|              72.235|   74.994|       71.878|     70.259|  60.916|    70.198|   72.567|  76.195|     72.899|  75.537|    71.752|  71.421|       78.746|               69.819|         78.242|   76.384|     73.747|

``` r
ggplot(dat1, aes(x=Canada, y=get("United States")))+
  geom_point()+
  labs(x="Canada", y="United States")+
  theme_calc()+
  ggtitle("The Plot of Life Expentancy in US verse it in Canada")
```

![](hw04_Gapminder_files/figure-markdown_github-ascii_identifiers/reshaping-1.png)

Join, merge, look up
====================

Activity 1
----------

-   Create a second data frame, complementary to Gapminder. Join this with (part of) Gapminder using a dplyr join function and make some observations about the process and result. Explore the different types of joins. Examples of a second data frame you could build:

-   One row per country, a country variable and one or more variables with extra info, such as language spoken, NATO membership, national animal, or capitol city. If you really want to be helpful, you could attempt to make a pull request to resolve this issue, where I would like to bring ISO country codes into the gapminder package.
-   One row per continent, a continent variable and one or more variables with extra info, such as northern versus southern hemisphere.

I am going to use the data in `countrycode` to creat a new dataset which include the information of countries in North America.

``` r
countryinfo <- GNcountryInfo() %>% 
  tbl_df %>%
  filter(continent=="NA") %>% 
  select(country=countryName, iso=isoAlpha3, capital=capital, lang=languages) %>%
  mutate(country=as.character(country), iso=as.character(iso), capital=as.character(capital), lang=as.character(lang))

knitr::kable(countryinfo)
```

| country                             | iso | capital          | lang               |
|:------------------------------------|:----|:-----------------|:-------------------|
| Antigua and Barbuda                 | ATG | Saint John’s     | en-AG              |
| Anguilla                            | AIA | The Valley       | en-AI              |
| Aruba                               | ABW | Oranjestad       | nl-AW,pap,es,en    |
| Barbados                            | BRB | Bridgetown       | en-BB              |
| Saint-Barthélemy                    | BLM | Gustavia         | fr                 |
| Bermuda                             | BMU | Hamilton         | en-BM,pt           |
| Bonaire, Saint Eustatius and Saba   | BES | Kralendijk       | nl,pap,en          |
| Commonwealth of The Bahamas         | BHS | Nassau           | en-BS              |
| Belize                              | BLZ | Belmopan         | en-BZ,es           |
| Canada                              | CAN | Ottawa           | en-CA,fr-CA,iu     |
| Republic of Costa Rica              | CRI | San José         | es-CR,en           |
| Republic of Cuba                    | CUB | Havana           | es-CU,pap          |
| Country of Cura<U+00E7>ao           | CUW | Willemstad       | nl,pap             |
| Dominica                            | DMA | Roseau           | en-DM              |
| Dominican Republic                  | DOM | Santo Domingo    | es-DO              |
| Grenada                             | GRD | Saint George's   | en-GD              |
| Greenland                           | GRL | Nuuk             | kl,da-GL,en        |
| Guadeloupe                          | GLP | Basse-Terre      | fr-GP              |
| Republic of Guatemala               | GTM | Guatemala City   | es-GT              |
| Republic of Honduras                | HND | Tegucigalpa      | es-HN,cab,miq      |
| Republic of Haiti                   | HTI | Port-au-Prince   | ht,fr-HT           |
| Jamaica                             | JAM | Kingston         | en-JM              |
| Federation of Saint Kitts and Nevis | KNA | Basseterre       | en-KN              |
| Cayman Islands                      | CYM | George Town      | en-KY              |
| Saint Lucia                         | LCA | Castries         | en-LC              |
| Saint-Martin                        | MAF | Marigot          | fr                 |
| Martinique                          | MTQ | Fort-de-France   | fr-MQ              |
| Montserrat                          | MSR | Plymouth         | en-MS              |
| Mexico                              | MEX | Mexico City      | es-MX              |
| Republic of Nicaragua               | NIC | Managua          | es-NI,en           |
| Republic of Panama                  | PAN | Panamá           | es-PA,en           |
| Saint-Pierre et Miquelon            | SPM | Saint-Pierre     | fr-PM              |
| Puerto Rico                         | PRI | San Juan         | en-PR,es-PR        |
| Republic of El Salvador             | SLV | San Salvador     | es-SV              |
| Sint Maarten                        | SXM | Philipsburg      | nl,en              |
| Turks and Caicos Islands            | TCA | Cockburn Town    | en-TC              |
| Republic of Trinidad and Tobago     | TTO | Port-of-Spain    | en-TT,hns,fr,es,zh |
| United States                       | USA | Washington, D.C. | en-US,es-US,haw,fr |
| Saint Vincent and the Grenadines    | VCT | Kingstown        | en-VC,fr           |
| British Virgin Islands              | VGB | Road Town        | en-VG              |
| Virgin Islands of the United States | VIR | Charlotte Amalie | en-VI              |

``` r
gapminder.part %>% 
  left_join(countryinfo, by="country") %>% 
  knitr::kable()
```

    ## Warning in left_join_impl(x, y, by$x, by$y, suffix$x, suffix$y): joining
    ## character vector and factor, coercing into character vector

| country             |  lifeExp|  year|  gdpPercap| iso | capital          | lang               |
|:--------------------|--------:|-----:|----------:|:----|:-----------------|:-------------------|
| Argentina           |   62.485|  1952|   5911.315| NA  | NA               | NA                 |
| Argentina           |   64.399|  1957|   6856.856| NA  | NA               | NA                 |
| Argentina           |   65.142|  1962|   7133.166| NA  | NA               | NA                 |
| Argentina           |   65.634|  1967|   8052.953| NA  | NA               | NA                 |
| Argentina           |   67.065|  1972|   9443.039| NA  | NA               | NA                 |
| Argentina           |   68.481|  1977|  10079.027| NA  | NA               | NA                 |
| Argentina           |   69.942|  1982|   8997.897| NA  | NA               | NA                 |
| Argentina           |   70.774|  1987|   9139.671| NA  | NA               | NA                 |
| Argentina           |   71.868|  1992|   9308.419| NA  | NA               | NA                 |
| Argentina           |   73.275|  1997|  10967.282| NA  | NA               | NA                 |
| Argentina           |   74.340|  2002|   8797.641| NA  | NA               | NA                 |
| Argentina           |   75.320|  2007|  12779.380| NA  | NA               | NA                 |
| Bolivia             |   40.414|  1952|   2677.326| NA  | NA               | NA                 |
| Bolivia             |   41.890|  1957|   2127.686| NA  | NA               | NA                 |
| Bolivia             |   43.428|  1962|   2180.973| NA  | NA               | NA                 |
| Bolivia             |   45.032|  1967|   2586.886| NA  | NA               | NA                 |
| Bolivia             |   46.714|  1972|   2980.331| NA  | NA               | NA                 |
| Bolivia             |   50.023|  1977|   3548.098| NA  | NA               | NA                 |
| Bolivia             |   53.859|  1982|   3156.510| NA  | NA               | NA                 |
| Bolivia             |   57.251|  1987|   2753.691| NA  | NA               | NA                 |
| Bolivia             |   59.957|  1992|   2961.700| NA  | NA               | NA                 |
| Bolivia             |   62.050|  1997|   3326.143| NA  | NA               | NA                 |
| Bolivia             |   63.883|  2002|   3413.263| NA  | NA               | NA                 |
| Bolivia             |   65.554|  2007|   3822.137| NA  | NA               | NA                 |
| Brazil              |   50.917|  1952|   2108.944| NA  | NA               | NA                 |
| Brazil              |   53.285|  1957|   2487.366| NA  | NA               | NA                 |
| Brazil              |   55.665|  1962|   3336.586| NA  | NA               | NA                 |
| Brazil              |   57.632|  1967|   3429.864| NA  | NA               | NA                 |
| Brazil              |   59.504|  1972|   4985.711| NA  | NA               | NA                 |
| Brazil              |   61.489|  1977|   6660.119| NA  | NA               | NA                 |
| Brazil              |   63.336|  1982|   7030.836| NA  | NA               | NA                 |
| Brazil              |   65.205|  1987|   7807.096| NA  | NA               | NA                 |
| Brazil              |   67.057|  1992|   6950.283| NA  | NA               | NA                 |
| Brazil              |   69.388|  1997|   7957.981| NA  | NA               | NA                 |
| Brazil              |   71.006|  2002|   8131.213| NA  | NA               | NA                 |
| Brazil              |   72.390|  2007|   9065.801| NA  | NA               | NA                 |
| Canada              |   68.750|  1952|  11367.161| CAN | Ottawa           | en-CA,fr-CA,iu     |
| Canada              |   69.960|  1957|  12489.950| CAN | Ottawa           | en-CA,fr-CA,iu     |
| Canada              |   71.300|  1962|  13462.486| CAN | Ottawa           | en-CA,fr-CA,iu     |
| Canada              |   72.130|  1967|  16076.588| CAN | Ottawa           | en-CA,fr-CA,iu     |
| Canada              |   72.880|  1972|  18970.571| CAN | Ottawa           | en-CA,fr-CA,iu     |
| Canada              |   74.210|  1977|  22090.883| CAN | Ottawa           | en-CA,fr-CA,iu     |
| Canada              |   75.760|  1982|  22898.792| CAN | Ottawa           | en-CA,fr-CA,iu     |
| Canada              |   76.860|  1987|  26626.515| CAN | Ottawa           | en-CA,fr-CA,iu     |
| Canada              |   77.950|  1992|  26342.884| CAN | Ottawa           | en-CA,fr-CA,iu     |
| Canada              |   78.610|  1997|  28954.926| CAN | Ottawa           | en-CA,fr-CA,iu     |
| Canada              |   79.770|  2002|  33328.965| CAN | Ottawa           | en-CA,fr-CA,iu     |
| Canada              |   80.653|  2007|  36319.235| CAN | Ottawa           | en-CA,fr-CA,iu     |
| Chile               |   54.745|  1952|   3939.979| NA  | NA               | NA                 |
| Chile               |   56.074|  1957|   4315.623| NA  | NA               | NA                 |
| Chile               |   57.924|  1962|   4519.094| NA  | NA               | NA                 |
| Chile               |   60.523|  1967|   5106.654| NA  | NA               | NA                 |
| Chile               |   63.441|  1972|   5494.024| NA  | NA               | NA                 |
| Chile               |   67.052|  1977|   4756.764| NA  | NA               | NA                 |
| Chile               |   70.565|  1982|   5095.666| NA  | NA               | NA                 |
| Chile               |   72.492|  1987|   5547.064| NA  | NA               | NA                 |
| Chile               |   74.126|  1992|   7596.126| NA  | NA               | NA                 |
| Chile               |   75.816|  1997|  10118.053| NA  | NA               | NA                 |
| Chile               |   77.860|  2002|  10778.784| NA  | NA               | NA                 |
| Chile               |   78.553|  2007|  13171.639| NA  | NA               | NA                 |
| Colombia            |   50.643|  1952|   2144.115| NA  | NA               | NA                 |
| Colombia            |   55.118|  1957|   2323.806| NA  | NA               | NA                 |
| Colombia            |   57.863|  1962|   2492.351| NA  | NA               | NA                 |
| Colombia            |   59.963|  1967|   2678.730| NA  | NA               | NA                 |
| Colombia            |   61.623|  1972|   3264.660| NA  | NA               | NA                 |
| Colombia            |   63.837|  1977|   3815.808| NA  | NA               | NA                 |
| Colombia            |   66.653|  1982|   4397.576| NA  | NA               | NA                 |
| Colombia            |   67.768|  1987|   4903.219| NA  | NA               | NA                 |
| Colombia            |   68.421|  1992|   5444.649| NA  | NA               | NA                 |
| Colombia            |   70.313|  1997|   6117.362| NA  | NA               | NA                 |
| Colombia            |   71.682|  2002|   5755.260| NA  | NA               | NA                 |
| Colombia            |   72.889|  2007|   7006.580| NA  | NA               | NA                 |
| Costa Rica          |   57.206|  1952|   2627.009| NA  | NA               | NA                 |
| Costa Rica          |   60.026|  1957|   2990.011| NA  | NA               | NA                 |
| Costa Rica          |   62.842|  1962|   3460.937| NA  | NA               | NA                 |
| Costa Rica          |   65.424|  1967|   4161.728| NA  | NA               | NA                 |
| Costa Rica          |   67.849|  1972|   5118.147| NA  | NA               | NA                 |
| Costa Rica          |   70.750|  1977|   5926.877| NA  | NA               | NA                 |
| Costa Rica          |   73.450|  1982|   5262.735| NA  | NA               | NA                 |
| Costa Rica          |   74.752|  1987|   5629.915| NA  | NA               | NA                 |
| Costa Rica          |   75.713|  1992|   6160.416| NA  | NA               | NA                 |
| Costa Rica          |   77.260|  1997|   6677.045| NA  | NA               | NA                 |
| Costa Rica          |   78.123|  2002|   7723.447| NA  | NA               | NA                 |
| Costa Rica          |   78.782|  2007|   9645.061| NA  | NA               | NA                 |
| Cuba                |   59.421|  1952|   5586.539| NA  | NA               | NA                 |
| Cuba                |   62.325|  1957|   6092.174| NA  | NA               | NA                 |
| Cuba                |   65.246|  1962|   5180.756| NA  | NA               | NA                 |
| Cuba                |   68.290|  1967|   5690.268| NA  | NA               | NA                 |
| Cuba                |   70.723|  1972|   5305.445| NA  | NA               | NA                 |
| Cuba                |   72.649|  1977|   6380.495| NA  | NA               | NA                 |
| Cuba                |   73.717|  1982|   7316.918| NA  | NA               | NA                 |
| Cuba                |   74.174|  1987|   7532.925| NA  | NA               | NA                 |
| Cuba                |   74.414|  1992|   5592.844| NA  | NA               | NA                 |
| Cuba                |   76.151|  1997|   5431.990| NA  | NA               | NA                 |
| Cuba                |   77.158|  2002|   6340.647| NA  | NA               | NA                 |
| Cuba                |   78.273|  2007|   8948.103| NA  | NA               | NA                 |
| Dominican Republic  |   45.928|  1952|   1397.717| DOM | Santo Domingo    | es-DO              |
| Dominican Republic  |   49.828|  1957|   1544.403| DOM | Santo Domingo    | es-DO              |
| Dominican Republic  |   53.459|  1962|   1662.137| DOM | Santo Domingo    | es-DO              |
| Dominican Republic  |   56.751|  1967|   1653.723| DOM | Santo Domingo    | es-DO              |
| Dominican Republic  |   59.631|  1972|   2189.874| DOM | Santo Domingo    | es-DO              |
| Dominican Republic  |   61.788|  1977|   2681.989| DOM | Santo Domingo    | es-DO              |
| Dominican Republic  |   63.727|  1982|   2861.092| DOM | Santo Domingo    | es-DO              |
| Dominican Republic  |   66.046|  1987|   2899.842| DOM | Santo Domingo    | es-DO              |
| Dominican Republic  |   68.457|  1992|   3044.214| DOM | Santo Domingo    | es-DO              |
| Dominican Republic  |   69.957|  1997|   3614.101| DOM | Santo Domingo    | es-DO              |
| Dominican Republic  |   70.847|  2002|   4563.808| DOM | Santo Domingo    | es-DO              |
| Dominican Republic  |   72.235|  2007|   6025.375| DOM | Santo Domingo    | es-DO              |
| Ecuador             |   48.357|  1952|   3522.111| NA  | NA               | NA                 |
| Ecuador             |   51.356|  1957|   3780.547| NA  | NA               | NA                 |
| Ecuador             |   54.640|  1962|   4086.114| NA  | NA               | NA                 |
| Ecuador             |   56.678|  1967|   4579.074| NA  | NA               | NA                 |
| Ecuador             |   58.796|  1972|   5280.995| NA  | NA               | NA                 |
| Ecuador             |   61.310|  1977|   6679.623| NA  | NA               | NA                 |
| Ecuador             |   64.342|  1982|   7213.791| NA  | NA               | NA                 |
| Ecuador             |   67.231|  1987|   6481.777| NA  | NA               | NA                 |
| Ecuador             |   69.613|  1992|   7103.703| NA  | NA               | NA                 |
| Ecuador             |   72.312|  1997|   7429.456| NA  | NA               | NA                 |
| Ecuador             |   74.173|  2002|   5773.045| NA  | NA               | NA                 |
| Ecuador             |   74.994|  2007|   6873.262| NA  | NA               | NA                 |
| El Salvador         |   45.262|  1952|   3048.303| NA  | NA               | NA                 |
| El Salvador         |   48.570|  1957|   3421.523| NA  | NA               | NA                 |
| El Salvador         |   52.307|  1962|   3776.804| NA  | NA               | NA                 |
| El Salvador         |   55.855|  1967|   4358.595| NA  | NA               | NA                 |
| El Salvador         |   58.207|  1972|   4520.246| NA  | NA               | NA                 |
| El Salvador         |   56.696|  1977|   5138.922| NA  | NA               | NA                 |
| El Salvador         |   56.604|  1982|   4098.344| NA  | NA               | NA                 |
| El Salvador         |   63.154|  1987|   4140.442| NA  | NA               | NA                 |
| El Salvador         |   66.798|  1992|   4444.232| NA  | NA               | NA                 |
| El Salvador         |   69.535|  1997|   5154.825| NA  | NA               | NA                 |
| El Salvador         |   70.734|  2002|   5351.569| NA  | NA               | NA                 |
| El Salvador         |   71.878|  2007|   5728.354| NA  | NA               | NA                 |
| Guatemala           |   42.023|  1952|   2428.238| NA  | NA               | NA                 |
| Guatemala           |   44.142|  1957|   2617.156| NA  | NA               | NA                 |
| Guatemala           |   46.954|  1962|   2750.364| NA  | NA               | NA                 |
| Guatemala           |   50.016|  1967|   3242.531| NA  | NA               | NA                 |
| Guatemala           |   53.738|  1972|   4031.408| NA  | NA               | NA                 |
| Guatemala           |   56.029|  1977|   4879.993| NA  | NA               | NA                 |
| Guatemala           |   58.137|  1982|   4820.495| NA  | NA               | NA                 |
| Guatemala           |   60.782|  1987|   4246.486| NA  | NA               | NA                 |
| Guatemala           |   63.373|  1992|   4439.451| NA  | NA               | NA                 |
| Guatemala           |   66.322|  1997|   4684.314| NA  | NA               | NA                 |
| Guatemala           |   68.978|  2002|   4858.347| NA  | NA               | NA                 |
| Guatemala           |   70.259|  2007|   5186.050| NA  | NA               | NA                 |
| Haiti               |   37.579|  1952|   1840.367| NA  | NA               | NA                 |
| Haiti               |   40.696|  1957|   1726.888| NA  | NA               | NA                 |
| Haiti               |   43.590|  1962|   1796.589| NA  | NA               | NA                 |
| Haiti               |   46.243|  1967|   1452.058| NA  | NA               | NA                 |
| Haiti               |   48.042|  1972|   1654.457| NA  | NA               | NA                 |
| Haiti               |   49.923|  1977|   1874.299| NA  | NA               | NA                 |
| Haiti               |   51.461|  1982|   2011.160| NA  | NA               | NA                 |
| Haiti               |   53.636|  1987|   1823.016| NA  | NA               | NA                 |
| Haiti               |   55.089|  1992|   1456.310| NA  | NA               | NA                 |
| Haiti               |   56.671|  1997|   1341.727| NA  | NA               | NA                 |
| Haiti               |   58.137|  2002|   1270.365| NA  | NA               | NA                 |
| Haiti               |   60.916|  2007|   1201.637| NA  | NA               | NA                 |
| Honduras            |   41.912|  1952|   2194.926| NA  | NA               | NA                 |
| Honduras            |   44.665|  1957|   2220.488| NA  | NA               | NA                 |
| Honduras            |   48.041|  1962|   2291.157| NA  | NA               | NA                 |
| Honduras            |   50.924|  1967|   2538.269| NA  | NA               | NA                 |
| Honduras            |   53.884|  1972|   2529.842| NA  | NA               | NA                 |
| Honduras            |   57.402|  1977|   3203.208| NA  | NA               | NA                 |
| Honduras            |   60.909|  1982|   3121.761| NA  | NA               | NA                 |
| Honduras            |   64.492|  1987|   3023.097| NA  | NA               | NA                 |
| Honduras            |   66.399|  1992|   3081.695| NA  | NA               | NA                 |
| Honduras            |   67.659|  1997|   3160.455| NA  | NA               | NA                 |
| Honduras            |   68.565|  2002|   3099.729| NA  | NA               | NA                 |
| Honduras            |   70.198|  2007|   3548.331| NA  | NA               | NA                 |
| Jamaica             |   58.530|  1952|   2898.531| JAM | Kingston         | en-JM              |
| Jamaica             |   62.610|  1957|   4756.526| JAM | Kingston         | en-JM              |
| Jamaica             |   65.610|  1962|   5246.108| JAM | Kingston         | en-JM              |
| Jamaica             |   67.510|  1967|   6124.703| JAM | Kingston         | en-JM              |
| Jamaica             |   69.000|  1972|   7433.889| JAM | Kingston         | en-JM              |
| Jamaica             |   70.110|  1977|   6650.196| JAM | Kingston         | en-JM              |
| Jamaica             |   71.210|  1982|   6068.051| JAM | Kingston         | en-JM              |
| Jamaica             |   71.770|  1987|   6351.237| JAM | Kingston         | en-JM              |
| Jamaica             |   71.766|  1992|   7404.924| JAM | Kingston         | en-JM              |
| Jamaica             |   72.262|  1997|   7121.925| JAM | Kingston         | en-JM              |
| Jamaica             |   72.047|  2002|   6994.775| JAM | Kingston         | en-JM              |
| Jamaica             |   72.567|  2007|   7320.880| JAM | Kingston         | en-JM              |
| Mexico              |   50.789|  1952|   3478.126| MEX | Mexico City      | es-MX              |
| Mexico              |   55.190|  1957|   4131.547| MEX | Mexico City      | es-MX              |
| Mexico              |   58.299|  1962|   4581.609| MEX | Mexico City      | es-MX              |
| Mexico              |   60.110|  1967|   5754.734| MEX | Mexico City      | es-MX              |
| Mexico              |   62.361|  1972|   6809.407| MEX | Mexico City      | es-MX              |
| Mexico              |   65.032|  1977|   7674.929| MEX | Mexico City      | es-MX              |
| Mexico              |   67.405|  1982|   9611.148| MEX | Mexico City      | es-MX              |
| Mexico              |   69.498|  1987|   8688.156| MEX | Mexico City      | es-MX              |
| Mexico              |   71.455|  1992|   9472.384| MEX | Mexico City      | es-MX              |
| Mexico              |   73.670|  1997|   9767.298| MEX | Mexico City      | es-MX              |
| Mexico              |   74.902|  2002|  10742.441| MEX | Mexico City      | es-MX              |
| Mexico              |   76.195|  2007|  11977.575| MEX | Mexico City      | es-MX              |
| Nicaragua           |   42.314|  1952|   3112.364| NA  | NA               | NA                 |
| Nicaragua           |   45.432|  1957|   3457.416| NA  | NA               | NA                 |
| Nicaragua           |   48.632|  1962|   3634.364| NA  | NA               | NA                 |
| Nicaragua           |   51.884|  1967|   4643.394| NA  | NA               | NA                 |
| Nicaragua           |   55.151|  1972|   4688.593| NA  | NA               | NA                 |
| Nicaragua           |   57.470|  1977|   5486.371| NA  | NA               | NA                 |
| Nicaragua           |   59.298|  1982|   3470.338| NA  | NA               | NA                 |
| Nicaragua           |   62.008|  1987|   2955.984| NA  | NA               | NA                 |
| Nicaragua           |   65.843|  1992|   2170.152| NA  | NA               | NA                 |
| Nicaragua           |   68.426|  1997|   2253.023| NA  | NA               | NA                 |
| Nicaragua           |   70.836|  2002|   2474.549| NA  | NA               | NA                 |
| Nicaragua           |   72.899|  2007|   2749.321| NA  | NA               | NA                 |
| Panama              |   55.191|  1952|   2480.380| NA  | NA               | NA                 |
| Panama              |   59.201|  1957|   2961.801| NA  | NA               | NA                 |
| Panama              |   61.817|  1962|   3536.540| NA  | NA               | NA                 |
| Panama              |   64.071|  1967|   4421.009| NA  | NA               | NA                 |
| Panama              |   66.216|  1972|   5364.250| NA  | NA               | NA                 |
| Panama              |   68.681|  1977|   5351.912| NA  | NA               | NA                 |
| Panama              |   70.472|  1982|   7009.602| NA  | NA               | NA                 |
| Panama              |   71.523|  1987|   7034.779| NA  | NA               | NA                 |
| Panama              |   72.462|  1992|   6618.743| NA  | NA               | NA                 |
| Panama              |   73.738|  1997|   7113.692| NA  | NA               | NA                 |
| Panama              |   74.712|  2002|   7356.032| NA  | NA               | NA                 |
| Panama              |   75.537|  2007|   9809.186| NA  | NA               | NA                 |
| Paraguay            |   62.649|  1952|   1952.309| NA  | NA               | NA                 |
| Paraguay            |   63.196|  1957|   2046.155| NA  | NA               | NA                 |
| Paraguay            |   64.361|  1962|   2148.027| NA  | NA               | NA                 |
| Paraguay            |   64.951|  1967|   2299.376| NA  | NA               | NA                 |
| Paraguay            |   65.815|  1972|   2523.338| NA  | NA               | NA                 |
| Paraguay            |   66.353|  1977|   3248.373| NA  | NA               | NA                 |
| Paraguay            |   66.874|  1982|   4258.504| NA  | NA               | NA                 |
| Paraguay            |   67.378|  1987|   3998.876| NA  | NA               | NA                 |
| Paraguay            |   68.225|  1992|   4196.411| NA  | NA               | NA                 |
| Paraguay            |   69.400|  1997|   4247.400| NA  | NA               | NA                 |
| Paraguay            |   70.755|  2002|   3783.674| NA  | NA               | NA                 |
| Paraguay            |   71.752|  2007|   4172.838| NA  | NA               | NA                 |
| Peru                |   43.902|  1952|   3758.523| NA  | NA               | NA                 |
| Peru                |   46.263|  1957|   4245.257| NA  | NA               | NA                 |
| Peru                |   49.096|  1962|   4957.038| NA  | NA               | NA                 |
| Peru                |   51.445|  1967|   5788.093| NA  | NA               | NA                 |
| Peru                |   55.448|  1972|   5937.827| NA  | NA               | NA                 |
| Peru                |   58.447|  1977|   6281.291| NA  | NA               | NA                 |
| Peru                |   61.406|  1982|   6434.502| NA  | NA               | NA                 |
| Peru                |   64.134|  1987|   6360.943| NA  | NA               | NA                 |
| Peru                |   66.458|  1992|   4446.381| NA  | NA               | NA                 |
| Peru                |   68.386|  1997|   5838.348| NA  | NA               | NA                 |
| Peru                |   69.906|  2002|   5909.020| NA  | NA               | NA                 |
| Peru                |   71.421|  2007|   7408.906| NA  | NA               | NA                 |
| Puerto Rico         |   64.280|  1952|   3081.960| PRI | San Juan         | en-PR,es-PR        |
| Puerto Rico         |   68.540|  1957|   3907.156| PRI | San Juan         | en-PR,es-PR        |
| Puerto Rico         |   69.620|  1962|   5108.345| PRI | San Juan         | en-PR,es-PR        |
| Puerto Rico         |   71.100|  1967|   6929.278| PRI | San Juan         | en-PR,es-PR        |
| Puerto Rico         |   72.160|  1972|   9123.042| PRI | San Juan         | en-PR,es-PR        |
| Puerto Rico         |   73.440|  1977|   9770.525| PRI | San Juan         | en-PR,es-PR        |
| Puerto Rico         |   73.750|  1982|  10330.989| PRI | San Juan         | en-PR,es-PR        |
| Puerto Rico         |   74.630|  1987|  12281.342| PRI | San Juan         | en-PR,es-PR        |
| Puerto Rico         |   73.911|  1992|  14641.587| PRI | San Juan         | en-PR,es-PR        |
| Puerto Rico         |   74.917|  1997|  16999.433| PRI | San Juan         | en-PR,es-PR        |
| Puerto Rico         |   77.778|  2002|  18855.606| PRI | San Juan         | en-PR,es-PR        |
| Puerto Rico         |   78.746|  2007|  19328.709| PRI | San Juan         | en-PR,es-PR        |
| Trinidad and Tobago |   59.100|  1952|   3023.272| NA  | NA               | NA                 |
| Trinidad and Tobago |   61.800|  1957|   4100.393| NA  | NA               | NA                 |
| Trinidad and Tobago |   64.900|  1962|   4997.524| NA  | NA               | NA                 |
| Trinidad and Tobago |   65.400|  1967|   5621.368| NA  | NA               | NA                 |
| Trinidad and Tobago |   65.900|  1972|   6619.551| NA  | NA               | NA                 |
| Trinidad and Tobago |   68.300|  1977|   7899.554| NA  | NA               | NA                 |
| Trinidad and Tobago |   68.832|  1982|   9119.529| NA  | NA               | NA                 |
| Trinidad and Tobago |   69.582|  1987|   7388.598| NA  | NA               | NA                 |
| Trinidad and Tobago |   69.862|  1992|   7370.991| NA  | NA               | NA                 |
| Trinidad and Tobago |   69.465|  1997|   8792.573| NA  | NA               | NA                 |
| Trinidad and Tobago |   68.976|  2002|  11460.600| NA  | NA               | NA                 |
| Trinidad and Tobago |   69.819|  2007|  18008.509| NA  | NA               | NA                 |
| United States       |   68.440|  1952|  13990.482| USA | Washington, D.C. | en-US,es-US,haw,fr |
| United States       |   69.490|  1957|  14847.127| USA | Washington, D.C. | en-US,es-US,haw,fr |
| United States       |   70.210|  1962|  16173.146| USA | Washington, D.C. | en-US,es-US,haw,fr |
| United States       |   70.760|  1967|  19530.366| USA | Washington, D.C. | en-US,es-US,haw,fr |
| United States       |   71.340|  1972|  21806.036| USA | Washington, D.C. | en-US,es-US,haw,fr |
| United States       |   73.380|  1977|  24072.632| USA | Washington, D.C. | en-US,es-US,haw,fr |
| United States       |   74.650|  1982|  25009.559| USA | Washington, D.C. | en-US,es-US,haw,fr |
| United States       |   75.020|  1987|  29884.350| USA | Washington, D.C. | en-US,es-US,haw,fr |
| United States       |   76.090|  1992|  32003.932| USA | Washington, D.C. | en-US,es-US,haw,fr |
| United States       |   76.810|  1997|  35767.433| USA | Washington, D.C. | en-US,es-US,haw,fr |
| United States       |   77.310|  2002|  39097.100| USA | Washington, D.C. | en-US,es-US,haw,fr |
| United States       |   78.242|  2007|  42951.653| USA | Washington, D.C. | en-US,es-US,haw,fr |
| Uruguay             |   66.071|  1952|   5716.767| NA  | NA               | NA                 |
| Uruguay             |   67.044|  1957|   6150.773| NA  | NA               | NA                 |
| Uruguay             |   68.253|  1962|   5603.358| NA  | NA               | NA                 |
| Uruguay             |   68.468|  1967|   5444.620| NA  | NA               | NA                 |
| Uruguay             |   68.673|  1972|   5703.409| NA  | NA               | NA                 |
| Uruguay             |   69.481|  1977|   6504.340| NA  | NA               | NA                 |
| Uruguay             |   70.805|  1982|   6920.223| NA  | NA               | NA                 |
| Uruguay             |   71.918|  1987|   7452.399| NA  | NA               | NA                 |
| Uruguay             |   72.752|  1992|   8137.005| NA  | NA               | NA                 |
| Uruguay             |   74.223|  1997|   9230.241| NA  | NA               | NA                 |
| Uruguay             |   75.307|  2002|   7727.002| NA  | NA               | NA                 |
| Uruguay             |   76.384|  2007|  10611.463| NA  | NA               | NA                 |
| Venezuela           |   55.088|  1952|   7689.800| NA  | NA               | NA                 |
| Venezuela           |   57.907|  1957|   9802.467| NA  | NA               | NA                 |
| Venezuela           |   60.770|  1962|   8422.974| NA  | NA               | NA                 |
| Venezuela           |   63.479|  1967|   9541.474| NA  | NA               | NA                 |
| Venezuela           |   65.712|  1972|  10505.260| NA  | NA               | NA                 |
| Venezuela           |   67.456|  1977|  13143.951| NA  | NA               | NA                 |
| Venezuela           |   68.557|  1982|  11152.410| NA  | NA               | NA                 |
| Venezuela           |   70.190|  1987|   9883.585| NA  | NA               | NA                 |
| Venezuela           |   71.150|  1992|  10733.926| NA  | NA               | NA                 |
| Venezuela           |   72.146|  1997|  10165.495| NA  | NA               | NA                 |
| Venezuela           |   72.766|  2002|   8605.048| NA  | NA               | NA                 |
| Venezuela           |   73.747|  2007|  11415.806| NA  | NA               | NA                 |
