# arXiv-paper-data-and-code

This git repository is to share the data and code that are used in the research paper titled "Scientific Journals Still Matter in the Era of Academic Search Engines and Preprint Archives." The analysis is done by using both R and Stata. 
Following description explains each code file and variable. They are ordered to replicate the results as shown in our article.

## The list of code files
### Analysis 1
1. export_data_set.R - export the R data set to Stata. Also, briefly check descriptive statistics in supplementary materials. 
2. stata_analysis_v2_year - run zero inflated negative binomial models and compute the predicted probability. (Predicted probability is recorded in arxiv_analysis_v2_year.csv)
3. stata_analysis_v2_year_m6 - the robust check of the analyses in “stata_analysis_v2_year” only with the papers staying on arXiv more than six months. (Predicted probability is recorded in arxiv_analysis_v2_year_m6.csv)
4. stata_analysis_v2_robust_check - another robust check of the analyses in “stata_analysis_v2_year” by measuring the temporal trend with the total citation count received by papers that were on arXiv. 
5. analysis1_q1_q2.R - create Figure 2, 3, and Supplementary figure S1. 
6. analysis1_q1_q2_robust_check_with_arXiv_total_citations.R - graphical display of the robust check done in “stata_analysis_v2_robust_check” Stata file. 

### Analysis 2
1. analysis2_q3.R - Survival analysis and its graphical display.

## Variable description of the data objects included in "arxiv_data.Rdata"
### Variables in the data sets used in zero-inflated negative binomial models(analysis1_hep, analysis1_astro, analysis1_cond)
*The unit of analysis is a paper.*
- mag_date_year: the year when a paper is published in a journal
- mag_id: ID from Microsoft Academic Graph data
- ShortName: abbreviated name of a journal
- LongName: the full name of a journal
- arxiv_id: ID from arXiv.org data 
- arxiv_date: the date when a paper is first uploaded on arXiv
- mag_date: the date when a paper is updated on Microsoft Academic Graph data (the date we consider as a journal publication date)
- mag_EF: Eigenfactor of a paper from Microsoft Academic Graph
- arxiv_doi: DOI from arXiv data
- num_incoming_referecnes: the number of references
- primary_category: primary classification category from arXiv data
- arxiv_date_year: the year when a paper is first uploaded in arXiv
- ArticleInfluence: ArticleInfluence (journal influence) of the journal where a paper is published in a given year. 
- before_n: the received citation count /before/ published in a journal
- after_n: the received citation count during three years /after/ published in a journal
- mag_date_month:  eMonth of published date in a journal
- arxiv_date_month: eMonth of uploaded on arXiv
- month_diff: mag_date_month - arxiv_date_month
- mag_years_since_1998: mag_date_year - 1998
- cite_n: total citations made to arXiv papers in a given year
- paper_n: total papers published in arXiv in a given year
- sqrt_month_diff: sqrt(month_diff)
- sqrt_AI: sqrt(AI)
- sqrt_before_n: sqrt(before_n)
- ISSN: ISSN of a published journal

### Variables in the data sets used in survival analysis (analysis2_hep, analysis2_astro, analysis3_cond)
*The unit of analysis is a paper-month.*
- arxiv_date_year: the year of a given month
- mag_id: ID from Microsoft Academic Graph data
- t_start: the beginning of an observed time
- t_end: the end of an observed time
- arxiv_date_month: eMonth of the given month
- n: the received citation count in a given month
- cum_n: the cumulative received citation count up to a given month
- pub_journal: whether a paper is published in a given month
- cite_n: total citations made to arXiv papers in a given year
- paper_n: total papers published in arXiv in a given year
- sqrt_cum: sqrt(cum_n)
- sqrt_cite_n: sqrt(cite_n)
- sqrt_n: sqrt(paper_n)
- n_year: arxiv_date_year - 1998

