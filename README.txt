README--Hamermesh JEL 2025

Replication Data for: "2025 Update to 'Six Decades of Top Economics Publishing: Who and How?,' published in the Journal of Economic Literature 51(1)"

STATA13 was used throughout the work.

The package includes:

I. EXCEL files containing information in separate spreadsheets JournalArticles2024Top3.xslx 
 Raw data on all 2024 articles. 2 spreadsheets each for JPE and AER, one for QJE. Plus a combined sheet.

II. Two STATA data files: 
A. The original information for 2024 articles:  Articles2024STATA13.dta  
This analysis file was created by hand from raw data contained in the EXCEL file above. 
Each observation is an author in an article. Thus the number of observations = Authors*articles

This is the only analytical file needed to obtain new information in the Table and Figures. The information for 1963-2011 is copied from the original article.

B. Information underlying the 2013 article: FiftyYearsforJELExtensionSTATA13.dta

C. Both are saved in STATA13.

III. A STATA do-file  JELExtensionScript.do
The do-file first creates the data for 2024 to include in Table 1 and the two Figures.
It then merges those data with the previous information for 1963-2011. 
Since all the information in the Table and Figures for 1963-2011 is taken from the 2013 published paper, the code after the FiftyYears file is loaded is simply used to test hypotheses about trends and other issues from 1963-2024.

IV. A text file MainRuns.txt showing the results of implementing the do-file.

V. An EXCEL file: Calculations  .xslx Contains separate spreadsheets with data/calculations on:
   A. Female representation comparisons, based on Lundberg-Stearns and AEA&P&P data. These latter data points were hand-copied from data provided by Lundberg or from AEAP&P
   B. Decomposition of trends in age of authors, shown in MainRuns.txt
   C. Decomposition of trends in article style, shown in MainRuns.txt




