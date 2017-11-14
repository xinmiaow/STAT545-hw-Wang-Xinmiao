## one script to rule them all

## clean out any previous work
outputs <- c("gapminder.tsv",              # 0_download-data.R
             "gap_re_continent.rds",       # 1_exploratory_analyses.R
             "lm_fits.tsv",                # 2_statistical_analyses.R
             "gap_bfit.tsv",               # 2_statistical_analyses.R
             list.files(path="./hw07/",pattern = "*.png$"))      # Figures created by all R Scripts
file.remove(path="./hw07/", outputs)

## run my scripts
source("./hw07/0_download_data.R")
source("./hw07/1_exploratory_analyses.R")
source("./hw07/2_statistical_analyses.R")
source("./hw07/3_generate_figures.R")

