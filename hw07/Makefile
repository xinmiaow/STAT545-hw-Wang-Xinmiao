## one Makefile to make them all

all: hw07_Gapminder.html

gapminder.tsv:
	Rscript 0_download_data.R

barchart.png histogram.png timeplot_lifeExp.png timeplot_meanLifeExp.png gap_re_continent.rds: gapminder.tsv
	Rscript 1_exploratory_analyses.R

gap_bfit.tsv: gap_re_continent.rds
	Rscript 2_statistical_analyses.R

Africa.png Asia.png Americas.png Europe.png Oceania.png: gap_bfit.tsv
	Rscript 3_generate_figures.R

hw07_Gapminder.html: hw07_Gapminder.Rmd gapminder.tsv gap_re_continent.rds gap_bfit.tsv barchart.png histogram.png timeplot_lifeExp.png timeplot_meanLifeExp.png Africa.png Asia.png Europe.png Americas.png Oceania.png
	Rscript -e 'rmarkdown::render("$<")'

clean:
	rm -rf *.tsv *.png 0*.md *.html