
# STAT545 Homework 07 

_**Automating Data-analysis Pipelines**_

:round_pushpin: Here is hw07 folder under [my STAT545 Homework Repo](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao). :octocat:


## Files inside

1. [0_download_data.R](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw07/0_download_data.R)

2. [1_exploratory_analyses.R](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw07/1_exploratory_analyses.R)

3. [2_statistical_analyses.R](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw07/2_statistical_analyses.R)

4. [3_generate_figures.R](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw07/3_generate_figures.R)

5. [Makefile](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw07/Makefile)

6. [hw07_Gapminder.Rmd](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw07/hw07_Gapminder.Rmd)

7. [hw07_Gapminder.md](https://github.com/xinmiaow/STAT545-hw-Wang-Xinmiao/blob/master/hw07/hw07_Gapminder.md)

## To-Dos List

- [X] Download the data
- [X] Perform exploratory analyses
- [X] Perform statistical analyses
- [X] Generate figures
- [X] Automate the pipeline
- [ ] Submit the assignment

## Report Process

### 0_download_data.R

1. _**Job**_

* Download the dataset online

2. _**Input**_

* A link to the online dataset 

3. _**Output**_

* Dataset: gapminder.tsv

### 1_exploratory_analyses.R

1. _**Job**_

* Analyze the dataset, gapminder.tsv, by explore the distributions of variables of interest. 

* Reorder the levels of continents by the mean of their life expectancy, and then save it as a new dataset

2. _**Input**_

* gapminder.tsv

3. _**Output**_

* Dataset: gap_re_continent.rds

* Figures: barchart.png, histogram.png, timeplot_lifeExp.png, timeplot_meanLifeExp.png


### 2_statistical_analyses.R

1. _**Job**_

* Analyze the dataset, gap_re_continent.rds, by fit a linear regression for lifeExp to year for countries in each continent. 

* Save the intercept, the slop and the residual standard error as a file, called lm_fits.tsv

* Select four best and four worst countries in each continent according to the residual standard error of their lm fits

* Save the data of four best countries in each continent as a file, called gap_bfit.tsv

2. _**Input**_

* gap_re_continent.rds

3. _**Output**_

* Dataset: lm_fits.tsv, gap_bfit.tsv


### 3_generate_figures.R

1. _**Job**_

* Generate the scatterplot of lifeExp vs Year for each country in each contients and save then as .png files

2. _**Input**_

* gap_bfit.tsv

3. _**Output**_

* Figures: Africa.png, Asia.png, Americas.png, Europe.png, Oceania.png

### hw07_Gapminder.Rmd

1. _**Job**_

* Combine the outputs above, and render a report to summarize some important results

2. _**Input**_

* gap_bfit.tsv

3. -**Output**-

* Dataset: gapminder.tsv, gap_re_continent.rds, gap_bfit.tsv

* Figures: barchart.png, histogram.png, timeplot_lifeExp.png, timeplot_meanLifeExp.png, Africa.png, Asia.png, Americas.png, Europe.png, Oceania.png

### Makefile

1. _**Job**_

* Automate the pipeline 

* render a Markdown file

* After build all, clean all (Notes: to make hw07_Gapminder.md works well, I only delect the datasets)


***
*on Nov 13, 2017*


