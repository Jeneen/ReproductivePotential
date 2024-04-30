# Function to clear environment at the end of script but keep functions (large amount of memory needed)
clear_environment_keep_functions <- function() {
  lst <- ls()
  for (item in lst) {
    if (!is.function(get(item))) {
      rm(list=item, envir = globalenv())
    }
  }
}

# List of scripts to run in order
scripts <- c(
  "scripts/00_functions.R", # loads packages and functions
  "scripts/01_GetSSTSites.R", # gets sst of sites for length at maturity temperature model
  "scripts/02_CreateTempDFtoPredict.R", # creates a dataframe of temp-species to extrapolate
  "scripts/03_AddMissingSpp.R", # adds missing species
  "scripts/04_SppTempMod.R", # runs lm ~ temperature model
  "scripts/05_ExtrapSppTemp.R", # extrapolates lm ~ temperature model
  "scripts/06_SexRatioMod.R", 
  "scripts/07_ExtrapSexRatio.R",
  "scripts/08_BarnecheFecMod.R",
  "scripts/09_PrepMatFdf.R",
  "scripts/10_ExtrapFecund.R",
  "scripts/11_SampleBySexRatio.R",
  "scripts/12_MatFSubsetFamilies.R",
  "scripts/13_GlobalDrivers_CleanDFs.R",
  "scripts/14_CheckCovariates.R",
  "scripts/15_FecBiomPowerMod.R",
  "scripts/16_GlobalDrivers_RunMods.R",
  "scripts/17_Sim30x30_AllFam.R",
  "scripts/18_Sim30x30_Serranidae.R",
  "scripts/19_Fig_MargFecMap.R",
  "scripts/20_Fig_LinearMod.R",
  "scripts/21_Fig_FecDistrib.R",
  "scripts/22_Fig_Grid.R",
  "scripts/23_Fig_CoefPlot.R",
  "scripts/24_Fig_MargRatios.R",
  "scripts/25_Fig_30x30.R"
  
)

# Execute each script and clear environment (keep functions)
for (script in scripts) {
  cat("Running script:", script, "\n")
  source(script)
  clear_environment_keep_functions()
}
