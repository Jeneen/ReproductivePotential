**Global patterns and drivers of fish reproductive potential on coral reefs**

*Jeneen Hadj-Hammou, Joshua E. Cinner, Diego R. Barneche, Iain R. Caldwell, David Mouillot, James P.W. Robinson, Nina M.D. Schiettekatte, Alexandre C. Siqueira, Brett M. Taylor, Nicholas A.J. Graham*

------------------------------------------------------------------------

**To reproduce the main analyses, run the R scripts:**

[install.R](https://github.com/Jeneen/ReproductivePotential/blob/main/scripts/install.R)

[run_main_analysis.R](https://github.com/Jeneen/ReproductivePotential/blob/main/scripts/run_main_analysis.R)

However, please note that the following scripts *may* need to be run on a High Performance Computing Cluster:

[04_SppTempMod.R](https://github.com/Jeneen/ReproductivePotential/blob/main/scripts/04_SppTempMod.R) (\~2 days)

[06_SexRatioMod.R](https://github.com/Jeneen/ReproductivePotential/blob/main/scripts/06_SexRatioMod.R) (\~2 days)

[08_BarnecheFecMod.R](https://github.com/Jeneen/ReproductivePotential/blob/main/scripts/08_BarnecheFecMod.R) (\~2 days)

The following scripts are also computationally expensive and may take \~ 1 day to run:

[10_ExtrapFecund.R](https://github.com/Jeneen/ReproductivePotential/blob/main/scripts/10_ExtrapFecund.R) (\~ several hours)

[11_SampleBySexRatio.R](https://github.com/Jeneen/ReproductivePotential/blob/main/scripts/11_SampleBySexRatio.R) (\~ several hours)

------------------------------------------------------------------------

**Repository content**

[data:](https://github.com/Jeneen/ReproductivePotential/tree/main/data) folder containing all data for analysis.

[scripts:](https://github.com/Jeneen/ReproductivePotential/tree/main/scripts) folder containing all scripts for analysis (including supplementary analysis).

[output:](https://github.com/Jeneen/ReproductivePotential/tree/main/output) folder containing all outputs and figures produced.

------------------------------------------------------------------------

**Code referenced/adapted to produce analysis:**

NOAA_OISST_ndf4 function (<https://lukemiller.org/index.php/2014/11/extracting-noaa-sea-surface-temperatures-with-ncdf4/>)

Fecundity model ([<https://github.com/dbarneche/fishFecundity>])

Phylogenetic extrapolation (<https://github.com/valerianoparravicini/Trophic_Fish_2020>)

Global drivers model (<https://github.com/JZamborain-Mason/Cinneretal_2020_multiplegoals>)

------------------------------------------------------------------------

**sessionInfo()**

R version 4.3.3 (2024-02-29) Platform: aarch64-apple-darwin20 (64-bit) Running under: macOS Sonoma 14.4.1

Matrix products: default BLAS: /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib LAPACK: /Library/Frameworks/R.framework/Versions/4.3-arm64/Resources/lib/libRlapack.dylib; LAPACK version 3.11.0

locale: [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

time zone: Europe/London tzcode source: internal

attached base packages: [1] grid parallel stats graphics grDevices utils datasets methods base

other attached packages: [1] openxlsx_4.2.5.2 ggplotify_0.1.2 sjPlot_2.8.15 janitor_2.2.0 reshape2_1.4.4\
[6] devtools_2.4.5 usethis_2.2.3 cowplot_1.1.3 patchwork_1.2.0 scales_1.3.0\
[11] paletteer_1.6.0 lme4_1.1-35.3 Matrix_1.6-5 ggbeeswarm_0.7.2 ggrepel_0.9.5\
[16] RColorBrewer_1.1-3 viridis_0.6.5 sp_2.1-3 broom_1.0.5 picante_1.8.2\
[21] nlme_3.1-164 vegan_2.6-4 lattice_0.22-5 permute_0.9-7 tidybayes_3.0.6\
[26] ncdf4_1.22 fields_15.2 viridisLite_0.4.2 spam_2.10-0 brms_2.21.0\
[31] Rcpp_1.0.12 Hmisc_5.1-2 ape_5.8 fishtree_0.3.4 rfishbase_4.1.2\
[36] lubridate_1.9.3 forcats_1.0.0 stringr_1.5.1 dplyr_1.1.4 purrr_1.0.2\
[41] tidyr_1.3.1 tibble_3.2.1 ggplot2_3.5.0 tidyverse_2.0.0 plyr_1.8.9\
[46] readr_2.1.5

loaded via a namespace (and not attached): [1] svUnit_1.0.6 splines_4.3.3 later_1.3.2 rpart_4.1.23\
[5] lifecycle_1.0.4 StanHeaders_2.32.6 MASS_7.3-60.0.1 insight_0.19.10\
[9] ggdist_3.3.2 backports_1.4.1 magrittr_2.0.3 rmarkdown_2.26\
[13] remotes_2.5.0 httpuv_1.6.15 zip_2.3.1 sessioninfo_1.2.2\
[17] pkgbuild_1.4.4 DBI_1.2.2 minqa_1.2.6 multcomp_1.4-25\
[21] maps_3.4.2 abind_1.4-5 pkgload_1.3.4 yulab.utils_0.1.4\
[25] nnet_7.3-19 TH.data_1.1-2 tensorA_0.36.2.1 sandwich_3.1-0\
[29] inline_0.3.19 performance_0.11.0 bridgesampling_1.1-2 codetools_0.2-19\
[33] tidyselect_1.2.1 bayesplot_1.11.1 ggeffects_1.5.2 matrixStats_1.3.0\
[37] stats4_4.3.3 base64enc_0.1-3 jsonlite_1.8.8 ellipsis_0.3.2\
[41] Formula_1.2-5 survival_3.5-8 emmeans_1.10.1 tools_4.3.3\
[45] progress_1.2.3 glue_1.7.0 gridExtra_2.3 xfun_0.43\
[49] mgcv_1.9-1 distributional_0.4.0 loo_2.7.0 withr_3.0.0\
[53] fastmap_1.1.1 boot_1.3-29 fansi_1.0.6 digest_0.6.35\
[57] gridGraphics_0.5-1 timechange_0.3.0 R6_2.5.1 mime_0.12\
[61] estimability_1.5 colorspace_2.1-0 utf8_1.2.4 generics_0.1.3\
[65] data.table_1.15.4 prettyunits_1.2.0 htmlwidgets_1.6.4 pkgconfig_2.0.3\
[69] gtable_0.3.4 htmltools_0.5.8.1 profvis_0.3.8 dotCall64_1.1-1\
[73] posterior_1.5.0 snakecase_0.11.1 knitr_1.45 rstudioapi_0.16.0\
[77] tzdb_0.4.0 coda_0.19-4.1 checkmate_2.3.1 curl_5.2.1\
[81] nloptr_2.0.3 cachem_1.0.8 zoo_1.8-12 sjlabelled_1.2.0\
[85] miniUI_0.1.1.1 vipor_0.4.7 foreign_0.8-86 pillar_1.9.0\
[89] vctrs_0.6.5 urlchecker_1.0.1 promises_1.3.0 dbplyr_2.5.0\
[93] arrayhelpers_1.1-0 xtable_1.8-4 cluster_2.1.6 beeswarm_0.4.0\
[97] htmlTable_2.4.2 evaluate_0.23 mvtnorm_1.2-4 cli_3.6.2\
[101] compiler_4.3.3 rlang_1.1.3 crayon_1.5.2 rstantools_2.4.0\
[105] modelr_0.1.11 rematch2_2.1.2 sjmisc_2.8.9 fs_1.6.3\
[109] stringi_1.8.3 rstan_2.32.6 QuickJSR_1.1.3 munsell_0.5.1\
[113] bayestestR_0.13.2 Brobdingnag_1.2-9 V8_4.4.2 sjstats_0.18.2\
[117] hms_1.1.3 shiny_1.8.1.1 memoise_2.0.1 RcppParallel_5.1.7
