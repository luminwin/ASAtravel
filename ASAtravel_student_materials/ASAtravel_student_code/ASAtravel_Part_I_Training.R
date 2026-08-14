###############################################################################
# ASA Traveling Course: Tree-Based Machine Learning Methods
# Part I: Training
#
# Student R-code companion
# Code is organized in slide order for use during and after the workshop.
# Required packages and data are identified near their first use.
#
# Console output has been removed. Display-only syntax and incomplete calls
# are retained as comments. Run examples in slide order; the presentations
# intentionally reuse short object names such as o, fit, and pred.
###############################################################################

# Core package used throughout this module.
library(randomForestSRC)
library(survival)


###############################################################################
# Slide 6: Brief Overview
# Topic: Workshop overview and random-forest ecosystem
###############################################################################

# Syntax shown on the slide: rfsrc(Surv(time, status)~., data = veteran)
# Syntax shown on the slide: rfsrc(Surv(time, status)~., data = wihs)
# Syntax shown on the slide: rfsrc(Ozone~., data = airquality)
# Syntax shown on the slide: quantreg(mpg~., data = mtcars)
# Syntax shown on the slide: rfsrc(Species~., data = iris)
# Syntax shown on the slide: imbalanced(status~., data = breast)
# Syntax shown on the slide: rfsrc(Multivar(mpg, cyl)~., data = mtcars)
# Syntax shown on the slide: rfsrc(cbind(Species,Sepal.Length)~.,data=iris)
# Syntax shown on the slide: quantreg(cbind(mpg, cyl)~., data = mtcars)
# Syntax shown on the slide: quantreg(cbind(Species,Sepal.Length)~.,data=iris)
# Syntax shown on the slide: rfsrc(data = mtcars)
# Syntax shown on the slide: sidClustering(data = mtcars)
# Syntax shown on the slide: sidClustering(data = mtcars, method = "sh")


###############################################################################
# Slide 7: Quick Start: Iowa Housing
# Topic: Iowa housing quick start and forest output
###############################################################################

data(housing, package = "randomForestSRC")
dim(housing)


###############################################################################
# Slide 9: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

library(randomForestSRC)
o <- rfsrc(SalePrice ~ ., data = housing)


###############################################################################
# Slide 10: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

library(randomForestSRC)
o <- rfsrc(SalePrice ~ ., data = housing)
print(o)


###############################################################################
# Slide 11: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# This slide isolates the OOB R-squared and performance-error lines from
# the forest summary produced on Slide 10.
print(o)


###############################################################################
# Slide 12: Quick Start: Iowa Housing
# Topic: Iowa housing quick start and forest output
###############################################################################

# Code example 1
o <- rfsrc(SalePrice ~ ., data = housing)
o

# Code example 2
housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice ~ ., data = housing)
o


###############################################################################
# Slide 13: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Code example 1
data(housing, package = "randomForestSRC")
housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice ~ ., data = housing)
print(o)

# Code example 2
# Illustrative syntax shown on the slide: rfsrc(..., ntree = 500)


###############################################################################
# Slide 14: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Illustrative syntax shown on the slide: rfsrc(..., nodesize = 5)


###############################################################################
# Slide 15: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Illustrative syntax shown on the slide: rfsrc(..., mtry = NULL)


###############################################################################
# Slide 16: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Illustrative syntax shown on the slide: rfsrc(..., samptype = "swor")


###############################################################################
# Slide 17: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# The slide repeats the basic fit to emphasize the resampling method and
# resample size reported in the printed forest summary.
data(housing, package = "randomForestSRC")
housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice ~ ., data = housing)
print(o)


###############################################################################
# Slide 18: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Illustrative syntax shown on the slide: rfsrc(..., splitrule = "mse")


###############################################################################
# Slide 19: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Illustrative syntax shown on the slide: rfsrc(..., nsplit = 10)


###############################################################################
# Slide 20: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

o.pred <- predict(o, newdata = housing[c(1:10),])
head(o.pred$predicted)


###############################################################################
# Slide 22: General call to rfsrc.cart
# Topic: Iowa housing quick start and forest output
###############################################################################

# CART-style single-tree interface shown on the slide:
# rfsrc.cart(formula, data, ntree = 1, mtry = ncol(data),
#            bootstrap = "none", ...)


###############################################################################
# Slide 23: Nonparametric regression
# Topic: Regression and quantile regression
###############################################################################

# Syntax shown on the slide: rfsrc(Ozone~., data = airquality)
# Syntax shown on the slide: rfsrc(Species~., data = iris)
# Syntax shown on the slide: imbalanced(status~., data = breast)
# Syntax shown on the slide: rfsrc(Surv(time, status)~., data = veteran)
# Syntax shown on the slide: rfsrc(Surv(time, status)~., data = wihs)
# Syntax shown on the slide: rfsrc(Multivar(mpg, cyl)~., data = mtcars)
# Syntax shown on the slide: rfsrc(cbind(Species,Sepal.Length)~.,data=iris)
# Syntax shown on the slide: quantreg(cbind(mpg, cyl)~., data = mtcars)
# Syntax shown on the slide: quantreg(cbind(Species,Sepal.Length)~.,data=iris)
# Syntax shown on the slide: rfsrc(data = mtcars)
# Syntax shown on the slide: sidClustering(data = mtcars)
# Syntax shown on the slide: sidClustering(data = mtcars, method = "sh")


###############################################################################
# Slide 25: Regression example: Iowa housing
# Topic: Regression and quantile regression
###############################################################################

# Code example 1
o <- quantreg(SalePrice ~ ., housing, splitrule = "mse", ntree = 250)
o <- quantreg(SalePrice ~ ., housing, splitrule = "quantile.regr", ntree = 250)
o <- quantreg(SalePrice ~ ., housing, splitrule = "la.quantile.regr", ntree = 250) # (default)

# Code example 2
o

# Code example 3
plot.quantreg(o)


###############################################################################
# Slide 28: Regression example: Iowa housing
# Topic: Regression and quantile regression
###############################################################################

# Optional installation step (run once, not every session):
# install.packages("devtools")
# devtools::install_github("kogalur/randomForestSRC.run")


###############################################################################
# Slide 29: Regression example: Iowa housing
# Topic: Regression and quantile regression
###############################################################################

library(randomForestSRC.run)
run.rfsrc(SalePrice ~ ., housing, ntree = 500)


###############################################################################
# Slide 31: Classification
# Topic: Classification and glioma
###############################################################################

# Syntax shown on the slide: rfsrc(Ozone~., data = airquality)
# Syntax shown on the slide: quantreg(mpg~., data = mtcars)
# Syntax shown on the slide: imbalanced(status~., data = breast)
# Syntax shown on the slide: rfsrc(Surv(time, status)~., data = veteran)
# Syntax shown on the slide: rfsrc(Surv(time, status)~., data = wihs)
# Syntax shown on the slide: rfsrc(Multivar(mpg, cyl)~., data = mtcars)
# Syntax shown on the slide: rfsrc(cbind(Species,Sepal.Length)~.,data=iris)
# Syntax shown on the slide: quantreg(cbind(mpg, cyl)~., data = mtcars)
# Syntax shown on the slide: quantreg(cbind(Species,Sepal.Length)~.,data=iris)
# Syntax shown on the slide: rfsrc(data = mtcars)
# Syntax shown on the slide: sidClustering(data = mtcars)
# Syntax shown on the slide: sidClustering(data = mtcars, method = "sh")


###############################################################################
# Slide 32: Classification example: Glioma
# Topic: Classification and glioma
###############################################################################

# Optional installation step (run once):
# install.packages("varPro")
library(varPro)
data(glioma, package = "varPro")
dim(glioma)


###############################################################################
# Slide 33: Classification example: Glioma
# Topic: Classification and glioma
###############################################################################

o <- rfsrc(y ~ ., data = glioma)
o


###############################################################################
# Slide 35: Classification example: Glioma
# Topic: Classification and glioma
###############################################################################

o <- rfsrc(y ~ ., data = glioma,
           splitrule = "gini") ## default splitrule as in the previous slide
o


###############################################################################
# Slide 36: Classification example: Glioma
# Topic: Classification and glioma
###############################################################################

o <- rfsrc(y ~ ., data = glioma,
           splitrule = "auc")
o


###############################################################################
# Slide 37: Classification example: Glioma
# Topic: Classification and glioma
###############################################################################

o <- rfsrc(y ~ ., data = glioma,
           splitrule = "entropy")
o


###############################################################################
# Slide 38: Using run.rfsrc for an integrated analysis
# Topic: Classification and glioma
###############################################################################

run.rfsrc(y ~ ., data = glioma)


###############################################################################
# Slide 40: Survival
# Topic: Survival and PBC
###############################################################################

# Syntax shown on the slide: rfsrc(Ozone~., data = airquality)
# Syntax shown on the slide: quantreg(mpg~., data = mtcars)
# Syntax shown on the slide: rfsrc(Species~., data = iris)
# Syntax shown on the slide: imbalanced(status~., data = breast)
# Syntax shown on the slide: rfsrc(Surv(time, status)~., data = wihs)
# Syntax shown on the slide: rfsrc(Multivar(mpg, cyl)~., data = mtcars)
# Syntax shown on the slide: rfsrc(cbind(Species,Sepal.Length)~.,data=iris)
# Syntax shown on the slide: quantreg(cbind(mpg, cyl)~., data = mtcars)
# Syntax shown on the slide: quantreg(cbind(Species,Sepal.Length)~.,data=iris)
# Syntax shown on the slide: rfsrc(data = mtcars)
# Syntax shown on the slide: sidClustering(data = mtcars)
# Syntax shown on the slide: sidClustering(data = mtcars, method = "sh")


###############################################################################
# Slide 41: Survival example: PBC Mayo Clinic
# Topic: Survival and PBC
###############################################################################

data(pbc, package = "survival")
dim(pbc)


###############################################################################
# Slide 42: Survival example: PBC Mayo Clinic
# Topic: Survival and PBC
###############################################################################

pbc$id <- NULL ## remove the ID
## keep the original competing risk framework for later
## status at endpoint, 0/1/2 for censored, transplant, dead
pbc.cr <- pbc

## convert to right-censoring with death as the event
pbc$status[pbc$status > 0] <- 1
o <- rfsrc(Surv(time, status) ~ ., data = pbc)
o


###############################################################################
# Slide 44: Split rules
# Topic: Survival and PBC
###############################################################################

o <- rfsrc(Surv(time, status) ~ ., data = pbc,
                  splitrule = "logrank") ## default splitrule
o


###############################################################################
# Slide 45: Split rules
# Topic: Survival and PBC
###############################################################################

o <- rfsrc(Surv(time, status) ~ ., data = pbc,
                  splitrule = "bs.gradient")
o


###############################################################################
# Slide 46: Split rules
# Topic: Survival and PBC
###############################################################################

o <- rfsrc(Surv(time, status) ~ ., data = pbc,
                  splitrule = "logrankscore")
o


###############################################################################
# Slide 47: Using run.rfsrc for an integrated analysis
# Topic: Survival and PBC
###############################################################################

run.rfsrc(Surv(time, status) ~ ., data = pbc)
