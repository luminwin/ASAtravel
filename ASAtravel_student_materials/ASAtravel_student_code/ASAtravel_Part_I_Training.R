###############################################################################
# PART I: TRAINING
# ASA Traveling Course: Tree-Based Machine Learning Methods
# Student R-code companion
#
# Run sections in slide order. Later examples can reuse earlier objects.
# The short names o, fit, and pred are reused for different analyses.
# Run installation commands separately, once, when a package is needed.
# Sampling and forest randomization mean numerical results may vary.
###############################################################################

# Required packages: randomForestSRC, survival.
# Additional examples use varPro and randomForestSRC.run.
# install.packages(c("randomForestSRC", "survival"))
library(randomForestSRC)
library(survival)


###############################################################################
# Slide 6: Brief Overview
# Topic: Workshop overview and random-forest ecosystem
###############################################################################

# Family-specific formula reference:
# rfsrc(Surv(time, status) ~ ., data = veteran)
# rfsrc(Surv(time, status) ~ ., data = wihs)
# rfsrc(Ozone ~ ., data = airquality)
# quantreg(mpg ~ ., data = mtcars)
# rfsrc(Species ~ ., data = iris)
# imbalanced(status ~ ., data = breast)
# rfsrc(Multivar(mpg, cyl) ~ ., data = mtcars)
# rfsrc(cbind(Species, Sepal.Length) ~ ., data = iris)
# quantreg(cbind(mpg, cyl) ~ ., data = mtcars)
# quantreg(cbind(Species, Sepal.Length) ~ ., data = iris)
# rfsrc(data = mtcars)
# sidClustering(data = mtcars)
# sidClustering(data = mtcars, method = "sh")


###############################################################################
# Slide 7: Quick Start: Iowa Housing
# Topic: Iowa housing quick start and forest output
###############################################################################

# Load the housing data and inspect its dimensions.
data(housing, package = "randomForestSRC")
print(dim(housing))


###############################################################################
# Slide 9: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Grow a regression forest to predict home sale price.
o <- rfsrc(SalePrice ~ ., data = housing)


###############################################################################
# Slide 10: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Inspect the forest settings and OOB performance.
print(o)


###############################################################################
# Slide 11: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Locate OOB R-squared and requested performance error in the summary.
print(o)


###############################################################################
# Slide 12: Quick Start: Iowa Housing
# Topic: Iowa housing quick start and forest output
###############################################################################

# Compare the original price scale with the logarithmic scale.
# Reload the data so rerunning this example does not take a second logarithm.
data(housing, package = "randomForestSRC")
o <- rfsrc(SalePrice ~ ., data = housing)
print(o)

housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice ~ ., data = housing)
print(o)


###############################################################################
# Slide 13: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Use log-price data for the remaining housing examples.
data(housing, package = "randomForestSRC")
housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice ~ ., data = housing)
print(o)

# Number of trees; interface reference:
# rfsrc(..., ntree = 500)


###############################################################################
# Slide 14: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Minimum terminal-node size; interface reference:
# rfsrc(..., nodesize = 5)


###############################################################################
# Slide 15: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Number of candidate variables at each split; interface reference:
# rfsrc(..., mtry = NULL)
# The regression default uses about one third of the predictor variables.


###############################################################################
# Slide 16: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Sampling without replacement; interface reference:
# rfsrc(..., samptype = "swor")


###############################################################################
# Slide 17: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Inspect the resampling method, resample size, analysis, and family labels.
print(o)


###############################################################################
# Slide 18: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Mean-squared-error splitting; interface reference:
# rfsrc(..., splitrule = "mse")


###############################################################################
# Slide 19: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Number of random candidate split points; interface reference:
# rfsrc(..., nsplit = 10)


###############################################################################
# Slide 20: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Demonstrate the prediction interface on the first ten housing records.
# These rows come from the training data; this is not a held-out assessment.
o.pred <- predict(o, newdata = housing[1:10, ])
print(head(o.pred$predicted))


###############################################################################
# Slide 22: Nonparametric regression
# Topic: Regression and quantile regression
###############################################################################

# Family-specific formula reference:
# rfsrc(Surv(time, status) ~ ., data = veteran)
# rfsrc(Surv(time, status) ~ ., data = wihs)
# rfsrc(Ozone ~ ., data = airquality)
# quantreg(mpg ~ ., data = mtcars)
# rfsrc(Species ~ ., data = iris)
# imbalanced(status ~ ., data = breast)
# rfsrc(Multivar(mpg, cyl) ~ ., data = mtcars)
# rfsrc(cbind(Species, Sepal.Length) ~ ., data = iris)
# quantreg(cbind(mpg, cyl) ~ ., data = mtcars)
# quantreg(cbind(Species, Sepal.Length) ~ ., data = iris)
# rfsrc(data = mtcars)
# sidClustering(data = mtcars)
# sidClustering(data = mtcars, method = "sh")


###############################################################################
# Slide 24: Regression example: Iowa housing
# Topic: Regression and quantile regression
###############################################################################

# Compare the three quantile-regression split rules on log-price data.
o <- quantreg(SalePrice ~ ., housing, splitrule = "mse", ntree = 250)
o <- quantreg(SalePrice ~ ., housing, splitrule = "quantile.regr", ntree = 250)
o <- quantreg(SalePrice ~ ., housing, splitrule = "la.quantile.regr", ntree = 250)

# Inspect and plot the final quantile forest.
print(o)
plot.quantreg(o)


###############################################################################
# Slide 26: Regression example: Iowa housing
# Topic: Regression and quantile regression
###############################################################################

# Install the integrated-analysis companion once, as needed.
# install.packages("devtools")
# devtools::install_github("kogalur/randomForestSRC.run")


###############################################################################
# Slide 27: Regression example: Iowa housing
# Topic: Regression and quantile regression
###############################################################################

# Run the integrated regression analysis and visualizations.
library(randomForestSRC.run)
run.rfsrc(SalePrice ~ ., housing, ntree = 500)


###############################################################################
# Slide 29: Classification
# Topic: Classification and glioma
###############################################################################

# Family-specific formula reference:
# rfsrc(Surv(time, status) ~ ., data = veteran)
# rfsrc(Surv(time, status) ~ ., data = wihs)
# rfsrc(Ozone ~ ., data = airquality)
# quantreg(mpg ~ ., data = mtcars)
# rfsrc(Species ~ ., data = iris)
# imbalanced(status ~ ., data = breast)
# rfsrc(Multivar(mpg, cyl) ~ ., data = mtcars)
# rfsrc(cbind(Species, Sepal.Length) ~ ., data = iris)
# quantreg(cbind(mpg, cyl) ~ ., data = mtcars)
# quantreg(cbind(Species, Sepal.Length) ~ ., data = iris)
# rfsrc(data = mtcars)
# sidClustering(data = mtcars)
# sidClustering(data = mtcars, method = "sh")


###############################################################################
# Slide 30: Classification example: Glioma
# Topic: Classification and glioma
###############################################################################

# Install varPro once, as needed, using the workshop's GitHub installation.
# install.packages("devtools")
# devtools::install_github("kogalur/varPro")
library(varPro)

# Load the multiclass glioma data.
data(glioma, package = "varPro")
print(dim(glioma))


###############################################################################
# Slide 31: Classification example: Glioma
# Topic: Classification and glioma
###############################################################################

# A factor response selects classification; inspect the OOB confusion matrix.
o <- rfsrc(y ~ ., data = glioma)
print(o)


###############################################################################
# Slide 32: Using run.rfsrc for an integrated analysis
# Topic: Classification and glioma
###############################################################################

# Run the integrated multiclass analysis and visualizations.
run.rfsrc(y ~ ., data = glioma)


###############################################################################
# Slide 34: Survival
# Topic: Survival and PBC
###############################################################################

# Family-specific formula reference:
# rfsrc(Surv(time, status) ~ ., data = veteran)
# rfsrc(Surv(time, status) ~ ., data = wihs)
# rfsrc(Ozone ~ ., data = airquality)
# quantreg(mpg ~ ., data = mtcars)
# rfsrc(Species ~ ., data = iris)
# imbalanced(status ~ ., data = breast)
# rfsrc(Multivar(mpg, cyl) ~ ., data = mtcars)
# rfsrc(cbind(Species, Sepal.Length) ~ ., data = iris)
# quantreg(cbind(mpg, cyl) ~ ., data = mtcars)
# quantreg(cbind(Species, Sepal.Length) ~ ., data = iris)
# rfsrc(data = mtcars)
# sidClustering(data = mtcars)
# sidClustering(data = mtcars, method = "sh")


###############################################################################
# Slide 35: Survival example: PBC Mayo Clinic
# Topic: Survival and PBC
###############################################################################

# Load the survival-package version of PBC, which uses the variable time.
data(pbc, package = "survival")
print(dim(pbc))


###############################################################################
# Slide 36: Survival example: PBC Mayo Clinic
# Topic: Survival and PBC
###############################################################################

# Remove the identifier and retain the original endpoint codes.
pbc$id <- NULL
# status: 0 = censored, 1 = transplant, 2 = death.
pbc.cr <- pbc

# Collapse positive endpoint codes to a single event indicator.
pbc$status[pbc$status > 0] <- 1
o <- rfsrc(Surv(time, status) ~ ., data = pbc)
print(o)


###############################################################################
# Slide 37: Using run.rfsrc for an integrated analysis
# Topic: Survival and PBC
###############################################################################

# Run the integrated survival analysis and visualizations.
run.rfsrc(Surv(time, status) ~ ., data = pbc)
