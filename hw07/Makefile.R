## one script to rule them all

## clean out any previous work
outputs <- c("./hw07/gapminder.tsv",              # 0_download-data.R
             "./hw07/gap_re_continent.rds",       # 1_exploratory_analyses.R
             "./hw07/lm_fits.tsv",                # 2_statistical_analyses.R
             "./hw07/gap_bfit.tsv",               # 2_statistical_analyses.R
             list.files(pattern = "*.png$"))      # Figures created by all R Scripts
file.remove(outputs)

## run my scripts
source("./hw07/0_download_data.R")
source("./hw07/1_exploratory_analyses.R")
source("./hw07/2_statistical_analyses.R")
source("./hw07/3_generate_figures.R")
