#model checks 

# List of model file paths
model_paths <- c("output/lmat_model_out.rds", "output/sex_phy_model_noprotog.rds",
                 "output/fecundity_model.rds", "output/site_fec_biomass_se.rds",
                 "output/brms_20cmBiomass.rds", "output/brms_fecundity_se.rds",
                 "output/brms_matf_se.rds", "output/SERRANIDAE_brms_fecundity_hurdlelog.rds",
                 "output/SERRANIDAE_brms_fecundity_zeros_hurdle.rds",
                 "output/SERRANIDAE_brms_fecundity.rds", "output/SCARIDAE_brms_fecundity_hurdlelog.rds",
                 "output/SCARIDAE_brms_fecundity.rds", "output/LUTJANIDAE_brms_fecundity_hurdlelog.rds",
                 "output/LUTJANIDAE_brms_fecundity.rds")
tab_df(meds_summary_count, title = "Supplementary Table 1. Median marginal fecundity (log + 1) by marine ecoregion and protection",
       file="output/supp_median_fecundityByGB&Protection_summary.doc") 
sink("summary.txt")
summary(model)
sink()

model_paths <- c("output/brms_20cmBiomass.rds", "output/brms_fecundity_se.rds")

#function
load_and_prepare_plots <- function(model_path, plot_title) {
  # Load model
  model <- readRDS(model_path)
  
  # Diagnostic plot (as ggplot)
  model_traceplot <- bayesplot::mcmc_trace(model, facet_args = list(ncol = 3),
                                           pars = vars(b_Intercept:sigma)) + 
    ggtitle(paste("Trace Plot -", plot_title))+
    theme(plot.title = element_text(hjust = 0.5, vjust = -0.5))
  
  # Posterior predictive checks 
  model_ppcheck <- pp_check(model, ndraws = 10) + ggtitle(paste("PP Check -", plot_title))+
    theme(plot.title = element_text(hjust = 0.5, vjust = -0.5))
  
  # Combine plots for the model
  combined_plots <- cowplot::plot_grid(model_traceplot, model_ppcheck, ncol = 1, labels = "AUTO")
  
  return(combined_plots)}

# save as pdf
pdf("output/model_checks_combined.pdf", width = 15, height = 15)

# Apply function to each model and generate plots
invisible(lapply(model_paths, function(path) {
  file_name <- tools::file_path_sans_ext(basename(path))
  plot_title <- gsub("_", " ", file_name)
  plot <- load_and_prepare_plots(path, plot_title)
  print(plot)
}))

# close pdf
dev.off()

#save summary data

#summary data function
load_and_get_summary_sjplot <- function(model_path) {
  model <- readRDS(model_path)
  # Use sjPlot to create a summary table
  tab_model <- tab_model(model)
  return(tab_model)
}


# Create a new Word document
doc <- read_docx()

# Process each model, create a summary table and add it to the Word document
for (path in model_paths) {
  # Generate summary using sjPlot
  tab <- load_and_get_summary_sjplot(path)
  
  # Add a section header with the model name or description
  doc <- doc %>% 
    body_add_par(text = gsub("output/", "", tools::file_path_sans_ext(basename(path))), style = "heading 1") 
  
  # Since sjPlot generates HTML tables, we need to convert them to a format that can be inserted into a Word doc
  # Save the HTML content to a temporary file
  html_file <- tempfile(fileext = ".html")
  writeLines(as.character(tab), html_file)
  
  text_content <- markdown::markdownToHTML(html_file)
  
  doc <- doc %>%
    body_add_par(text = readLines(text_content), style = "Normal")
}

# Save the Word document
print(doc, target = "output/model_summaries.docx")
