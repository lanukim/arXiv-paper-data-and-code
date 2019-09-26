clear all

use "hep_ph_zeroinfl.dta" 

gen cite_n = mag_date_year - 1997
encode LongName, gen(n_LongName)

* Hep-ph
* Version WITHOUT NEGATIVE BINOMIAL MODEL
* Model 1
zinb after_n ///
month_diff ///
cite_n ///
ArticleInfluence, ///
inflate(month_diff cite_n ArticleInfluence) vce(cluster n_LongName) iter(50)
estimates store m1
estat ic

* Model 2
zinb after_n ///
c.month_diff ///
c.cite_n ///
c.ArticleInfluence ///
c.before_n, ///
inflate(month_diff cite_n ArticleInfluence c.before_n) vce(cluster n_LongName) iter(50)
estimates store m2
estat ic

* Model 3
zinb after_n ///
month_diff ///
cite_n ///
ArticleInfluence ///
before_n ///
c.ArticleInfluence#c.cite_n, ///
inflate(month_diff cite_n ArticleInfluence before_n c.ArticleInfluence#c.cite_n) vce(cluster n_LongName) 
estimates store m3
estat ic

estout m1 m2 m3, cells(b(star fmt(3)) se(par fmt(2)))  ///
   legend label varlabels(_cons constant)              ///
   stats(N ArticleInfluencec bic)
   
* Astrophysics   
clear all
use "astro_zeroinfl.dta" 

gen cite_n = mag_date_year - 1998
encode LongName, gen(n_LongName)

* Model 1
zinb after_n ///
month_diff ///
cite_n ///
ArticleInfluence, ///
inflate(month_diff cite_n ArticleInfluence) vce(cluster n_LongName) 
estimates store m1
estat ic

* Model 2
zinb after_n ///
month_diff ///
cite_n ///
ArticleInfluence ///
before_n, ///
inflate(month_diff cite_n ArticleInfluence before_n) vce(cluster n_LongName) 
estimates store m2
estat ic

* Model 3
zinb after_n ///
month_diff ///
cite_n ///
ArticleInfluence ///
before_n ///
c.ArticleInfluence#c.cite_n, ///
inflate(month_diff cite_n ArticleInfluence before_n c.ArticleInfluence#c.cite_n) vce(cluster n_LongName) 
estimates store m3
estat ic

estout m1 m2 m3, cells(b(star fmt(3)) se(par fmt(2)))  ///
   legend label varlabels(_cons constant)              ///
   stats(N ArticleInfluencec bic)

* Condensed matter
clear all
use "cond_zeroinfl.dta" 

gen cite_n = mag_date_year - 1998
encode LongName, gen(n_LongName)

* Model 1
zinb after_n ///
month_diff ///
cite_n ///
ArticleInfluence, ///
inflate(month_diff cite_n ArticleInfluence) vce(cluster n_LongName) iter(50)
estimates store m1
estat ic

* Model 2
zinb after_n ///
month_diff ///
cite_n ///
ArticleInfluence ///
before_n, ///
inflate(month_diff cite_n ArticleInfluence before_n) vce(cluster n_LongName) iter(50)
estimates store m2
estat ic

* Model 3
zinb after_n ///
month_diff ///
cite_n ///
ArticleInfluence ///
before_n ///
c.ArticleInfluence#c.cite_n, ///
inflate(month_diff cite_n ArticleInfluence before_n c.ArticleInfluence#c.cite_n) vce(cluster n_LongName) iter(50)
estimates store m3
estat ic

estout m1 m2 m3, cells(b(star fmt(3)) se(par fmt(2)))  ///
   legend label varlabels(_cons constant)              ///
   stats(N ArticleInfluencec bic)
   
