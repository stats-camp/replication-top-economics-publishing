# Replication: The Demographic and Research Styles of Economics Writing

Daniel S. Hamermesh — 2025 update to "Six Decades of Top Economics Publishing:
Who and How?" (*Journal of Economic Literature* 51 (1), 2013). The update is
circulated as NBER Working Paper 33731 and IZA Discussion Paper 17863 (2025).

This repository preserves the paper's official AEA replication deposit for
[stats.camp](https://stats.camp), so the analysis can be inspected and run in
the browser. The authors' commands remain in place, including the ones
stats.camp does not implement yet.

**Open in stats.camp:**
[JELExtensionScript.do](https://stats.camp/app?open=https%3A%2F%2Fgithub.com%2Fstats-camp%2Freplication-top-economics-publishing.git&file=JELExtensionScript.do)

## The study

The 2013 article described who published in the *American Economic Review*,
the *Journal of Political Economy* and the *Quarterly Journal of Economics*
from 1963 to 2011, and how: authors' age and gender, the number of co-authors,
and the style of research (theory, theory with simulation, empirical work on
borrowed data, empirical work on self-generated data, experiments). The update
hand-codes every 2024 article in the three journals, where each observation
is one author of one article, and appends the earlier years to test for trends
in author age, female representation, co-authorship and research style.

## Contents

| Path | Deposit name | Description |
| --- | --- | --- |
| `JELExtensionScript.do` | `3JELExtensionScript.do` | Runnable copy of the analysis: 2024 statistics for Table 1 and Figures 1–2, then trend tests on the pooled 1963–2024 data (see Adaptations) |
| `3JELExtensionScript.do` | same | Authors' do-file, byte-for-byte as deposited |
| `Articles2024STATA13.dta` | `2Articles2024STATA13.dta` | 2024 articles, one row per author–article: 719 observations, 12 variables |
| `FiftyYearsforJELExtensionSTATA13.dta` | `2FiftyYearsforJELExtensionSTATA13.dta` | Author–article data behind the 2013 article (1963–2011) |
| `4MainRuns.log` | same | Authors' Stata 13 log of the complete run; the reference output for every result in the script |
| `1JournalArticles2024Top3.xlsx` | same | Raw hand-coded 2024 article information per journal |
| `5Calculations-- Fem(based on … STATA data files.xlsx` | same | Authors' spreadsheet calculations on female representation and the age and co-authorship decompositions |
| `README.txt` | same | Authors' original package note |
| `validation/statscamp-nostop.log` | — | stats.camp diagnostic transcript, including the three data errors |
| `validation/results.json` | — | Source hashes, verified confidence intervals, exact KS results, and run status |

## What runs

The Stata analysis is supported by the stats.camp engine, verified on
2026-10-13 with the native build and the deposited Stata 13 transcript.
**A normal Run stops at line 63 with `r(2000)` because the deposited data
leave no 2011 observations for that test.** To execute the remaining analyses
without editing the do-file, run this command from a fresh workspace:

```stata
do JELExtensionScript.do, nostop
```

This reaches `log close` and reports exactly three data errors, at lines 63,
68, and 73. The two Stata 13 datasets load with their labels, and the script's
command syntax is supported: `mvdecode`, `gener` and `regr` (Stata's abbreviations of
`generate` and `regress`), `summarize` with and without `aweight`s, `sort`,
`drop if … [_n-1]`, `tabulate` with and without the `by` prefix, `append`,
`regress` with analytic weights and omitted collinear terms,
`by varlist: summarize`, `poisson` with factor variables, `ksmirnov …, exact`
with its ties note, `by varlist: egen`, `ci means` with and without weights
and under `by`, `save`, and the text log.

The 2024-only summaries and frequency tables agree with `4MainRuns.log` to
the printed precision. All three 2024 Kolmogorov–Smirnov tests match:

| Comparison | D | Asymptotic p | Exact p |
| --- | --- | --- | --- |
| AER versus JPE | 0.1232 | 0.440 | 0.402 |
| AER versus QJE | 0.2644 | 0.019 | 0.015 |
| JPE versus QJE | 0.3139 | 0.004 | 0.003 |

All 30 confidence interval rows with observations match the reference's
displayed numbers, including analytic weights, unweighted intervals, and
`by` groups. For example, the weighted `meanage` interval for research
styles 4 and 5 uses 430 observations: mean 41.93618, standard error
0.3146931, and 95% confidence interval [41.31765, 42.55471]. The weighted
2024 age-dispersion summaries also match the reference.

The opt-in `stats_core` tests `top_economics_publishing_deposit_runs_unchanged`
and `top_economics_publishing_do_modes_preserve_deposit` check these values,
the source hashes, and both stopping modes. [Verification results](validation/results.json)
and the [complete diagnostic transcript](validation/statscamp-nostop.log)
are included. A fresh Stata rerun was unavailable because the installed
license had expired; the numerical reference is the deposited Stata 13 log.

Two inconsistencies between the deposited data and reference log prevent a
full reproduction of the historical pooled results:

- The log was written on 6 May 2025, but
  `FiftyYearsforJELExtensionSTATA13.dta` was saved on 15 May 2025 and
  carries a nonmissing `weight` for every 1963–2011 author, whereas the
  log's weighted statistics on the pooled file have zero weighted
  observations before 2024 (for example `regress age year if type==1
  [aw=weight]` uses 127 observations and omits `year`). The engine's larger
  weighted samples on the pooled file reflect the data as deposited.
- The pooled file has no `articlenumber`, so after `append` every pre-2024
  row has it missing and line 42 (`drop if articlenumber==articlenumber[_n-1]`)
  keeps a single pre-2024 row, whichever sorts first among the ties. The log
  keeps 15 (one from 1993, 14 from 2011), so the file the log used differed
  here as well. The three `ksmirnov type if year==2011` statements (lines 63,
  68 and 73) therefore have no observations and return `r(2000)` in
  stats.camp. A normal run stops at the first; `do, nostop` continues. The
  by-group tables and the `regr`/`poisson` fits on the deduplicated pooled
  rows (lines 44–60) differ from the log in their pre-2024 rows for the same
  reason.

## Missing features and scope

No additional statistical command or option is needed to execute this
script's valid samples in the verified native engine. The unavailable 2011
KS results and mismatched historical weighted samples require corrected
source data to reproduce the deposited log.

The Stata script computes inputs for Table 1 and Figures 1–2; it does not
produce the published Excel calculations or figure layouts. Manual female
representation comparisons and age/co-authorship decompositions in the
Excel workbook remain outside this replication's target.

Display gaps remain: empty `ci means` groups omit Stata's row with N=0 and
missing statistics, `tabulate` does not wrap long variable labels into the
column header, `ksmirnov` column widths differ slightly, and `use` prints
extra notes. Native verification does not establish a separately tested
browser build.

Before rerunning, close any active log and remove generated `MainRuns.log`
and `ArticlesAllYears.dta`, or use a fresh workspace. Neither `log using`
nor `save` has a `replace` option. The script's `log using MainRuns` writes
`MainRuns.log` next to the data; the authors' deposited log keeps its deposit
name `4MainRuns.log`, so the two never collide.

## Adaptations and scope

The authors' note asks users to adapt paths to their own machine.
This package already contained a path-only working copy before the
2026-10-13 verification. **Neither do-file was changed during this work.**
`JELExtensionScript.do` differs from the deposited file only by removing the Windows prefix
`D:\JEL2013Extension\` is removed from the ten `log using`, `use`, `append
using` and `save` lines (4, 5, 30, 31, 52, 65, 70, 75, 76, 110), so the files
are read from and written to the working directory. No command, option,
variable or value was changed; `3JELExtensionScript.do` is the unchanged
original.

The two datasets are stored under the names the do-file expects
(`Articles2024STATA13.dta`, `FiftyYearsforJELExtensionSTATA13.dta`) instead of
the deposit's numbered names. Their contents are byte-identical to the
deposit. All other files keep their deposit names. No value in any data file
was changed.

## Source integrity

The files were copied from version V1 of the official AEA Data and Code
Repository deposit (`229865-V1.zip`, directory `Replication-files/`).

| Deposited file | SHA-256 |
| --- | --- |
| `3JELExtensionScript.do` | `6efcd76705bda99f1c83f9a3f4ce78fe317e50ae33faedcc60c3258a3caa4e92` |
| Existing path-only `JELExtensionScript.do` | `54a668e69932032c54d984905c3a42836d4bb53adee79ef6f22d7ca640b9a0d1` |
| `2Articles2024STATA13.dta` (here `Articles2024STATA13.dta`) | `154a9eb40ee2630859739a90cc4d7e3282c7b98362942da5c04f5bde3d1a727c` |
| `2FiftyYearsforJELExtensionSTATA13.dta` (here `FiftyYearsforJELExtensionSTATA13.dta`) | `a037071ee547e1d0214fbdb9e6f9618b09f7120a29bf63ed1ed3d31063e0aa59` |
| `4MainRuns.log` | `858b75469cb0897dfb999ab43e7c2e5a9a780ec4f7c113cf51d9153c3461111d` |
| `1JournalArticles2024Top3.xlsx` | `758903a49a9493e1f521365983d37508e68c79a5b2de6079643b4b55a40ede68` |
| `5Calculations-- Fem(based on … STATA data files.xlsx` | `86c005fbf8ce11fde03975fc860951ffbfd32d032f0dd876a6664c7c43264f8c` |
| `README.txt` | `9df918f6aaee93934e3665f2349be9090d07ae29b71352a7f22f0974ef862078` |

## Source and attribution

Hamermesh, Daniel S. 2025. "Replication Data for: 2025 Update to 'Six Decades
of Top Economics Publishing: Who and How?,' published in the Journal of
Economic Literature 51(1)." American Economic Association [publisher],
Inter-university Consortium for Political and Social Research [distributor].
[https://doi.org/10.3886/E229865V1](https://doi.org/10.3886/E229865V1)

Hamermesh, Daniel S. 2013. "Six Decades of Top Economics Publishing: Who and
How?" *Journal of Economic Literature* 51 (1): 162–172.
[https://doi.org/10.1257/jel.51.1.162](https://doi.org/10.1257/jel.51.1.162)

Hamermesh, Daniel S. 2025. "The Demographic and Research Styles of Economics
Writing." NBER Working Paper 33731.
[https://doi.org/10.3386/w33731](https://doi.org/10.3386/w33731)

The deposited archive contains no license file; the openICPSR deposit page
states the terms of use for the data and code. The data were hand-coded by the
author from the published articles. Please cite the paper and the deposit when
using these materials.
