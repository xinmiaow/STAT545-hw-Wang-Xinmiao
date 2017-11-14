# Load package
library(broom)

# Read dataset
gap_re_continent <- readRDS("gap_re_continent.rds")

# Fit model
## Define a function
## Input: mydat(a dataset), offeset(=1952)
## Output: A data frame(Interpect, Slope, RSD)
lm_ly <- function(mydat, offset=1952){
  fit <- lm(lifeExp ~ I(year-offset), data=mydat)
  beta0 <- coef(fit)[1]
  beta1 <- coef(fit)[2]
  res_SD <- summary(fit)$sigma
  output <- as.data.frame(list("Interpect"=beta0, "Slope"=beta1, "RSD"=res_SD))
  return(output)
}

lm_ly(gap_re_continent %>% filter(country == "Zimbabwe"))

myfits <- gap_re_continent %>% 
  group_by(country, continent) %>% 
  do(lm_ly(.))

# Write a file
write.table(myfits, "lm_fits.tsv",
            sep = "\t", row.names = FALSE, quote = FALSE)

# Select Top 4 countries for Each Continent
myfit_clean <- myfits %>% 
  group_by(continent) %>% 
  mutate(order_RSD = order(RSD)) %>% 
  filter(order_RSD<=4) %>% 
  select(-order_RSD)

write.table(myfit_clean, "lm_fits_clean.tsv",
            sep = "\t", row.names = FALSE, quote = FALSE)
