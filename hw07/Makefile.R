## one script to rule them all

## clean out any previous work
outputs <- c("gapminder.tsv",                     # 0_download-data.R
             "gap_re_continent.rds",              # 1_exploratory_analyses.R
             "lm_fits.tsv",                       # 2_statistical_analyses.R
             "gap_bfit.tsv",                      # 2_statistical_analyses.R
             list.files(pattern = "*.png$"))      # Figures created by all R Scripts
file.remove(outputs)

## run my scripts
source("0_download-data.R")
source("1_exploratory_analyses.R")
source("2_statistical_analyses.R")
source("3_generate_figures")