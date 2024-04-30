Data and code required to reproduce analyses for the manuscript:

**Global patterns and drivers of fish reproductive potential on coral reefs**

*Jeneen Hadj-Hammou, Joshua E. Cinner, Diego R. Barneche, Iain R. Caldwell, David Mouillot, James P.W. Robinson, Nina M.D. Schiettekatte, Alexandre C. Siqueira, Brett M. Taylor, Nicholas A.J. Graham*

Fish fecundity scales hyperallometrically with body mass, meaning larger females produce disproportionately more eggs than smaller ones. We explore this relationship beyond the species-level to estimate the “reproductive potential” of 1,632 coral reef sites distributed globally. We find that, at the site-level, reproductive potential scales hyperallometrically with assemblage biomass, but with a median exponent of 1.08, rather than the averaged species exponent of 1.19. For the family Serranidae, modelled reproductive potential was 656% higher in fully protected sites versus fished sites, while across all families, this difference was 209%. When comparing a scenario where 30% of sites were randomly fully protected to a current protection scenario, we estimate an increase of up to 155% in reproductive potential for Serranidae, and 31% across families. Such results point to the possible ecological benefits of the 30x30 global conservation target and showcase management options to promote the sustainability of population replenishment.

------------------------------------------------------------------------

To reproduce the main analyses, run the R scripts:

[install.R](https://github.com/Jeneen/ReproductivePotential/blob/main/scripts/install.R)

[run_main_analysis.R](https://github.com/Jeneen/ReproductivePotential/blob/main/scripts/run_main_analysis.R)

However, please note that the following scripts may need to be run on an HPC:

[04_SppTempMod.R](https://github.com/Jeneen/ReproductivePotential/blob/main/scripts/04_SppTempMod.R){.uri}

[06_SexRatioMod.R](https://github.com/Jeneen/ReproductivePotential/blob/main/scripts/06_SexRatioMod.R){.uri}

[08_BarnecheFecMod.R](https://github.com/Jeneen/ReproductivePotential/blob/main/scripts/08_BarnecheFecMod.R){.uri}

------------------------------------------------------------------------

sessionInfo()

R version 4.3.3 (2024-02-29) Platform: aarch64-apple-darwin20 (64-bit) Running under: macOS Sonoma 14.4.1

Matrix products: default BLAS: /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib LAPACK: /Library/Frameworks/R.framework/Versions/4.3-arm64/Resources/lib/libRlapack.dylib; LAPACK version 3.11.0

locale: [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

time zone: Europe/London tzcode source: internal

attached base packages: [1] grid parallel stats graphics grDevices utils datasets methods base

other attached packages: [1] openxlsx_4.2.5.2 rgeos_0.6-4 fishflux_0.0.1.6 ggplotify_0.1.2 sjPlot_2.8.15\
[6] janitor_2.2.0 reshape2_1.4.4 devtools_2.4.5 usethis_2.2.3 cowplot_1.1.3\
[11] patchwork_1.2.0 scales_1.3.0 paletteer_1.6.0 lme4_1.1-35.2 Matrix_1.6-5\
[16] ggbeeswarm_0.7.2 ggrepel_0.9.5 RColorBrewer_1.1-3 viridis_0.6.5 sp_2.1-3\
[21] broom_1.0.5 picante_1.8.2 nlme_3.1-164 vegan_2.6-4 lattice_0.22-5\
[26] permute_0.9-7 tidybayes_3.0.6 ncdf4_1.22 fields_15.2 viridisLite_0.4.2 [31] spam_2.10-0 brms_2.21.0 Rcpp_1.0.12 Hmisc_5.1-2 ape_5.8\
[36] fishtree_0.3.4 rfishbase_4.1.2 lubridate_1.9.3 forcats_1.0.0 stringr_1.5.1\
[41] dplyr_1.1.4 purrr_1.0.2 readr_2.1.5 tidyr_1.3.1 tibble_3.2.1\
[46] ggplot2_3.5.0 tidyverse_2.0.0 plyr_1.8.9
