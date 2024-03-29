##########          Run on Lancaster University HPC        ########## 

rstan::rstan_options(auto_write = TRUE)

#Import data
grafted_tree = ape::read.tree("data/grafted_tree.tre")
final <- readRDS(file = "data/processed/final_lmat_data.rds")

#clean data
final$species_tree <- gsub(" ", "_", final$Species)
tree_vcv <- ape::vcv(grafted_tree, corr = TRUE)

#center temperature to mean zero
final$temp_scaled <- scale(final$temp)[,1]

#run model
set.seed(1)
lm_phy_model <- brm(
  logLm ~ 
    temp_scaled +
    (1 | gr(species_tree, cov = tree_vcv)) + (1 + temp_scaled | Species), 
  data = final, family = gaussian(),
  data2 = list(tree_vcv = tree_vcv), 
  prior = 
        c(prior(normal(0, 1), class = "b") +
          prior(normal(2.92, 2.16), class = "Intercept") +   ##taken from mean/sd of fishlife lm values for serf spp
          prior(gamma(2, 0.1), class = "sd") +
          prior(gamma(2, 0.1), class = "sigma")),
  chains = 4, 
  cores = 1, iter=10000, warmup=9000,  
  control = list(adapt_delta = 0.999,
                 max_treedepth = 20))

#save output
saveRDS(lm_temp_model, file = "output/update_lmat_model_out.rds")
