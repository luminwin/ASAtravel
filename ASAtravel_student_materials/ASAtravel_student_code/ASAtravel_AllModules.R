###############################################################################
# ASA Traveling Course: Tree-Based Machine Learning Methods
# Complete student R-code companion: Parts I-IV
#
# Run examples in module and slide order, or use the separate module files.
# The code index gives line ranges in both this file and each module file.
###############################################################################



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


###############################################################################
# PART II: INFERENCE AND PREDICTION
# ASA Traveling Course: Tree-Based Machine Learning Methods
# Student R-code companion
#
# Run sections in slide order. Later examples can reuse earlier objects.
# The short names o, fit, and pred are reused for different analyses.
# Run installation commands separately, once, when a package is needed.
# Sampling and forest randomization mean numerical results may vary.
###############################################################################

# Required packages: randomForestSRC, survival; varPro supplies glioma.
# install.packages(c("randomForestSRC", "survival", "varPro"))
library(randomForestSRC)
library(survival)


###############################################################################
# Slide 5: Key quantities for classification
# Topic: OOB inference and returned quantities
###############################################################################

# o$predicted     --->   inbag estimated probabilities
# o$predicted.oob --->   OOB estimated probabilities
# o$class         --->   inbag class predictions
# o$class.oob     --->   OOB class predictions


###############################################################################
# Slide 6: OOB classification example: Glioma
# Topic: OOB inference and returned quantities
###############################################################################

# Grow the multiclass classifier and inspect its performance.
data(glioma, package = "varPro")
o <- rfsrc(y ~ ., data = glioma)
print(o)

# Compare inbag and OOB misclassification.
print(mean(o$class != o$yvar))
print(mean(o$class.oob != o$yvar))

# Retain the classifier for Slide 12; o is reused for survival below.
o.glioma <- o


###############################################################################
# Slide 7: Key quantities
# Topic: OOB inference and returned quantities
###############################################################################

# Compare inbag and OOB probability estimates for five cases.
print(o$predicted[1:5, ])
print(o$predicted.oob[1:5, ])

# Compare the corresponding class labels.
print(o$class[1:5])
print(o$class.oob[1:5])


###############################################################################
# Slide 8: Key quantities for survival
# Topic: OOB inference and returned quantities
###############################################################################

# o$time.interest --->   event times (everything keys off this)
# o$predicted     --->   inbag estimated mortality
# o$predicted.oob --->   OOB estimated mortality
# o$survival      --->   inbag survival estimator for each case
# o$survival.oob  --->   OOB survival estimator for each case
# o$chf          --->    inbag CHF estimator for each case
# o$chf.oob      --->    OOB CHF estimator for each case


###############################################################################
# Slide 9: OOB survival example: PBC Mayo Clinic
# Topic: OOB inference and returned quantities
###############################################################################

# Load PBC and collapse positive endpoint codes to a single event indicator.
data(pbc, package = "survival")
pbc$id <- NULL
pbc$status[pbc$status > 0] <- 1

# Grow a random survival forest.
o <- rfsrc(Surv(time, status) ~ ., pbc)

# Compare inbag and OOB survival curves for three cases.
idx <- c(11, 34, 60)
matplot(o$time.interest,
        t(o$survival[idx, ]), type = "l", col = 4, lwd = 3,
        xlab = "Days", ylab = "Survival")
matlines(o$time.interest,
         t(o$survival.oob[idx, ]), type = "l", col = 2, lwd = 3)
legend("bottomleft", legend = c("inbag", "oob"), fill = c(4, 2))


###############################################################################
# Slide 11: Prediction error for classification
# Topic: Prediction error
###############################################################################

# Classification performance helpers:
# get.misclass.error
# get.brier.error
# get.logloss
# get.auc
# The relevant inputs include observed outcomes and OOB predictions.


###############################################################################
# Slide 12: Classification example: Glioma
# Topic: Prediction error
###############################################################################

# Return to the glioma classifier retained on Slide 6.
print(o.glioma)

# The last row reports the final tree-wise error values.
print(tail(o.glioma$err.rate, 1))


###############################################################################
# Slide 13: Prediction error for survival
# Topic: Prediction error
###############################################################################

# Survival performance reference:
# Harrell C-error: $err.rate; get.cindex
# Time-varying Brier score: get.brier.survival
# Time-varying AUC: get.auct.survival


###############################################################################
# Slide 14: Prediction error for survival
# Topic: Prediction error
###############################################################################

# Combined Brier-score and AUC-t plotting interfaces:
# plot.brier.auc   (randomForestSRC.run)
# plotBrierAUC     (randomForestSRC)


###############################################################################
# Slide 15: Prediction
# Topic: Prediction on new data
###############################################################################

# Syntax shown on the slide: predict(object, testdata)
# Syntax shown on the slide: predict(object, testdata, outcome = "test")
# Syntax shown on the slide: predict(object, ...)


###############################################################################
# Slide 17: Prediction: canonical example
# Topic: Prediction on new data
###############################################################################

# Load the veteran survival data and inspect its dimensions.
data(veteran, package = "randomForestSRC")
print(dim(veteran))


###############################################################################
# Slide 18: Prediction: canonical example
# Topic: Prediction on new data
###############################################################################

# Convert predictors to factors, retaining numeric survival time and status.
data(veteran, package = "randomForestSRC")
veteran2 <- data.frame(lapply(veteran, factor))
veteran2$time <- veteran$time
veteran2$status <- veteran$status

# Use an unequal 25/75 train/test split.
# Subsetting preserves factor-level definitions in both samples.
train <- sample(1:nrow(veteran2), round(nrow(veteran2) * .25))
print(summary(veteran2[train, ]))
print(summary(veteran2[-train, ]))


###############################################################################
# Slide 19: Prediction: canonical example
# Topic: Prediction on new data
###############################################################################

# Grow on the training rows and score the test rows.
o <- rfsrc(Surv(time, status) ~ ., veteran2[train, ])
pred <- predict(o, veteran2[-train, ])

# Distinguish OOB training performance from test-data performance.
print(o)
print(pred)


###############################################################################
# Slide 20: Prediction: canonical example
# Topic: Prediction on new data
###############################################################################

# Introduce a factor level not encountered during training.
veteran3 <- veteran2[1:3, ]
veteran3$celltype <- factor(c("newlevel", "1", "3"))
pred2 <- predict(o, veteran3)
print(pred2)

# Inspect how the unrecognized level is represented in the test predictors.
print(pred2$xvar)


###############################################################################
# Slide 21: Restore
# Topic: Restore mode
###############################################################################

# General restore-mode syntax shown on the slide:
# predict(object, ...)


###############################################################################
# Slide 22: Restore
# Topic: Restore mode
###############################################################################

# Grow a glioma classifier, then restore it with a Brier performance target.
o <- rfsrc(y ~ ., data = glioma)
print(o)
p <- predict(o, perf.type = "brier")
print(p)


###############################################################################
# Slide 23: Restore
# Topic: Restore mode
###############################################################################

# Express OOB regression predictions using forest weights.
o <- rfsrc(mpg ~ ., mtcars)
fwt <- predict(o, forest.wt = "oob")$forest.wt
yhat <- c(fwt %*% o$yvar)

# Compare the reconstructed predictions and errors with the forest output.
print(summary(yhat - o$predicted.oob))
print(o)
print(mean((yhat - o$yvar)^2))


###############################################################################
# Slide 26: Survival example: peakVO2
# Topic: Partial plots and peakVO2
###############################################################################

# Load the heart-failure survival data.
data(peakVO2, package = "randomForestSRC")
print(dim(peakVO2))


###############################################################################
# Slide 27: Survival example: peakVO2
# Topic: Partial plots and peakVO2
###############################################################################

# Grow a survival forest and examine the age partial effect at two years.
o <- rfsrc(Surv(ttodead, died) ~ ., peakVO2)
plot.variable(o, surv.type = "surv", xvar.names = "age",
              time = 2, partial = TRUE)


###############################################################################
# Slide 28: Survival example: peakVO2
# Topic: Partial plots and peakVO2
###############################################################################

# Smooth the age partial-effect display.
plot.variable(o, surv.type = "surv", xvar.names = "age",
              smooth.lines = TRUE, time = 2, partial = TRUE)


###############################################################################
# Slide 29: Survival example: peakVO2
# Topic: Partial plots and peakVO2
###############################################################################

# Request the relative-frequency survival output scale.
plot.variable(o, surv.type = "rel.freq", xvar.names = "age",
              smooth.lines = TRUE, partial = TRUE)


###############################################################################
# PART III: VARIABLE SELECTION
# ASA Traveling Course: Tree-Based Machine Learning Methods
# Student R-code companion
#
# Run sections in slide order. Later examples can reuse earlier objects.
# The short names o, fit, and pred are reused for different analyses.
# Run installation commands separately, once, when a package is needed.
# Sampling and forest randomization mean numerical results may vary.
###############################################################################

# Required packages: randomForestSRC, survival, varPro.
# install.packages(c("randomForestSRC", "survival", "varPro"))
library(randomForestSRC)
library(survival)
library(varPro)


###############################################################################
# Slide 6: Different VIMP in the package
# Topic: Permutation VIMP and subsampling inference
###############################################################################

# importance = c("anti", "permute", "random")
# importance = TRUE       -->   anti-VIMP
# importance = "permute"  -->   Breiman-Cutler
# importance = "random"   -->   random-VIMP


###############################################################################
# Slide 7: Obtaining VIMP using the package
# Topic: Permutation VIMP and subsampling inference
###############################################################################

# Use mtcars for the mpg formula examples.
# Request permutation VIMP while growing the forest.
vimp.grow <- rfsrc(mpg ~ ., data = mtcars,
                   importance = "permute")$importance
print(vimp.grow)
vimp.grow.block <- rfsrc(mpg ~ ., data = mtcars,
                         importance = "permute", block.size = 10)$importance
print(vimp.grow.block)

# Request VIMP from an existing forest through restore mode.
obj <- rfsrc(mpg ~ ., data = mtcars)
vimp.restore <- predict(obj, importance = "permute")$importance
print(vimp.restore)
vimp.restore.block <- predict(obj, importance = "permute",
                              block.size = 10)$importance
print(vimp.restore.block)

# Use the dedicated vimp interface.
print(vimp(obj, importance = "permute"))
print(vimp(obj, importance = "permute", block.size = 10)$importance)

# Perturb pairs of iris predictors jointly.
obj <- rfsrc(Species ~ ., data = iris)
print(vimp(obj, obj$xvar.names[1:2],
           importance = "permute", joint = TRUE)$importance)
print(vimp(obj, obj$xvar.names[3:4],
           importance = "permute", joint = TRUE)$importance)


###############################################################################
# Slide 8: General call to vimp
# Topic: Permutation VIMP and subsampling inference
###############################################################################

# Individual permutation importance, including class-specific values.
iris.obj <- rfsrc(Species ~ ., data = iris)
print(vimp(iris.obj, importance = "permute")$importance)

# Joint permutation importance for petal length and petal width.
print(vimp(iris.obj, c("Petal.Length", "Petal.Width"),
           joint = TRUE, importance = "permute")$importance)


###############################################################################
# Slide 11: Confidence intervals for VIMP
# Topic: Permutation VIMP and subsampling inference
###############################################################################

# Grow a survival forest with permutation VIMP and estimate uncertainty.
data(peakVO2, package = "randomForestSRC")
o <- rfsrc(Surv(ttodead, died) ~ ., peakVO2, importance = "permute")
oo <- subsample(o)
plot.subsample(oo, alpha = .05)


###############################################################################
# Slide 18: Minimal depth illustration using peakVO2
# Topic: Minimal depth
###############################################################################

# Extract and sort the first-order minimal depths; smaller means earlier splits.
md <- max.subtree(o)$order[, 1]
barplot(sort(md), las = 2, horiz = TRUE, col = "cadetblue3")


###############################################################################
# Slide 19: Minimal depth illustration using peakVO2
# Topic: Minimal depth
###############################################################################

# Guide candidate-variable selection using the original forest's split counts.
xvar.used <- predict(o, var.used = "all.trees")$var.used
os <- rfsrc(Surv(ttodead, died) ~ ., peakVO2, xvar.wt = xvar.used)
mds <- max.subtree(os)$order[, 1]
barplot(sort(mds), las = 2, horiz = TRUE, col = "cadetblue3")


###############################################################################
# Slide 21: VarPro
# Topic: VarPro motivation and interface
###############################################################################

# Inspect the ranges of the clinical variables used in the permutation example.
print(summary(peakVO2[, c("bun", "interval", "peak.vo2")]))


###############################################################################
# Slide 26: VarPro canonical illustration
# Topic: VarPro examples
###############################################################################

# Compute supervised variable priority for the survival outcome.
o <- varpro(Surv(ttodead, died) ~ ., peakVO2)
print(importance(o))


###############################################################################
# Slide 27: VarPro canonical illustration
# Topic: VarPro examples
###############################################################################

# Select a VarPro cutoff by cross-validation and inspect the complete result.
o.cv <- cv.varpro(Surv(ttodead, died) ~ ., peakVO2)
print(o.cv)

# Components for individual inspection:
# print(o.cv$imp)
# print(o.cv$imp.conserve)
# print(o.cv$imp.liberal)
# print(o.cv$err)
# print(o.cv$zcut)
# print(o.cv$zcut.conserve)
# print(o.cv$zcut.liberal)


###############################################################################
# Slide 28: VarPro canonical illustration
# Topic: VarPro examples
###############################################################################

# Permutation VIMP with subsampling confidence intervals.
o <- rfsrc(Surv(ttodead, died) ~ ., peakVO2, importance = "permute")
oo <- subsample(o)
plot.subsample(oo, alpha = .05)

# Compare with cross-validated VarPro's liberal selection.
o.cv <- cv.varpro(Surv(ttodead, died) ~ ., peakVO2)
barplot(o.cv$imp.liberal$z, names.arg = o.cv$imp.liberal$variable,
        las = 2, horiz = TRUE, col = "coral2")


###############################################################################
# Slide 29: VarPro canonical illustration
# Topic: VarPro examples
###############################################################################

# Revisit the VIMP/VarPro comparison using the results from Slide 28.
plot.subsample(oo, alpha = .05)
barplot(o.cv$imp.liberal$z, names.arg = o.cv$imp.liberal$variable,
        las = 2, horiz = TRUE, col = "coral2")


###############################################################################
# Slide 30: VarPro high-dimensional example
# Topic: VarPro examples
###############################################################################

# Load the high-dimensional microarray survival example.
data(vdv, package = "randomForestSRC")
print(dim(vdv))


###############################################################################
# Slide 31: VarPro high-dimensional example
# Topic: VarPro examples
###############################################################################

# Compare three ways of guiding rule generation in high dimensions.
# These analyses can require substantial computation.
data(vdv, package = "randomForestSRC")
f <- as.formula(Surv(Time, Censoring) ~ .)

# Lasso guidance.
print(importance(varpro(f, vdv, split.weight.method = "lasso")))

# Combined lasso and VIMP guidance.
print(importance(varpro(f, vdv, split.weight.method = "lasso vimp")))

# Add shallow-tree split information.
print(importance(varpro(f, vdv, split.weight.method = "lasso vimp tree")))

# Optional reference-signature comparison: 25 runs of four methods.
# First define nms as the character vector of the original 70-gene signature
# and make get.orgvimp() available. The signature vector and helper definition
# are not included with these examples. Uncomment the block after setup.
#
# rO <- lapply(1:25, function(b) {
#   cat("replication:", b, "\n")
#   o1 <- varpro(f, vdv, split.weight.method = "lasso")
#   o2 <- varpro(f, vdv, split.weight.method = "lasso vimp")
#   o3 <- varpro(f, vdv, split.weight.method = "lasso vimp tree")
#   o4 <- varpro(f, vdv, split.weight.method = "lasso vimp", sparse = FALSE)
#   list(
#     "lasso" = intersect(nms, get.orgvimp(o1)$variable),
#     "lasso.vimp" = intersect(nms, get.orgvimp(o2)$variable),
#     "lasso.vimp.tree" = intersect(nms, get.orgvimp(o3)$variable),
#     "lasso.vimp.sparseoff" = intersect(nms, get.orgvimp(o4)$variable)
#   )
# })


###############################################################################
# Slide 32: VarPro high-dimensional example
# Topic: VarPro examples
###############################################################################

# Inspect the reference-signature overlap from the optional Slide 31 analysis.
# Run this only after creating rO with nms and get.orgvimp() available.
# print(rO[[1]])


###############################################################################
# Slide 34: plot.ivarpro()
# Topic: Individual variable priority
###############################################################################

# Compute case-specific variable priority for the peakVO2 survival outcome.
data(peakVO2, package = "randomForestSRC")
o <- varpro(Surv(ttodead, died) ~ ., peakVO2)
imp <- ivarpro(o)

# Relate peak-VO2 importance to its value, with exercise-interval color
# and outcome-dependent point size.
plot(imp, var = "peak.vo2", col.var = "interval", size.var = "y")


###############################################################################
# PART IV: ADVANCED TOPICS
# ASA Traveling Course: Tree-Based Machine Learning Methods
# Student R-code companion
#
# Run sections in slide order. Later examples can reuse earlier objects.
# The short names o, fit, and pred are reused for different analyses.
# Run installation commands separately, once, when a package is needed.
# Sampling and forest randomization mean numerical results may vary.
###############################################################################

# Core packages; additional packages are loaded near their examples.
# install.packages(c("randomForestSRC", "survival", "varPro",
#                    "randomForestSGT", "randomForestRHF", "mlbench"))
library(randomForestSRC)
library(survival)


###############################################################################
# Slide 3: Imbalanced classification
# Topic: Class-imbalanced classification
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
# Slide 11: Classification example: Glioma
# Topic: Class-imbalanced classification
###############################################################################

# Load the multiclass data and inspect the original subtype frequencies.
library(varPro)
data(glioma, package = "varPro")
print(table(glioma$y))

# Combine four common subtypes into a super-majority class.
class.combine <- c("Classic-like", "Codel", "G-CIMP-high", "Mesenchymal-like")
ynew <- factor(1 * !is.element(glioma$y, class.combine))

# Replace the response with the binary outcome.
glioma2 <- glioma
glioma2$y <- ynew
print(table(glioma2$y))


###############################################################################
# Slide 12: Imbalanced classification: Glioma
# Topic: Class-imbalanced classification
###############################################################################

# Standard random-forest classifier.
o1 <- rfsrc(y ~ ., data = glioma2)
print(o1)


###############################################################################
# Slide 13: Imbalanced classification: Glioma
# Topic: Class-imbalanced classification
###############################################################################

# Random-forest quantile (RFQ) classifier.
o2 <- imbalanced(y ~ ., data = glioma2)
print(o2)


###############################################################################
# Slide 14: Missing data imputation
# Topic: Missing-data imputation and OOD scoring
###############################################################################

# Imputation at different stages; interface references:
# rfsrc(..., na.action = "na.impute")
# predict(..., na.action = "na.impute")
# impute(...)
# impute.learn(...)


###############################################################################
# Slide 15: General call to impute
# Topic: Missing-data imputation and OOD scoring
###############################################################################

# Principal interfaces shown in this section:
# impute(formula, data = data, ...)
# impute(data = data, ...)


###############################################################################
# Slide 16: OTFI for training data
# Topic: Missing-data imputation and OOD scoring
###############################################################################

# Supervised on-the-fly imputation.
data(pbc, package = "randomForestSRC")
pbc.impute <- impute(Surv(days, status) ~ ., data = pbc)

# Unsupervised on-the-fly imputation.
pbc.impute <- impute(data = pbc)


###############################################################################
# Slide 17: missForest and mForest for training data
# Topic: Missing-data imputation and OOD scoring
###############################################################################

# missForest-style imputation: one regression target at a time.
data(pbc, package = "randomForestSRC")
pbc.impute <- impute(data = pbc, mf.q = 1)

# mForest-style grouped multivariate regressions.
data(housing, package = "randomForestSRC")
housing.impute <- impute(data = housing, mf.q = 0.5)
housing.impute <- impute(data = housing, mf.q = 40)


###############################################################################
# Slide 18: Test time imputation using impute.learn
# Topic: Missing-data imputation and OOD scoring
###############################################################################

# Interface reference; replace the ellipses with appropriate arguments.
# fit         <- impute.learn(...)
# newdata.imp <- predict(fit, newdata = ...)
# save.impute.learn(fit, path = ...)
# load.fit    <- load.impute.learn(path = ...)


###############################################################################
# Slide 20: Test time imputation
# Topic: Missing-data imputation and OOD scoring
###############################################################################

# Use a subset of airquality and create training/test samples.
aq <- airquality[, c("Ozone", "Solar.R", "Wind", "Temp", "Month")]
id <- sample(seq_len(nrow(aq)), 100)
train <- aq[id, ]
test <- aq[-id, ]

# Learn the imputation system from the training data.
fit <- impute.learn(
  data = train,
  mf.q = 1,
  max.iter = 5,
  full.sweep.options = list(ntree = 25, nsplit = 5),
  target.mode = "all"
)

# Impute the test data using the banked training forests.
test.imp <- predict(fit, test, max.predict.iter = 2)


###############################################################################
# Slide 23: OOD scoring example
# Topic: Missing-data imputation and OOD scoring
###############################################################################

# Recreate the training/test split used in the slide.
aq <- airquality[, c("Ozone", "Solar.R", "Wind", "Temp", "Month")]
id <- sample(seq_len(nrow(aq)), 100)
train <- aq[id, ]
test <- aq[-id, ]

# Supervised training and imputation, retaining the OOD reference information.
sup.fit <- impute.learn(
  data = train,
  mf.q = 1,
  supervised.formula = Solar.R ~ .,
  supervised.args = list(ntree = 50, nsplit = 5),
  full.sweep.options = list(ntree = 25, nsplit = 5),
  save.ood = TRUE
)

# Score and impute the test cases.
ood <- impute.ood(sup.fit, test)
print(head(ood$score))
print(head(ood$score.percentile))


###############################################################################
# Slide 27: The randomForestSGT package
# Topic: Super Greedy Trees
###############################################################################

# Load the SGT package for the geometric-splitting examples.
library(randomForestSGT)

# SGT forest interface reference:
# rfsgt(formula, data, ...)
# hcut = 0 gives CART splits; larger values expand the geometric dictionary.


###############################################################################
# Slide 29: Tuning hcut
# Topic: Super Greedy Trees
###############################################################################

# Simulate the Friedman-1 signal and add 50 independent noise variables.
n <- 2500
p <- 50
noise <- matrix(runif(n * p), ncol = p)
dta <- data.frame(mlbench:::mlbench.friedman1(n, sd = 0), noise = noise)

# Tune hcut over candidate values up to 3.
filter <- tune.hcut(y ~ ., dta, hcut = 3)


###############################################################################
# Slide 30: Using the tuned hcut
# Topic: Super Greedy Trees
###############################################################################

# Use the tuned hcut and its preselected basis functions.
o.sgt <- rfsgt(y ~ ., dta, filter = filter)
print(o.sgt)


###############################################################################
# Slide 31: Specific hcut families
# Topic: Super Greedy Trees
###############################################################################

# Compare CART-style and hyperplane splitting with the same filter.
o.hcut0 <- rfsgt(y ~ ., dta, filter = use.tune.hcut(filter, hcut = 0))
print(o.hcut0)

o.hcut1 <- rfsgt(y ~ ., dta, filter = use.tune.hcut(filter, hcut = 1))
print(o.hcut1)


###############################################################################
# Slide 32: SGTs as model explainers
# Topic: Super Greedy Trees
###############################################################################

# Grow a shallow forest and enforce lasso-based local models.
o <- rfsgt(
  y ~ ., data = dta,
  pure.lasso = TRUE, filter = filter, treesize = 5
)

# Extract OOB predictions, local beta coefficients, and partial contributions.
bo <- get.beta(o, bag = "oob")
yhat <- bo$predicted
beta <- bo$beta[, -1, drop = FALSE]
partial <- bo$partial[, -1, drop = FALSE]


###############################################################################
# Slide 33: SGT beta and partial effects
# Topic: Super Greedy Trees
###############################################################################

# Compare extracted predictions with the forest's OOB predictions.
print(head(yhat))
print(head(o$predicted.oob))

# Inspect local coefficients and partial-effect contributions.
print(head(beta[, 1:6]), digits = 2)
print(head(partial[, 1:6]), digits = 2)


###############################################################################
# Slide 34: Random Hazard Forests (RHF)
# Topic: Random Hazard Forests
###############################################################################

# Longitudinal counting-process interface reference:
# rhf(Surv(id, start, stop, event) ~ ., data)


###############################################################################
# Slide 35: RHF data format
# Topic: Random Hazard Forests
###############################################################################

# Counting-process response columns:
#   id     Subject identifier; repeated rows belong to the same subject.
#   start  Beginning of an observation interval.
#   stop   End of the interval, with stop > start.
#   event  Event indicator at stop: 1 = event, 0 = no event.


###############################################################################
# Slide 36: Time-static setting
# Topic: Random Hazard Forests
###############################################################################

# Load the RHF package and an ordinary baseline survival dataset.
library(randomForestRHF)
data(peakVO2, package = "randomForestSRC")

# Convert one-row-per-subject data to counting-process form.
d <- convert.counting(Surv(ttodead, died) ~ ., peakVO2)
f <- "Surv(id, start, stop, event) ~ ."

# Grow the time-static RHF.
o <- rhf(f, d)


###############################################################################
# Slide 37: Time-static results
# Topic: Random Hazard Forests
###############################################################################

# Inspect the number of records, unique subjects, events, and forest settings.
print(o)


###############################################################################
# Slide 38: Time-localized VarPro importance
# Topic: Random Hazard Forests
###############################################################################

# Grow the nodesize = 15 forest used in the time-localized importance example.
fit.n15 <- rhf(f, d, nodesize = 15)

# Calculate importance over the full follow-up grid.
imp.t <- importance.rhf(fit.n15)

# Compare dot-matrix and line displays of time-dependent variable priority.
plot(imp.t, type = "dotmatrix")
plot(imp.t, type = "lines")
