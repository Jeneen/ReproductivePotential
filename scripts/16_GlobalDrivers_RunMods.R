#set cores
options(mc.cores = parallel::detectCores())

##################################################################
##                  Biomass > 20cm                             ##
##################################################################
#data
alldata <- readRDS("output/alldata_SDandCIof1000_clean_cinner2020.rda")
alldata$LogBiomass_above20cm=log(alldata$Biomass_above20cm+1)


#default priors (intercept prior = median of the response from the data)
# b is flat prior
priors <- prior(student_t(3, 5.6, 2.5), class = "Intercept") + 
  prior(student_t(3, 0, 2.5), class = "sd") 

set.seed(1)
B20_mod =brm(LogBiomass_above20cm~
                        DepthCategory+CleanHabitat+Protection+CensusMethod+sTotal_sampling_area+sgrav_tot2+
                        sRegional_population_growth+sOcean_prod+sClimate_stress+
                        sLarger_pop_size+sReef_fish_landings_per_km2+
                        (1|Larger/ReefCluster),
                      data=alldata,family=gaussian,prior = priors,
                      iter=10000,  warmup=9000,
                      chains=4) 
saveRDS(fec_mod_se, "output/brms_20cmBiomass.rds")

##################################################################
##                  Fecundity                                  ##
##################################################################
#measurement error model
#https://bookdown.org/content/3890/missing-data-and-other-opportunities.html
set.seed(1)
fec_mod_se =brm(LogFecundityMean | se(LogFecunditySD, sigma = TRUE)~
                  DepthCategory+CleanHabitat+Protection+CensusMethod+
                  sTotal_sampling_area+sgrav_tot2+
                  sRegional_population_growth+sOcean_prod+sClimate_stress+
                  sLarger_pop_size+sReef_fish_landings_per_km2+
                  (1|Larger/ReefCluster),
                data=alldata,family=gaussian(),
                iter=10000,  warmup=9000,
                chains=4) 

saveRDS(fec_mod_se, "output/brms_fecundity_se.rds")


#check model fit
summary(fec_mod_se)
plot(fec_mod_se)
pp_check(fec_mod_se)
pp_check(fec_mod_se, type = "scatter_avg")



##################################################################
##                  Mature female biomass                       ##
##################################################################
#default brms priors
priors <-  prior(student_t(3, 5.2, 2.5), class = "Intercept") +  
  prior(student_t(3, 0, 2.5), class = "sd")
set.seed(1)
matf_mod_se =brm(LogBiomassKGMean | se(LogBiomassKGSD, sigma = TRUE)~
                  DepthCategory+CleanHabitat+Protection+CensusMethod+
                  sTotal_sampling_area+sgrav_tot2+
                  sRegional_population_growth+sOcean_prod+sClimate_stress+
                  sLarger_pop_size+sReef_fish_landings_per_km2+
                  (1|Larger/ReefCluster),
                data=alldata,family=gaussian(),prior = priors,
                iter=10000,  warmup=9000,
                chains=4) 
saveRDS(matf_mod_se, "output/brms_matf_se.rds")


#check model fit
summary(matf_mod_se)
plot(matf_mod_se)
pp_check(matf_mod_se)
pp_check(matf_mod_se, type = "scatter_avg")


##################################################################
##                          Serranidae                          ##
##################################################################
alldata <- readRDS("output/SERRANIDAE_alldata_clean_cinner2020.rda")

#can't have measurement error included in hurdle lognormal
#original without ME
set.seed(1)
fec_model_ser = brm(FecundityMean ~
                          DepthCategory+CleanHabitat+Protection+CensusMethod+sTotal_sampling_area+sgrav_tot2+
                          sRegional_population_growth+sOcean_prod+sClimate_stress+
                          sLarger_pop_size+sReef_fish_landings_per_km2+
                          (1|Larger/ReefCluster), 
                        data=alldata, 
                        family=hurdle_lognormal(link = "identity", link_sigma = "log",
                                                             link_hu = "logit"),
                        iter=10000,  warmup=9000,chains=4) 

summary(fec_model_ser)
pp_check(fec_model_ser, type = "scatter_avg")
pred <- posterior_predict(fec_model_ser)
bayesplot::ppc_dens_overlay(y = log1p(fec_model_ser$data$FecundityMean), 
                            yrep = log1p(pred[1:10,]))
saveRDS(fec_model_ser, "output/SERRANIDAE_brms_fecundity2.rds")



#split hurdle model
# Create a binary variable: 1 if FecundityMean > 0, 0 otherwise
alldata$FecundityBinary <- as.numeric(alldata$FecundityMean > 0)

# Fit the logistic regression model
set.seed(1)
hurdle_model <- brm(
  FecundityBinary ~ DepthCategory + CleanHabitat + Protection + CensusMethod +
    sTotal_sampling_area + sgrav_tot2 +
    sRegional_population_growth + sOcean_prod + sClimate_stress +
    sLarger_pop_size + sReef_fish_landings_per_km2 +
    (1 | Larger/ReefCluster),
  data = alldata,
  family = bernoulli(link = "logit"),
  iter = 10000, warmup = 9000, chains = 4
)
summary(hurdle_model)
plot(hurdle_model)
pp_check(hurdle_model)

saveRDS(hurdle_model, "output/SERRANIDAE_brms_fecundity_zeros_hurdle.rds")


# Subset data to include only positive FecundityMean
positive_data <- subset(alldata, FecundityMean > 0)

# Fit the normal model
#default brms priors
priors <-  prior(student_t(3, 18.4, 2.5), class = "Intercept") + 
  prior(student_t(3, 0, 2.5), class = "sd")
set.seed(1)
normal_model <- brm(
  LogFecundityMean | se(LogFecunditySD, sigma = TRUE)~ DepthCategory + CleanHabitat + Protection + CensusMethod +
    sTotal_sampling_area + sgrav_tot2 +
    sRegional_population_growth + sOcean_prod + sClimate_stress +
    sLarger_pop_size + sReef_fish_landings_per_km2 +
    (1 | Larger/ReefCluster),
  data = positive_data,prior = priors,
  family=gaussian(),
  iter = 10000, warmup = 9000, chains = 4
)
summary(normal_model)
pp_check(normal_model) #Small peak around log6 that isnt captured
pp_check(normal_model, type = "scatter_avg")


#final model = removed sites with 0
saveRDS(normal_model, "output/SERRANIDAE_brms_fecundity.rds")



##################################################################
##                          Scaridae                            ##
##################################################################
#data
alldata <- readRDS("output/SCARIDAE_alldata_clean_cinner2020.rda")

# Subset data to include only positive FecundityMean
positive_data <- subset(alldata, FecundityMean > 0)

#hurdle log-normal
set.seed(1)
scaridae_hurdlelog = brm(FecundityMean~
                          DepthCategory+CleanHabitat+Protection+CensusMethod+sTotal_sampling_area+sgrav_tot2+
                          sRegional_population_growth+sOcean_prod+sClimate_stress+
                          sLarger_pop_size+sReef_fish_landings_per_km2+
                          (1|Larger/ReefCluster),
                        data=alldata,family=hurdle_lognormal(link = "identity", link_sigma = "log",
                                                             link_hu = "logit"),
                        iter=10000,  warmup=9000,
                        chains=4) 
summary(scaridae_hurdlelog)
pp_check(scaridae_hurdlelog, type = "scatter_avg")
pp_check(scaridae_hurdlelog)
pred <- posterior_predict(scaridae_hurdlelog)
bayesplot::ppc_dens_overlay(y = log1p(scaridae_hurdlelog$data$FecundityMean), 
                            yrep = log1p(pred[1:10,]))
saveRDS(scaridae_hurdlelog, 
        "output/SCARIDAE_brms_fecundity_hurdlelog.rds")


#no zeros model
#default brms priors
priors <-  prior(student_t(3, 17.5, 2.5), class = "Intercept") + 
  prior(student_t(3, 0, 2.5), class = "sd")
set.seed(1)
scaridae_model <- brm(
  LogFecundityMean | se(LogFecunditySD, sigma = TRUE)~ DepthCategory + CleanHabitat + Protection + CensusMethod +
    sTotal_sampling_area + sgrav_tot2 +
    sRegional_population_growth + sOcean_prod + sClimate_stress +
    sLarger_pop_size + sReef_fish_landings_per_km2 +
    (1 | Larger/ReefCluster),
  data = positive_data, prior = priors,
  family=gaussian(),
  iter = 10000, warmup = 9000, chains = 4
)

summary(scaridae_model)
plot(scaridae_model)
pp_check(scaridae_model)
pp_check(scaridae_model, type = "scatter_avg")


#final model = removed sites with 0
saveRDS(scaridae_model, "output/SCARIDAE_brms_fecundity.rds")


##################################################################
##                          Lutjanidae                          ##
##################################################################

#data
alldata <- readRDS("output/LUTJANIDAE_alldata_clean_cinner2020.rda")

# Subset data to include only positive FecundityMean
positive_data <- subset(alldata, FecundityMean > 0)

#hurdle log-normal
set.seed(1)
lutjanidae_hurdlelog = brm(FecundityMean~
                           DepthCategory+CleanHabitat+Protection+CensusMethod+sTotal_sampling_area+sgrav_tot2+
                           sRegional_population_growth+sOcean_prod+sClimate_stress+
                           sLarger_pop_size+sReef_fish_landings_per_km2+
                           (1|Larger/ReefCluster),
                         data=alldata,family=hurdle_lognormal(link = "identity", link_sigma = "log",
                                                              link_hu = "logit"),
                         iter=10000,  warmup=9000,
                         chains=4) 
summary(lutjanidae_hurdlelog)
pp_check(lutjanidae_hurdlelog, type = "scatter_avg")
pp_check(lutjanidae_hurdlelog)
pred <- posterior_predict(lutjanidae_hurdlelog)
bayesplot::ppc_dens_overlay(y = log1p(lutjanidae_hurdlelog$data$FecundityMean), 
                            yrep = log1p(pred[1:10,]))
saveRDS(lutjanidae_hurdlelog, 
        "output/LUTJANIDAE_brms_fecundity_hurdlelog.rds")


#no zeros model
#default brms priors
priors <-  prior(student_t(3, 16.2, 2.5), class = "Intercept") + 
  prior(student_t(3, 0, 2.5), class = "sd")
set.seed(1)
lutjanidae_model <- brm(
  LogFecundityMean | se(LogFecunditySD, sigma = TRUE)~ DepthCategory + CleanHabitat + Protection + CensusMethod +
    sTotal_sampling_area + sgrav_tot2 +
    sRegional_population_growth + sOcean_prod + sClimate_stress +
    sLarger_pop_size + sReef_fish_landings_per_km2 +
    (1 | Larger/ReefCluster),
  data = positive_data, prior = priors,
  family=gaussian(),
  iter = 10000, warmup = 9000, chains = 4
)

summary(lutjanidae_model)
plot(lutjanidae_model)
pp_check(lutjanidae_model)
pp_check(lutjanidae_model, type = "scatter_avg")


#final model = removed sites with 0
saveRDS(lutjanidae_model, "output/LUTJANIDAE_brms_fecundity.rds")



