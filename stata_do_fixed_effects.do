cd "/Users/yoga/Dropbox/1 新冠和商业地产/101 CRE second time 202205"

capture log close
log using cre_fixed_effect, replace text
clear all
set linesize 85
macro drop _all


browse

//use retail file
cls
clear
sysuse 32_4_retail_covid_2018-2021.dta

//use office file
cls
clear 
sysuse 31_4_office_covid_2018-2021.dta

//use industry file
cls
clear 
sysuse 33_4_industry_covid_2018-2021.dta

//only case or only death in the model. use emp directly

//gen empmillion
generate empmillion=totalemployment/1000000

tsset cbsacode timeindex
xtreg vacancyrate ln_cases_current ln_cases_prior q2 q3 q4 empmillion percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store vacancyfe_case
xtreg vacancyrate ln_death_current ln_death_prior q2 q3 q4 empmillion percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store vacancyfe_death

xtreg salesvolumetransactions ln_cases_current ln_cases_prior q2 q3 q4 empmillion percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store transactionsfe_case
xtreg salesvolumetransactions ln_death_current ln_death_prior q2 q3 q4 empmillion percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store transactionsfe_death

xtreg marketsalepricegrowth ln_cases_current ln_cases_prior q2 q3 q4 empmillion percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store salegrowthfe_case
xtreg marketsalepricegrowth ln_death_current ln_death_prior q2 q3 q4 empmillion percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store salegrowthfe_death

xtreg marketrentgrowth ln_cases_current ln_cases_prior q2 q3 q4 empmillion percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store rentgrowthfe_case
xtreg marketrentgrowth ln_death_current ln_death_prior q2 q3 q4 empmillion percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store rentgrowthfe_death

esttab vacancyfe_case vacancyfe_death rentgrowthfe_case rentgrowthfe_death, replace  nonumbers legend label mtitles("vac_case" "vac_death" "rent_case" "rent_death") se stats(r2 F N) title("rental market regression")
//esttab vacancyfe_case vacancyfe_death rentgrowthfe_case rentgrowthfe_death using "301_Table 1. retail rental market regression.csv", replace  nonumbers legend label mtitles("vac_case" "vac_death" "rent_case" "rent_death") se stats(r2 F N) title(" rental market regression")

esttab transactionsfe_case transactionsfe_death salegrowthfe_case salegrowthfe_death, replace  nonumbers legend label mtitles( "vol_case" "vol_death" "sal_gr_ca" "sal_gr_death" ) se stats(r2 F N) title("sale market regression")
//esttab transactionsfe_case transactionsfe_death salegrowthfe_case salegrowthfe_death using "303_Table 3. industry sale market regression.csv", replace  nonumbers legend label mtitles( "vol_case" "vol_death" "sal_gr_ca" "sal_gr_death" ) se stats(r2 F N) title("sale market regression")

esttab rentgrowthfe_case rentgrowthfe_death vacancyfe_case vacancyfe_death salegrowthfe_case salegrowthfe_death transactionsfe_case transactionsfe_death  using "403_Table 3. industrial fixed effect regression.csv", replace  nonumbers legend label mtitles("rent_growth_case" "rent_growth_death" "vacancy_case" "vacancy_death" "sale_growth_case" "sale_growth_death" "transaction_case" "transaction_death") se stats(r2 F N) title(" fixed effect regression")



//esttab vacancyratefe salesvolumetransactionsfe marketsalepricegrowthfe marketrentgrowthfe using "203_Table 3. Industrial fixed effect regression.csv", replace  nonumbers legend label mtitles("vacancyrate" "salesvolume" "pricegrowth" "rentgrowth") se stats(ll aic bic N) title("Table 3.  fixed effect regression")

//only case or only death in the model. using ln emp
//generate the  ln_emp
generate lemp=ln(totalemployment)

tsset cbsacode timeindex
xtreg vacancyrate ln_cases_current ln_cases_prior q2 q3 q4 lemp percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store vacancyfe_case_lem
xtreg vacancyrate ln_death_current ln_death_prior q2 q3 q4 lemp percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store vacancyfe_death_lem

xtreg salesvolumetransactions ln_cases_current ln_cases_prior q2 q3 q4 lemp percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store transactionsfe_case_lem
xtreg salesvolumetransactions ln_death_current ln_death_prior q2 q3 q4 lemp percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store transactionsfe_death_lem

xtreg marketsalepricegrowth ln_cases_current ln_cases_prior q2 q3 q4 lemp percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store salegrowthfe_case_lem
xtreg marketsalepricegrowth ln_death_current ln_death_prior q2 q3 q4 lemp percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store salegrowthfe_death_lem

xtreg marketrentgrowth ln_cases_current ln_cases_prior q2 q3 q4 lemp percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store rentgrowthfe_case_lem
xtreg marketrentgrowth ln_death_current ln_death_prior q2 q3 q4 lemp percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store rentgrowthfe_death_lem

esttab vacancyfe_case_lem vacancyfe_death_lem rentgrowthfe_case_lem rentgrowthfe_death_lem, replace  nonumbers legend label mtitles("vac_case" "vac_death" "rent_case" "rent_death") se stats(ll aic bic N) title("Table 3.  rental market regression")

esttab transactionsfe_case_lem transactionsfe_death_lem salegrowthfe_case_lem salegrowthfe_death_lem, replace  nonumbers legend label mtitles( "vol_case" "vol_death" "sal_gr_ca" "sal_gr_death" ) se stats(ll aic bic N) title("Table 3.  sale market regression")









//try fixed effect regression 这里是employmnet 没有取对数

tsset cbsacode timeindex
xtreg vacancyrate ln_cases_current ln_death_current ln_cases_prior ln_death_prior q2 q3 q4 totalemployment percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store vacancyratefe


xtreg salesvolumetransactions ln_cases_current ln_death_current ln_cases_prior ln_death_prior q2 q3 q4 totalemployment percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store salesvolumetransactionsfe

xtreg marketsalepricegrowth ln_cases_current ln_death_current ln_cases_prior ln_death_prior q2 q3 q4 totalemployment percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store marketsalepricegrowthfe

xtreg marketrentgrowth ln_cases_current ln_death_current ln_cases_prior ln_death_prior q2 q3 q4 totalemployment percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store marketrentgrowthfe

esttab vacancyratefe salesvolumetransactionsfe marketsalepricegrowthfe marketrentgrowthfe , replace  nonumbers legend label mtitles("vacancyrate" "salesvolume" "pricegrowth" "rentgrowth") se stats(ll aic bic N) title("Table 3.  fixed effect regression")


esttab vacancyratefe salesvolumetransactionsfe marketsalepricegrowthfe marketrentgrowthfe using "203_Table 3. Industrial fixed effect regression.csv", replace  nonumbers legend label mtitles("vacancyrate" "salesvolume" "pricegrowth" "rentgrowth") se stats(ll aic bic N) title("Table 3.  fixed effect regression")

//201_Table 1.  Retail fixed effect regression.csv
//202_Table 2. Office fixed effect regression.csv
//203_Table 3. Industrial fixed effect regression.csv









//try fixed effects use the natural log of employment
//generate the  ln_emp
generate lemp=ln(totalemployment)

tsset cbsacode timeindex
xtreg vacancyrate ln_cases_current ln_death_current ln_cases_prior ln_death_prior q2 q3 q4 lemp percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store vacancyratefe_lnemp


xtreg salesvolumetransactions ln_cases_current ln_death_current ln_cases_prior ln_death_prior q2 q3 q4 lemp percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store salesvolumefe_lnemp

xtreg marketsalepricegrowth ln_cases_current ln_death_current ln_cases_prior ln_death_prior q2 q3 q4 lemp percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store salepricegrowthfe_lnemp

xtreg marketrentgrowth ln_cases_current ln_death_current ln_cases_prior ln_death_prior q2 q3 q4 lemp percentage_facialmask percentage_stayathome,fe cluster(cbsacode)
est store rentgrowthfe_lnemp

esttab vacancyratefe_lnemp salesvolumefe_lnemp salepricegrowthfe_lnemp rentgrowthfe_lnemp , replace  nonumbers legend label mtitles("vacancyrate" "salesvolume" "pricegrowth" "rentgrowth") se stats(ll aic bic N) title("Table 1.  fixed effect regression")
esttab vacancyratefe_lnemp salesvolumefe_lnemp salepricegrowthfe_lnemp rentgrowthfe_lnemp using "103_Table 3. Industrial fixed effect regression.csv", replace  nonumbers legend label mtitles("vacancyrate" "salesvolume" "pricegrowth" "rentgrowth") se stats(ll aic bic N) title("Table 1.  fixed effect regression")

//101_Table 1.  Retail fixed effect regression.csv
//102_Table 2. Office fixed effect regression.csv
//103_Table 3. Industrial fixed effect regression.csv



//下面是dummy variable regression


//put cbsa dummy variable into the model.
reg vacancyrate ln_cases_current ln_death_current i.cbsacode //这个没有调整std



//1 only cbsacode
areg vacancyrate ln_cases_current ln_death_current ,absorb(cbsacode) cluster(cbsacode)
est store vacancyrate1

areg salesvolumetransactions ln_cases_current ln_death_current ,absorb(cbsacode) cluster(cbsacode)
est store salesvolumetransactions1

areg marketsalepricegrowth ln_cases_current ln_death_current ,absorb(cbsacode) cluster(cbsacode)
est store marketsalepricegrowth1

areg marketrentgrowth ln_cases_current ln_death_current ,absorb(cbsacode) cluster(cbsacode)
est store marketrentgrowth1

esttab vacancyrate1 salesvolumetransactions1 marketsalepricegrowth1 marketrentgrowth1 , replace  nonumbers legend label mtitles("vacancyrate" "salesvolume" "pricegrowth" "rentgrowth") se stats(ll aic bic N) title("Table 1.  basic reg")


//新增季度dummy variable
areg vacancyrate ln_cases_current ln_death_current q2 q3 q4,absorb(cbsacode) cluster(cbsacode)
est store vacancyrate2

areg salesvolumetransactions ln_cases_current ln_death_current q2 q3 q4 ,absorb(cbsacode) cluster(cbsacode)
est store salesvolumetransactions2

areg marketsalepricegrowth ln_cases_current ln_death_current q2 q3 q4,absorb(cbsacode) cluster(cbsacode)
est store marketsalepricegrowth2

areg marketrentgrowth ln_cases_current ln_death_current q2 q3 q4,absorb(cbsacode) cluster(cbsacode)
est store marketrentgrowth2

esttab vacancyrate2 salesvolumetransactions2 marketsalepricegrowth2 marketrentgrowth2 , replace  nonumbers legend label mtitles("vacancyrate" "salesvolume" "pricegrowth" "rentgrowth") se stats(ll aic bic N) title("Table 1.  quater dummy reg")

//新增total employment facial mask stay at home
areg vacancyrate ln_cases_current ln_death_current q2 q3 q4 totalemployment percentage_facialmask percentage_stayathome,absorb(cbsacode) cluster(cbsacode)
est store vacancyrate3

areg salesvolumetransactions ln_cases_current ln_death_current q2 q3 q4 totalemployment percentage_facialmask percentage_stayathome,absorb(cbsacode) cluster(cbsacode)
est store salesvolumetransactions3

areg marketsalepricegrowth ln_cases_current ln_death_current q2 q3 q4 totalemployment percentage_facialmask percentage_stayathome,absorb(cbsacode) cluster(cbsacode)
est store marketsalepricegrowth3

areg marketrentgrowth ln_cases_current ln_death_current q2 q3 q4 totalemployment percentage_facialmask percentage_stayathome,absorb(cbsacode) cluster(cbsacode)
est store marketrentgrowth3

esttab vacancyrate3 salesvolumetransactions3 marketsalepricegrowth3 marketrentgrowth3 , replace  nonumbers legend label mtitles("vacancyrate" "salesvolume" "pricegrowth" "rentgrowth") se stats(ll aic bic N) title("Table 1.  quater dummy and control reg")


//新增滞后一期新冠数据
areg vacancyrate ln_cases_current ln_death_current ln_cases_prior ln_death_prior q2 q3 q4 totalemployment percentage_facialmask percentage_stayathome,absorb(cbsacode) cluster(cbsacode)
est store vacancyrate4

areg salesvolumetransactions ln_cases_current ln_death_current ln_cases_prior ln_death_prior q2 q3 q4 totalemployment percentage_facialmask percentage_stayathome,absorb(cbsacode) cluster(cbsacode)
est store salesvolumetransactions4

areg marketsalepricegrowth ln_cases_current ln_death_current ln_cases_prior ln_death_prior q2 q3 q4 totalemployment percentage_facialmask percentage_stayathome,absorb(cbsacode) cluster(cbsacode)
est store marketsalepricegrowth4

areg marketrentgrowth ln_cases_current ln_death_current ln_cases_prior ln_death_prior q2 q3 q4 totalemployment percentage_facialmask percentage_stayathome,absorb(cbsacode) cluster(cbsacode)
est store marketrentgrowth4

esttab vacancyrate4 salesvolumetransactions4 marketsalepricegrowth4 marketrentgrowth4 , replace  nonumbers legend label mtitles("vacancyrate" "salesvolume" "pricegrowth" "rentgrowth") se stats(ll aic bic N) title("Table 1.  quater dummy and control and last covid reg")







