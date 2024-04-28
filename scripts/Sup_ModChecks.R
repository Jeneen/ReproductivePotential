#model checks 

#function
load_and_check_model <- function(model_path) {
  # Load model
  model <- readRDS(model_path)
  
  # Generate summary
  model_summary <- summary(model)
  
  # Traceplot
  model_traceplot <- plot(model)
  
  # Posterior predictive checks
  model_ppcheck <- pp_check(model)
  
  # R^2
  model_r2 <- bayes_R2(model)
  
  # Compile checks into a list
  checks_list <- list(Traceplot = model_traceplot, PPCheck = model_ppcheck, R2 = model_r2)
  return(list(Summary = model_summary, Checks = checks_list))
}

# List of model file paths
model_paths <- c("output/lmat_model_out.rds", "output/sex_phy_model_noprotog.rds",
                 "output/fecundity_model.rds", "output/site_fec_biomass_se.rds",
                 "output/brms_20cmBiomass.rds", "output/brms_fecundity_se.rds",
                 "output/brms_matf_se.rds", "output/SERRANIDAE_brms_fecundity_hurdlelog.rds",
                 "output/SERRANIDAE_brms_fecundity_zeros_hurdle.rds",
                 "output/SERRANIDAE_brms_fecundity.rds", "output/SCARIDAE_brms_fecundity_hurdlelog.rds",
                 "output/SCARIDAE_brms_fecundity.rds", "output/LUTJANIDAE_brms_fecundity_hurdlelog.rds",
                 "output/LUTJANIDAE_brms_fecundity.rds")

# Apply function to each model and store results
model_results <- lapply(model_paths, load_and_check_model)

# Save
first_model_checks <- model_results[[1]]$Checks

#arrange 
combined_plots <- plot_grid(plotlist = list(first_model_checks$Traceplot, first_model_checks$PPCheck))

#create figure
ggsave("output/combined_model_checks.png", combined_plots, width = 10, height = 8)

