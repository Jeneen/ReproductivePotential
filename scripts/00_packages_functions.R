# List of packages to install and load
packages <- unique(c("plyr", "tidyverse", "rfishbase", "fishtree", "fishflux", "ape", "Hmisc", "brms", 
                     "dplyr", "rgeos", "fields", "ncdf4", "tidybayes", "picante", "parallel", 
                     "treeio", "broom", "sp", "purrr", "viridis", "RColorBrewer", "ggrepel", 
                     "stringr", "janitor", "ggbeeswarm", "lme4", "paletteer", "scales", "patchwork", 
                     "grid", "cowplot"))

# Function to check if package is installed, install it if not, then load it
install_and_load <- function(package) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    library(package, character.only = TRUE)
  }
}

# Apply the function over the list of packages
invisible(sapply(packages, install_and_load))

# Generic functions
'%!in%' <- function(x,y)!('%in%'(x,y))

vif.mer = function (fit) {
  ## adapted from rms::vif
  v <-vcov(fit)
  nam = names(fixef(fit))
  ## exclude intercepts
  ns = sum(1 * (nam == "Intercept" | nam == "(Intercept)"))
  if (ns > 0) {
    v = v[-(1:ns), -(1:ns), drop = FALSE]
    nam = nam[-(1:ns)]
  }
  d = diag(v)^0.5
  v = diag(solve(v/(d %o% d)))
  names(v) = nam
  v
}
