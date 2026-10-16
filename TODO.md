# Validation status and remaining items

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
