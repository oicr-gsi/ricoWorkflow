# RICO Workflow for Immune Deconvolution

This WDL workflow is intended to run RICO: The *R*na-seq *I*mmune *CO*ntainer, developed by Richard Corbett at [BCGSC](https://www.bcgsc.ca/).

RICO consists of a [Singularity](https://docs.sylabs.io/guides/3.5/user-guide/introduction.html) container wrapped in a Nextflow workflow. This repo replaces Nextflow with WDL. On the OICR cluster, the `singularity` module is a prerequisite.

RICO comes in two versions:
- Old version, child benchmark set: [RICO](https://svn.bcgsc.ca/bitbucket/projects/RCORBETT/repos/rico/browse)
- New version, adult benchmark set: [RICO_adult](https://svn.bcgsc.ca/bitbucket/projects/RCORBETT/repos/rico_adult/browse)

The WDL was developed for RICO but should carry over to RICO_adult.

*NOTE*: As of 2022-08-09, the WDL is in a non-functioning development state and not ready for production.

## Copyright and License

Copyright (C) 2022 by Genome Sequence Informatics, Ontario Institute for Cancer Research.

Licensed under the [GPL 3.0 license](https://www.gnu.org/licenses/gpl-3.0.en.html).
