# Replication verification tasks

## Status 2026-10-17

All scripts were rerun in StataNow 19.5 and the engine CLI (see the repository-level [REPLICATION_TODO.md](../../REPLICATION_TODO.md) for the method). Transcripts: `validation/stata-2026-10-17-*.log`, `validation/engine-2026-10-17-*.log`.

- [x] Runs end to end in the engine; 306 aligned result rows (1131 numbers), 26 differing; 16 rows only in Stata's and 6 only in the engine's transcript. Errors: 3 Stata / 3 engine.
- [x] Adaptations: The unchanged script runs; generated files from earlier runs (`MainRuns.log`, `ArticlesAllYears.dta`) were removed from the engine workspace before the rerun, as Stata's run started from a fresh copy.
- [ ] Not reproducible by design: `sort articlenumber` followed by `drop if articlenumber==articlenumber[_n-1]` keeps one of 1,284 rows with missing `articlenumber`; Stata's unstable sort keeps a 2011 row, the engine's stable sort a 1963 row. This changes the pooled-sample fits (249 vs 248 observations) and the `ksmirnov … if year==2011` errors (r(450) in Stata, r(2000) in the engine). Every 2024-sample result equals Stata's.
- [ ] Verify in the browser build.

## History (2026-10-16 and earlier; superseded where the status above differs)

Validated 2026-10-13 against the deposited Stata 13 log and 2026-10-15 against
a fresh Stata 19.5 run. Every 2024-sample result equals Stata's. The package
has no figures.

- [ ] **Document, do not emulate: unstable sort.** The deduplication of the
  pooled file keeps whichever historical row Stata's unstable `sort` puts
  first (a 2011 row); the engine's stable sort keeps a 1963 row with missing
  `type`, so the pooled `by year` tables, `regr`/`poisson nauthors i.type`
  and the 2011 `ksmirnov` errors differ. Reproducing this requires Stata's
  sort internals; keep the explanation in the README.
- [ ] Print `(sum of wgt is ...)` after `summarize`/`regress` with `aweight`.
- [ ] Print `by`-group headers for groups with no observations.
- [ ] Wrap long variable labels in `tabulate` headers.
- [ ] `ksmirnov ... by()` with one group: `journal takes on 1 values, not 2`
  (r(450)).
- [ ] Verify the browser build separately.
