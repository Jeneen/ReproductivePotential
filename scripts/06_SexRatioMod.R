##########          Run on Lancaster University HPC        ########## 

#load data for all non gonochoristic spp
sex_ratio  <-  read.csv("data/sex_ratio_lit_protog.csv")
grafted_tree = ape::read.tree("data/grafted_tree.tre")

#clean tree
tree_vcv <- ape::vcv(grafted_tree, corr = TRUE)

#get tips
tip <- as.data.frame(grafted_tree$tip.label)


#standardise spp names
sex_ratio$species_tree <- gsub(" ", "_", sex_ratio$Species)


#match spp to tree
sex_ratio <- filter(sex_ratio, species_tree %in% grafted_tree$tip.label)


###################
#model
set.seed(1)
priors <- prior(normal(0, 0.9), class = "Intercept") + 
  prior(gamma(2, 0.1), class = "sd")+
  prior(gamma(0.01, 0.01), class = "phi") 

# check_priors <- brms::brm(RatioProportions ~ (1 | Species), 
#                            data = sex_ratio, family = Beta(link = "logit"),
#                            chains = 2, cores = 1, iter=1000, warmup=500,  
#                            prior = priors,
#                            sample_prior = TRUE,
#                            control = list(adapt_delta = 0.999, 
#                                           max_treedepth = 20))
# prior_predictions <- prior_draws(check_priors, "Intercept")


sex_phy_model <- brms::brm(RatioProportions ~ 
                             (1 | gr(species_tree, cov = tree_vcv)) +  (1 | Species), 
                           data = sex_ratio, family = Beta(link = "logit"),
                           data2 = list(tree_vcv = tree_vcv), prior = priors,
                           chains = 4, cores = 1, iter=10000, warmup=9000,  
                           control = list(adapt_delta = 0.999,
                                          max_treedepth = 20))

#save
saveRDS(sex_phy_model, file = "output/sex_phy_model_noprotog.rds")

#checks
plot_sex_phy_model <- plot(sex_phy_model)
pp_sex_model <- pp_check(sex_phy_model, nsamples = 100)
r2_sex_model <- bayes_R2(sex_phy_model)

#save
saveRDS(plot_sex_phy_model, file = "output/plot_sex_model.rds")
saveRDS(pp_sex_model, file = "output/pp_sex_model.rds")
saveRDS(r2_sex_model, file = "output/r2_sex_model.rds")



















