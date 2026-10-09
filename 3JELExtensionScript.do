clear
set logtype text
*You need to alter the next two lines to fit your own machine and locations throughout the do-file.*
log using D:\JEL2013Extension\MainRuns
use D:\JEL2013Extension\Articles2024STATA13.dta
mvdecode age,mv(9999)
*Calculating information for 2024 articleson female, number of authors, age distributions for TABLE 1, FIGURES 1 AND 2*
gener byte agele35=0 if age<990
gener byte age3650=0 if age<990
gener byte age5160=0 if age<990
gener byte age61pl=0 if age<990
replace agele35=1 if age<=35
replace age3650=1 if age>35 & age<=50
replace age5160=1 if age>50 & age<=60
replace age61pl=1 if age>60 & age<990
sum female age*
sum female age* nauthors [aw=weight]
sort year
sum female if age<=35
sum female if age>35 & age<=50
sum female if age>50 & age<=60
sum female if age>60 & age<990
sort articlenumber
drop if articlenumber==articlenumber[_n-1] 
tab nauthors
sum nauthors
tab type
clear
*From here down various calculations examining trends and reported in the text*
use D:\JEL2013Extension\Articles2024STATA13.dta
append using D:\JEL2013Extension\FiftyYearsforJELExtensionSTATA13.dta
regress age year if type==1 [aw=weight]
regress age year if type==2 [aw=weight]
regress age year if type==3 [aw=weight]
regress age year if type==4 [aw=weight]
regress age year if type==5 [aw=weight]
sort year
by year: sum female age
by year: sum female age [aw=weight]
*For idea on changing journal styles*
sort articlenumber
drop if articlenumber==articlenumber[_n-1]
sort year
by year: tab nauthors
by year: sum nauthors
sort journal
by journal: tab type if year<2000
by journal: tab type if year==2003
by journal: tab type if year==2011
by journal: tab type if year==2024
tab type if nauthors>4 & year==2024
save D:\JEL2013Extension\ArticlesAllYears
*For idea on changing nauthors in response to changing research styles*
regr nauthors i.type 
poisson nauthors i.type 
regr nauthors i.type i.year 
poisson nauthors i.type i.year 
*Test for equality of style*
sort year journal
by year journal: tab type
drop if journal==3 | year<2011
ksmirnov type if year==2024, by(journal) exact
ksmirnov type if year==2011, by(journal) exact
clear
use D:\JEL2013Extension\ArticlesAllYears
drop if journal==2 | year<2011
ksmirnov type if year==2024, by(journal) exact
ksmirnov type if year==2011, by(journal) exact
clear
use D:\JEL2013Extension\ArticlesAllYears
drop if journal==1 | year<2011
ksmirnov type if year==2024, by(journal) exact
ksmirnov type if year==2011, by(journal) exact
clear
use D:\JEL2013Extension\Articles2024STATA13.dta
append using "D:\JEL2013Extension\FiftyYearsforJELExtensionSTATA13.dta"
*Looking at age distribution within articles
sort articlenumber
by articlenumber: egen sdage=sd(age) 
by articlenumber: egen minage=min(age)
by articlenumber: egen meanage=mean(age)
by articlenumber: egen maxage=max(age)
by articlenumber: gener agediff=maxage-minage
by articlenumber: gener cvarage=sdage/meanage
sum age if  nauthors==2 
sum sdage cvarage if nauthors==2 
sum age if  nauthors==3
sum sdage cvarage if nauthors==3
sum age if  nauthors==4
sum sdage cvarage if nauthors==4
sum age if nauthors>4 [aw=weight]
sum sdage cvarage if nauthors>4 [aw=weight]
sum age if  nauthors==2 & year<2020
sum sdage cvarage if nauthors==2 & year<2020
sum age if  nauthors==3 & year<2020
sum sdage cvarage if nauthors==3 & year<2020
sum age if  nauthors==4 & year<2020
sum sdage cvarage if nauthors==4 & year<2020
sum age if nauthors>4 & year<2020 [aw=weight] 
sum sdage cvarage if nauthors>4 & year<2020 [aw=weight] 
sum age if  nauthors==2 & year==2024
sum sdage cvarage if nauthors==2 & year==2024
sum age if  nauthors==3& year==2024
sum sdage cvarage if nauthors==3& year==2024
sum age if  nauthors==4& year==2024
sum sdage cvarage if nauthors==4& year==2024
sum age if nauthors>4 & year==2024 [aw=weight]
sum sdage cvarage if nauthors>4 & year==2024 [aw=weight]
clear
use D:\JEL2013Extension\Articles2024STATA13.dta
sort type
by type: ci means age [aw=weight]
sort articlenumber
by articlenumber: egen minage=min(age) if nauthors>3
by articlenumber: egen meanage=mean(age)
gener adjmeanage=meanage-minage/nauthors if nauthors>3
replace adjmeanage=meanage if nauthors<=3
sort type
by type: ci means age meanage [aw=weight]
ci means age meanage if type==1 | type==2 [aw=weight]
ci means age meanage if type==3
ci means age meanage if type==4 | type==5 [aw=weight]
*Relation of minage to nauthors*
sort nauthors
by nauthors: ci means minage [aw=weight]
by nauthors: ci means age if age<=30 [aw=weight]
log close

