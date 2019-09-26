# Descriptive statistics and export data sets to Stata
library(dplyr)
load("arxiv_data.Rdata")

# Descriptive stats - Hep-ph
length(table(analysis1_hep$LongName))
summary(analysis1_hep$after_n)
summary(analysis1_hep$before_n)
summary(analysis1_hep$ArticleInfluence)
summary(analysis1_hep$month_diff)

# Export data sets to Stata - Hep-ph
write.dta(analysis1_hep, "hep_ph_zeroinfl.dta")

analysis1_hep <- analysis1_hep %>%
  filter(month_diff>6)
write.dta(analysis1_hep, "hep_ph_zeroinfl_m6.dta")

# Descriptive stats - Astrophysics
length(table(analysis1_astro$LongName))
summary(analysis1_astro$after_n)
summary(analysis1_astro$before_n)
summary(analysis1_astro$ArticleInfluence)
summary(analysis1_astro$month_diff)

# Export data sets to Stata - Astrophysics
write.dta(analysis1_astro, "astro_zeroinfl.dta")

analysis1_astro <- analysis1_astro %>%
  filter(month_diff>6)
write.dta(analysis1_astro, "astro_zeroinfl_m6.dta")

# Descriptive stats - Condensed matter
length(table(analysis1_cond$LongName))
summary(analysis1_cond$after_n)
summary(analysis1_cond$before_n)
summary(analysis1_cond$ArticleInfluence)
summary(analysis1_cond$month_diff)

# Export data sets to Stata - Condensed matter
write.dta(analysis1_cond, "cond_zeroinfl.dta")

analysis1_cond <- analysis1_cond %>%
  filter(month_diff>6)
write.dta(analysis1_cond, "cond_zeroinfl_m6.dta")

