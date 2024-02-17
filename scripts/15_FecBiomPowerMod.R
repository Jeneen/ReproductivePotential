#data
alldata <- readRDS("output/alldata_SDandCIof1000_clean_cinner2020.rda")

# Add placeholder for very small biomass SD
alldata$LogBiomassKGSD <- ifelse(alldata$LogBiomassKGSD <= 0, .Machine$double.eps, alldata$LogBiomassKGSD)


#run measurement error model with default priors
set.seed(1)
fec_biom_se <- brm(LogFecundityMean | se(LogFecunditySD, sigma = TRUE) ~ 1 + 
                     (1|Larger/ReefCluster) +
                     LogBiomassKGMean, 
                   data=alldata,family=gaussian(),
                   iter=10000,  warmup=9000, 
                   chains=4) 

#check
summary(fit)
summary(fec_biom_se)
pp_check(fec_biom)
mcmc_plot(fec_biom_se)

#store model checks
pp_scat <- pp_check(fec_biom_se, type = "scatter_avg", ndraws = 100)
pp_dens <- pp_check(fec_biom_se, ndraws = 100)


#Final mod save
saveRDS(fec_biom_se, file="output/site_fec_biomass_se.rds")
