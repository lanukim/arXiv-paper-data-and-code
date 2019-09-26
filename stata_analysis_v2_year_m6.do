
* Papers that were staying on arXiv more than 6 months only

clear all

use "hep_ph_zeroinfl_m6.dta" 

gen n_year = mag_date_year - 1997
encode LongName, gen(n_LongName)

* Hep-ph
* Version WITHOUT NEGATIVE BINOMIAL MODEL
* Model 1
zinb after_n ///
month_diff ///
n_year ///
ArticleInfluence, ///
inflate(month_diff n_year ArticleInfluence) vce(cluster n_LongName) iter(50)
estimates store m1

estat ic
margins, at(ArticleInfluence = (0(.5)5)) vsquish 

* Model 2
zinb after_n ///
c.month_diff ///
c.n_year ///
c.ArticleInfluence ///
c.before_n, ///
inflate(month_diff n_year ArticleInfluence c.before_n) vce(cluster n_LongName) iter(50)
estimates store m2

estat ic
margins, at(ArticleInfluence = (0(.5)5) before_n = (0 2 5)) vsquish 

* Model 3
zinb after_n ///
month_diff ///
n_year ///
ArticleInfluence ///
before_n ///
c.ArticleInfluence#c.n_year, ///
inflate(month_diff n_year ArticleInfluence before_n c.ArticleInfluence#c.n_year) vce(cluster n_LongName) 
estimates store m3

estat ic
margins, at(ArticleInfluence = (0.5 4) n_year = (0 (3) 15) before_n = 1) vsquish 

estout m1 m2 m3, cells(b(star fmt(3)) se(par fmt(2)))  ///
   legend label varlabels(_cons constant)              ///
   stats(N ArticleInfluencec bic)
   
* Astrophysics   
clear all
use "astro_zeroinfl_m6.dta" 

gen n_year = mag_date_year - 1998
encode LongName, gen(n_LongName)

* Model 1
zinb after_n ///
month_diff ///
n_year ///
ArticleInfluence, ///
inflate(month_diff n_year ArticleInfluence) vce(cluster n_LongName) 
estimates store m1

estat ic
margins, at(ArticleInfluence = (0(.5)5)) vsquish 

* Model 2
zinb after_n ///
month_diff ///
n_year ///
ArticleInfluence ///
before_n, ///
inflate(month_diff n_year ArticleInfluence before_n) vce(cluster n_LongName) 
estimates store m2

estat ic
margins, at(ArticleInfluence = (0(.5)5) before_n = (0 2 5)) vsquish 

* Model 3
zinb after_n ///
month_diff ///
n_year ///
ArticleInfluence ///
before_n ///
c.ArticleInfluence#c.n_year, ///
inflate(month_diff n_year ArticleInfluence before_n c.ArticleInfluence#c.n_year) vce(cluster n_LongName) 
estimates store m3

estat ic
margins, at(ArticleInfluence = (0.5 4) n_year = (0 (3) 15) before_n = 1) vsquish 

estout m1 m2 m3, cells(b(star fmt(3)) se(par fmt(2)))  ///
   legend label varlabels(_cons constant)              ///
   stats(N ArticleInfluencec bic)

* Condensed matter
clear all
use "cond_zeroinfl_m6.dta" 

gen n_year = mag_date_year - 1998
encode LongName, gen(n_LongName)

* Model 1
zinb after_n ///
month_diff ///
n_year ///
ArticleInfluence, ///
inflate(month_diff n_year ArticleInfluence) vce(cluster n_LongName) iter(50)
estimates store m1

estat ic
margins, at(ArticleInfluence = (0(.5)5)) vsquish 

* Model 2
zinb after_n ///
month_diff ///
n_year ///
ArticleInfluence ///
before_n, ///
inflate(month_diff n_year ArticleInfluence before_n) vce(cluster n_LongName) iter(50)
estimates store m2

estat ic
margins, at(ArticleInfluence = (0(.5)5) before_n = (0 2 5)) vsquish 

* Model 3
zinb after_n ///
month_diff ///
n_year ///
ArticleInfluence ///
before_n ///
c.ArticleInfluence#c.n_year, ///
inflate(month_diff n_year ArticleInfluence before_n c.ArticleInfluence#c.n_year) vce(cluster n_LongName) iter(50)
estimates store m3

estat ic
margins, at(ArticleInfluence = (0.5 4) n_year = (0 (3) 15) before_n = 1) vsquish 

estout m1 m2 m3, cells(b(star fmt(3)) se(par fmt(2)))  ///
   legend label varlabels(_cons constant)              ///
   stats(N ArticleInfluencec bic)
   
