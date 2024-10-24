This is a fork designed to address reviews on the TMLR submission [Paper 3193](https://openreview.net/forum?id=aV6dCg1VFV&nesting=2&sort=date-desc)

Familiarity with TabZilla is required to make this repo work.

In broad strokes:
- New options added to config files:
  1. `impute`: this option can either be absent (corresponding to `drop` in the paper) or one of the options listed in `get_experiment_parser()` in `tabzilla_utils.py`
  2. `inject_missing`: this option specifies a fraction of numeric datapoints to be randomly replace with NA. This is MCAR.
- New experiment scripts to enable running on local/sshed machines; i.e. no need for google cloud
  - Also a bunch of intermediate task subselections saved as new sourcable bash scripts.
- New flags for `tabzilla_results_aggregator.py` which enables result processing from different folders and to output with different suffixes
  1. --dir: specify which results dir you wish to analyse; make sure to save different imputation schemes in different folders
  2. --suffix: specifies a suffix to save some outputs with.
- Rudimentary comment-out semantics in the results visualisation to process the suffixed outputs from `tabzilla_results_aggregator.py`

This is by no means a thorough re-implementation and as such will not be re-merged into the official TabZilla repo.

We note the original repository had a large issue with memory leaks, due to accumulated forward pass graphs in validation, in the base pytorch class. This has also been fixed.