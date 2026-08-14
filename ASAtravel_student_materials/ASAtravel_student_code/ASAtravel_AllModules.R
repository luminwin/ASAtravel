###############################################################################
# ASA Traveling Course: Tree-Based Machine Learning Methods
# Complete student R-code companion: Parts I-IV
#
# The file is organized in presentation order. Each section gives the module,
# slide number, slide title, and topic. Console output has been removed.
# Display-only syntax is retained as comments rather than executable code.
###############################################################################


###############################################################################
# PART I: TRAINING
###############################################################################

###############################################################################
# ASA Traveling Course: Tree-Based Machine Learning Methods
# Part I: Training
#
# Student R-code companion
# Code is organized in slide order for use during and after the workshop.
# Console output has been removed. Display-only syntax is retained as comments.
# Code is arranged in presentation order and labeled by the corresponding slide.
###############################################################################

# Core package used throughout this module.
library(randomForestSRC)
library(survival)


###############################################################################
# Slide 7: Brief Overview
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
# Slide 8: Quick Start: Iowa Housing
# Topic: Iowa housing quick start and forest output
###############################################################################

data(housing, package = "randomForestSRC")
dim(housing)


###############################################################################
# Slide 10: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

library(randomForestSRC)
o <- rfsrc(SalePrice~., data = housing)


###############################################################################
# Slide 11: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

library(randomForestSRC)
o <- rfsrc(SalePrice~., data = housing)
print(o)


###############################################################################
# Slide 13: Quick Start: Iowa Housing
# Topic: Iowa housing quick start and forest output
###############################################################################

# Code example 1
o <- rfsrc(SalePrice~., data= housing)
o

# Code example 2
housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice~., data= housing)
o


###############################################################################
# Slide 14: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Code example 1
data(housing, package = "randomForestSRC")
housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice~., data= housing)
print(o)

# Code example 2
# Illustrative syntax shown on the slide: rfsrc(..., ntree = 500)


###############################################################################
# Slide 15: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Illustrative syntax shown on the slide: rfsrc(..., nodesize = 5)


###############################################################################
# Slide 16: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Illustrative syntax shown on the slide: rfsrc(..., mtry = NULL)


###############################################################################
# Slide 17: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Illustrative syntax shown on the slide: rfsrc(..., samptype = "swor")


###############################################################################
# Slide 19: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Illustrative syntax shown on the slide: rfsrc(..., splitrule = "mse")


###############################################################################
# Slide 20: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

# Illustrative syntax shown on the slide: rfsrc(..., nsplit = 10)


###############################################################################
# Slide 21: Quick Start
# Topic: Iowa housing quick start and forest output
###############################################################################

o.pred <- predict(o, newdata = housing[c(1:10),])
head(o.pred$predicted)


###############################################################################
# Slide 23: General call to rfsrc.cart
# Topic: Iowa housing quick start and forest output
###############################################################################

# CART-style single-tree interface shown on the slide:
# rfsrc.cart(formula, data, ntree = 1, mtry = ncol(data),
#            bootstrap = "none", ...)


###############################################################################
# Slide 24: Nonparametric regression
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
# Slide 26: Regression example: Iowa housing
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
# Slide 29: Regression example: Iowa housing
# Topic: Regression and quantile regression
###############################################################################

# Optional installation step (run once, not every session):
# install.packages("devtools")
# devtools::install_github("kogalur/randomForestSRC.run")


###############################################################################
# Slide 30: Regression example: Iowa housing
# Topic: Regression and quantile regression
###############################################################################

library(randomForestSRC.run)
run.rfsrc(SalePrice ~ ., housing, ntree = 500)


###############################################################################
# Slide 32: Classification
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
# Slide 33: Classification example: Glioma
# Topic: Classification and glioma
###############################################################################

# install.packages("devtools") # if you have not installed "devtools" package
devtools::install_github("kogalur/varPro")
data(glioma, package = "varPro")
dim(glioma)


###############################################################################
# Slide 34: Classification example: Glioma
# Topic: Classification and glioma
###############################################################################

o <- rfsrc(y~., data = glioma)
o


###############################################################################
# Slide 36: Classification example: Glioma
# Topic: Classification and glioma
###############################################################################

o <- rfsrc(y~., data = glioma,
           splitrule="gini") ## default splitrule as in the previous slide
o


###############################################################################
# Slide 37: Classification example: Glioma
# Topic: Classification and glioma
###############################################################################

o <- rfsrc(y~., data = glioma,
           splitrule="auc")
o


###############################################################################
# Slide 38: Classification example: Glioma
# Topic: Classification and glioma
###############################################################################

o <- rfsrc(y~., data = glioma,
           splitrule="entropy")
o


###############################################################################
# Slide 39: The run.rfsrc function for an overview
# Topic: Classification and glioma
###############################################################################

run.rfsrc(y~., data = glioma)


###############################################################################
# Slide 41: Survival
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
# Slide 42: Survival example: PBC Mayo Clinic
# Topic: Survival and PBC
###############################################################################

data(pbc, package = "survival")
dim(pbc)


###############################################################################
# Slide 43: Survival example: PBC Mayo Clinic
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
# Slide 45: Split rules
# Topic: Survival and PBC
###############################################################################

o <- rfsrc(Surv(time, status) ~ ., data = pbc,
                  splitrule="logrank") ## default splitrule
o


###############################################################################
# Slide 46: Split rules
# Topic: Survival and PBC
###############################################################################

o <- rfsrc(Surv(time, status) ~ ., data = pbc,
                  splitrule="bs.gradient")
o


###############################################################################
# Slide 47: Split rules
# Topic: Survival and PBC
###############################################################################

o <- rfsrc(Surv(time, status) ~ ., data = pbc,
                  splitrule="logrankscore")
o


###############################################################################
# Slide 48: The run.rfsrc function for an overview
# Topic: Survival and PBC
###############################################################################

run.rfsrc(Surv(time, status) ~ ., data = pbc)

###############################################################################
# PART II: INFERENCE AND PREDICTION
###############################################################################

###############################################################################
# ASA Traveling Course: Tree-Based Machine Learning Methods
# Part II: Inference and Prediction
#
# Student R-code companion
# Code is organized in slide order for use during and after the workshop.
# Console output has been removed. Display-only syntax is retained as comments.
# Code is arranged in presentation order and labeled by the corresponding slide.
###############################################################################

# Core package used throughout this module.
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

data(glioma, package = "varPro")
o <- rfsrc(y ~ ., data = glioma)
print(o)

mean(o$class != o$yvar)
# Inbag misclassification is zero in the displayed example.
mean(o$class.oob != o$yvar)


###############################################################################
# Slide 7: Key quantities
# Topic: OOB inference and returned quantities
###############################################################################

# Inbag and OOB class-probability estimates
o$predicted[1:5, ]
o$predicted.oob[1:5, ]

# Inbag and OOB class predictions
o$class[1:5]
o$class.oob[1:5]


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

# Code example 1
# o$survival      --->   inbag survival estimator for each case
# o$survival.oob  --->   OOB survival estimator for each case

# Code example 2
## load the PBC data
data(pbc, package="survival")

## remove the ID
pbc$id <- NULL

## convert to right-censoring with death as the event
pbc$status[pbc$status > 0] <- 1

## default RSF call
o <- rfsrc(Surv(time, status)~., pbc)

## choose some cases
idx <- c(11,34,60)

## plot the curves
matplot(o$time.interest,
        t(o$survival[idx,]), type = "l", col=4, lwd=3,
        xlab = "Days", ylab = "Survival")
matlines(o$time.interest,
        t(o$survival.oob[idx,]), type = "l", col=2, lwd=3)
legend("bottomleft", legend = c("inbag", "oob"), fill = c(4,2))


###############################################################################
# Slide 10: Key quantities
# Topic: OOB inference and returned quantities
###############################################################################

o$time.interest[1:5]
o$predicted[1:5]
o$predicted.oob[1:5]

dim(o$yvar)
length(o$time.interest)
dim(o$survival)
dim(o$survival.oob)


###############################################################################
# Slide 12: Prediction error for classification
# Topic: Prediction error
###############################################################################

# Classification performance helpers discussed on the slide:
# get.misclass.error(object)
# get.brier.error(object)
# get.logloss(object)
# get.auc(object)
# The same quantities can also be calculated from object$yvar and
# object$predicted.oob or object$class.oob.


###############################################################################
# Slide 13: Classification example: Glioma
# Topic: Prediction error
###############################################################################

tail(o$err.rate, 1)


###############################################################################
# Slide 14: Prediction error for survival
# Topic: Prediction error
###############################################################################

# Survival performance helpers discussed on the slide:
# object$err.rate or get.cindex(object)       # Harrell C-error
# get.brier.survival(object)                 # time-varying Brier score
# plot.brier.auc(object)                     # workshop helper for Brier/AUC-t


###############################################################################
# Slide 16: Prediction
# Topic: Prediction on new data
###############################################################################

# Syntax shown on the slide: predict(object, testdata)
# Syntax shown on the slide: predict(object, testdata, outcome = "test")
# Syntax shown on the slide: predict(object, ...)


###############################################################################
# Slide 18: Prediction: canonical example
# Topic: Prediction on new data
###############################################################################

data(veteran, package = "randomForestSRC")
dim(veteran)


###############################################################################
# Slide 19: Prediction: canonical example
# Topic: Prediction on new data
###############################################################################

# Code example 1
## veteran data (with factors)
data(veteran, package = "randomForestSRC")
veteran2 <- data.frame(lapply(veteran, factor))
veteran2$time <- veteran$time
veteran2$status <- veteran$status

## split the data into unbalanced train/test data (25/75)
## the train/test data have the same levels, but different labels
train <- sample(1:nrow(veteran2), round(nrow(veteran2) * .25))

# Code example 2
summary(veteran2[train,])

# Code example 3
summary(veteran2[-train,])


###############################################################################
# Slide 20: Prediction: canonical example
# Topic: Prediction on new data
###############################################################################

# Code example 1
## train the forest and use this to predict on test data
o <- rfsrc(Surv(time, status) ~ ., veteran2[train, ])
pred <- predict(o, veteran2[-train , ])

# Code example 2
print(o)

# Code example 3
print(pred)


###############################################################################
# Slide 21: Prediction: canonical example
# Topic: Prediction on new data
###############################################################################

## even harder ... factor level not previously encountered in training
veteran3 <- veteran2[1:3, ]
veteran3$celltype <- factor(c("newlevel", "1", "3"))
pred2 <- predict(o, veteran3)
print(pred2)

## the unusual level is treated like a missing value but is not removed
print(pred2$xvar)


###############################################################################
# Slide 22: Restore
# Topic: Restore mode
###############################################################################

# General restore-mode syntax shown on the slide:
# predict(object, ...)


###############################################################################
# Slide 23: Restore
# Topic: Restore mode
###############################################################################

# Code example 1
o <- rfsrc(y~., data = glioma)
o

# Code example 2
p <- predict(o, perf.type = "brier")
p


###############################################################################
# Slide 24: Restore
# Topic: Restore mode
###############################################################################

## create your own estimator for regression
o <- rfsrc(mpg~.,mtcars)
fwt <- predict(o, forest.wt="oob")$forest.wt
yhat <- c(fwt %*% o$yvar)

## compare to the OOB ensemble
print(summary(yhat - o$predicted.oob))

## compare prediction error to OOB ensemble
print(o)

print(mean((yhat - o$yvar)^2))


###############################################################################
# Slide 28: Survival example: peakVO2
# Topic: Partial plots and peakVO2
###############################################################################

data(peakVO2, package = "randomForestSRC")
dim(peakVO2)


###############################################################################
# Slide 29: Survival example: peakVO2
# Topic: Partial plots and peakVO2
###############################################################################

o <- rfsrc(Surv(ttodead,died)~., peakVO2)
## partial effect for age
plot.variable(o, surv.type = "surv", xvar.names = "age",
              time = 2, partial = TRUE)


###############################################################################
# Slide 30: Survival example: peakVO2
# Topic: Partial plots and peakVO2
###############################################################################

## partial effect for age
plot.variable(o, surv.type = "surv", xvar.names = "age",
              smooth.lines = TRUE,
              time = 2, partial = TRUE)


###############################################################################
# Slide 31: Survival example: peakVO2
# Topic: Partial plots and peakVO2
###############################################################################

## partial effect for age
plot.variable(o, surv.type = "rel.freq", xvar.names = "age",
              smooth.lines = TRUE,
              partial = TRUE)


###############################################################################
# Slide 32: Survival example: peakVO2
# Topic: Partial plots and peakVO2
###############################################################################

# Code example 1
## partial effect of peak V02 on mortality

partial.o <- partial(o,
                     partial.type = "mort",
                     partial.xvar = "peak.vo2",
                     partial.values = o$xvar$peak.vo2,
                     partial.time = o$time.interest)
pdta.m <- get.partial.plot.data(partial.o)

# Code example 2
## partial effect of peak V02 on survival
pvo2 <- quantile(o$xvar$peak.vo2)
partial.o <- partial(o,
                     partial.type = "surv",
                     partial.xvar = "peak.vo2",
                     partial.values = pvo2,
                     partial.time = o$time.interest)
pdta.s <- get.partial.plot.data(partial.o)

# Code example 3
## compare the two plots
par(mfrow=c(1,2))

plot(lowess(pdta.m$x, pdta.m$yhat, f = 2/3),
     type = "l", xlab = "peak VO2", ylab = "adjusted mortality")
rug(o$xvar$peak.vo2)

matplot(pdta.s$partial.time, t(pdta.s$yhat), type = "l", lty = 1,
        xlab = "years", ylab = "peak VO2 adjusted survival")
legend("bottomleft", legend = paste0("peak VO2 = ", pvo2),
       bty = "n", cex = .75, fill = 1:5)

###############################################################################
# PART III: VARIABLE SELECTION
###############################################################################

###############################################################################
# ASA Traveling Course: Tree-Based Machine Learning Methods
# Part III: Variable Selection
#
# Student R-code companion
# Code is organized in slide order for use during and after the workshop.
# Console output has been removed. Display-only syntax is retained as comments.
# Code is arranged in presentation order and labeled by the corresponding slide.
###############################################################################

# Core package used throughout this module.
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

# Request permutation VIMP while growing the forest.
vimp.grow <- rfsrc(mpg ~ ., data = mtcars,
                   importance = "permute")$importance
vimp.grow.block <- rfsrc(mpg ~ ., data = mtcars,
                         importance = "permute",
                         block.size = 10)$importance

# Restore an existing forest and request VIMP.
obj <- rfsrc(mpg ~ ., data = mtcars)
vimp.restore <- predict(obj, importance = "permute")$importance
vimp.restore.block <- predict(obj, importance = "permute",
                              block.size = 10)$importance

# Use the dedicated vimp() interface.
vimp(obj, importance = "permute")
vimp(obj, importance = "permute", block.size = 10)$importance

# Joint permutation VIMP for pairs of iris variables.
iris.obj <- rfsrc(Species ~ ., data = iris)
vimp(iris.obj, iris.obj$xvar.names[1:2],
     importance = "permute", joint = TRUE)$importance
vimp(iris.obj, iris.obj$xvar.names[3:4],
     importance = "permute", joint = TRUE)$importance


###############################################################################
# Slide 8: General call to vimp
# Topic: Permutation VIMP and subsampling inference
###############################################################################

# Code example 1
## VIMP for all variables
iris.obj <- rfsrc(Species ~ ., data = iris)
print(vimp(iris.obj, importance = "permute")$importance)

# Code example 2
## joint VIMP
print(vimp(iris.obj, c("Petal.Length", "Petal.Width"), joint = TRUE, importance = "permute")$importance)


###############################################################################
# Slide 11: Confidence intervals for VIMP
# Topic: Permutation VIMP and subsampling inference
###############################################################################

## example using peakVO2
data(peakVO2, package = "randomForestSRC")
o <- rfsrc(Surv(ttodead, died)~., peakVO2, importance="permute")
oo <- subsample(o)
plot.vimp.ci(oo, alpha=.05)


###############################################################################
# Slide 18: Minimal depth illustration using peakVO2
# Topic: Minimal depth
###############################################################################

md <- max.subtree(o)$order[, 1]
barplot(sort(md),
        las=2, horiz = TRUE, col = "cadetblue3")


###############################################################################
# Slide 19: Minimal depth illustration using peakVO2
# Topic: Minimal depth
###############################################################################

## guide random feature selection with number of times variable splits
xvar.used <- predict(o,
               var.used="all.trees")$var.used
os <- rfsrc(Surv(ttodead, died)~., peakVO2, xvar.wt = xvar.used)
mds <- max.subtree(os)$order[, 1]
barplot(sort(mds),
        las=2, horiz = TRUE, col = "cadetblue3")


###############################################################################
# Slide 21: VarPro
# Topic: VarPro motivation and interface
###############################################################################

summary(peakVO2[,c("bun","interval", "peak.vo2")])


###############################################################################
# Slide 26: VarPro canonical illustration
# Topic: VarPro examples
###############################################################################

# Canonical VarPro fit.
o <- varpro(Surv(ttodead, died) ~ ., peakVO2)
importance(o)

# Cross-validated cutoff selection.
o.cv <- cv.varpro(Surv(ttodead, died) ~ ., peakVO2)
print(o.cv)


###############################################################################
# Slide 27: VarPro canonical illustration
# Topic: VarPro examples
###############################################################################

# Examine the cross-validated VarPro result from Slide 26.
o.cv$imp
o.cv$imp.conserve
o.cv$imp.liberal
o.cv$err
o.cv$zcut


###############################################################################
# Slide 28: VarPro canonical illustration
# Topic: VarPro examples
###############################################################################

# Code example 1
o <- rfsrc(Surv(ttodead, died)~., peakVO2, importance="permute")
oo <- subsample(o)
plot.vimp.ci(oo, alpha=.05)

# Code example 2
o.cv <- cv.varpro(Surv(ttodead, died)~., peakVO2)
barplot(o.cv$imp.liberal$z, names.arg=o.cv$imp.liberal$variable,
        las=2, horiz = TRUE, col = "coral2")


###############################################################################
# Slide 30: VarPro high-dimensional example
# Topic: VarPro examples
###############################################################################

data(vdv, package = "randomForestSRC")
dim(vdv)


###############################################################################
# Slide 31: VarPro high-dimensional example
# Topic: VarPro examples
###############################################################################

## van de Vijver Microarray Breast Cancer
## high dimensional survival example using different split-weights
## illustrates guided trees

data(vdv, package = "randomForestSRC")
f <- as.formula(Surv(Time, Censoring)~.)

## lasso only
importance(varpro(f, vdv, split.weight.method = "lasso"))

## lasso and vimp
importance(varpro(f, vdv, split.weight.method = "lasso vimp"))

## lasso, vimp and shallow trees
importance(varpro(f, vdv, split.weight.method = "lasso vimp tree"))

## store the original vdv 70 gene signature in object nms
## compare methods using 25 runs:
rO <- lapply(1:25, function(b) {
  cat("replication:", b, "\n")
  o1 <- varpro(f, vdv, split.weight.method = "lasso")
  o2 <- varpro(f, vdv, split.weight.method = "lasso vimp")
  o3 <- varpro(f, vdv, split.weight.method = "lasso vimp tree")
  o4 <- varpro(f, vdv, split.weight.method = "lasso vimp", sparse = FALSE)
  list("lasso"=intersect(nms,get.orgvimp(o1)$variable),
       "lasso.vimp"=intersect(nms,get.orgvimp(o2)$variable),
       "lasso.vimp.tree"=intersect(nms,get.orgvimp(o3)$variable),
       "lasso.vimp.sparseoff"=intersect(nms,get.orgvimp(o4)$variable))
})


###############################################################################
# Slide 32: VarPro high-dimensional example
# Topic: VarPro examples
###############################################################################

# Reuse rO from Slide 31 to inspect overlap with the reference signature.
# The character vector nms must contain the names in the reference
# 70-gene signature before running the repeated comparison on Slide 31.
rO[[1]]


###############################################################################
# Slide 34: ivarpro() — Individual Variable Priority
# Topic: Individual and unsupervised VarPro
###############################################################################

# Code example 1
data(peakVO2, package = "randomForestSRC")
o <- varpro(Surv(ttodead, died) ~ .,
            peakVO2, ntree = 50)
ivp <- ivarpro(o)
print(ivp[1:5, 1:8])

# Code example 2
##      age    gender bmi   peak.vo2 chemo
## [1,]  0.041  NA  0.028   0.312   NA
## [2,]  NA     NA  0.011   0.284   0.022
## [3,]  0.014  0.031  NA   0.271   NA
## [4,]  0.033  NA  0.019   0.290   0.017

# Code example 3
imp <- ivarpro(o, cut.max = 2, adaptive = FALSE)
shap.ivarpro(imp)


###############################################################################
# Slide 35: plot.ivarpro()
# Topic: Individual and unsupervised VarPro
###############################################################################

plot(imp, var = "peak.vo2",
                col.var = "interval",
                size.var = "y")


###############################################################################
# Slide 37: Core Functions
# Topic: Individual and unsupervised VarPro
###############################################################################

# Syntax shown on the slide: varpro()
# Syntax shown on the slide: partialpro()
# Syntax shown on the slide: plot()
# Syntax shown on the slide: importance()
# Syntax shown on the slide: cv.varpro()
# Syntax shown on the slide: uvarpro()
# Syntax shown on the slide: sdependent()
# Syntax shown on the slide: get.beta.entropy()
# Syntax shown on the slide: ivarpro()
# Syntax shown on the slide: shap.ivarpro()
# Syntax shown on the slide: partial.ivarpro()


###############################################################################
# Slide 38: uvarpro() — Unsupervised Variable Priority [ 7 ]
# Topic: Individual and unsupervised VarPro
###############################################################################

# Code example 1
uvp <- uvarpro(BostonHousing[-(1:5), ])
print(head(importance(uvp)))

# Code example 2
##      names   zscores
## 1    lstat  8.341252
## 2       rm  7.916084
## 3      dis  6.204817
## 4      nox  5.983761
## 5      age  4.742198
## 6  ptratio  4.210573

# Code example 3
beta <- get.beta.entropy(uvp)
print(beta[1:4, 1:4])

# Code example 4
sdependent(beta)


###############################################################################
# Slide 39: Summary
# Topic: Closing
###############################################################################

# Syntax shown on the slide: varpro()
# Syntax shown on the slide: cv.varpro()
# Syntax shown on the slide: uvarpro()
# Syntax shown on the slide: ivarpro()
# Syntax shown on the slide: outpro()
# Syntax shown on the slide: isopro()

###############################################################################
# PART IV: ADVANCED TOPICS
###############################################################################

###############################################################################
# ASA Traveling Course: Tree-Based Machine Learning Methods
# Part IV: Advanced Topics
#
# Student R-code companion
# Code is organized in slide order for use during and after the workshop.
# Console output has been removed. Display-only syntax is retained as comments.
# Code is arranged in presentation order and labeled by the corresponding slide.
###############################################################################

# Core package used throughout this module.
library(randomForestSRC)
library(survival)
library(randomForestSGT)
library(randomForestRHF)


###############################################################################
# Slide 3: Imbalanced classification
# Topic: Class-imbalanced classification
###############################################################################

# Syntax shown on the slide: rfsrc(Ozone~., data = airquality)
# Syntax shown on the slide: quantreg(mpg~., data = mtcars)
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
# Slide 11: Classification example: Glioma
# Topic: Class-imbalanced classification
###############################################################################

data(glioma, package = "varPro")
table(glioma$y)

## make a super majority class
class.combine <- c("Classic-like", "Codel", "G-CIMP-high", "Mesenchymal-like")
ynew <- factor(1 * !is.element(glioma$y, class.combine))

## replace y with the new super class
glioma2 <- glioma
glioma2$y <- ynew
table(glioma2$y)


###############################################################################
# Slide 12: Imbalanced classification: Glioma
# Topic: Class-imbalanced classification
###############################################################################

## standard RF classifier
o1 <- rfsrc(y~.,glioma2)
print(o1)


###############################################################################
# Slide 13: Imbalanced classification: Glioma
# Topic: Class-imbalanced classification
###############################################################################

## RFQ classifier
o2 <- imbalanced(y~.,glioma2)
print(o2)


###############################################################################
# Slide 15: Imbalanced classification: Glioma
# Topic: Class-imbalanced classification
###############################################################################

## BRF classifier
o3 <- imbalanced(y~.,glioma2, method = "brf")
print(o3)


###############################################################################
# Slide 16: Imbalanced classification: Glioma
# Topic: Class-imbalanced classification
###############################################################################

## gmean variable importance with ci
o2 <- imbalanced(y~.,glioma2, importance="permute", block.size=20)
oo2 <- subsample(o2)
plot.subsample(oo2)


###############################################################################
# Slide 17: Competing risk
# Topic: Competing risks
###############################################################################

# Syntax shown on the slide: rfsrc(Ozone~., data = airquality)
# Syntax shown on the slide: quantreg(mpg~., data = mtcars)
# Syntax shown on the slide: rfsrc(Species~., data = iris)
# Syntax shown on the slide: imbalanced(status~., data = breast)
# Syntax shown on the slide: rfsrc(Surv(time, status)~., data = veteran)
# Syntax shown on the slide: rfsrc(Multivar(mpg, cyl)~., data = mtcars)
# Syntax shown on the slide: rfsrc(cbind(Species,Sepal.Length)~.,data=iris)
# Syntax shown on the slide: quantreg(cbind(mpg, cyl)~., data = mtcars)
# Syntax shown on the slide: quantreg(cbind(Species,Sepal.Length)~.,data=iris)
# Syntax shown on the slide: rfsrc(data = mtcars)
# Syntax shown on the slide: sidClustering(data = mtcars)
# Syntax shown on the slide: sidClustering(data = mtcars, method = "sh")


###############################################################################
# Slide 19: Competing risk quantities of interest
# Topic: Competing risks
###############################################################################

# Syntax shown on the slide: obj$cif
# Syntax shown on the slide: obj$importance


###############################################################################
# Slide 20: Competing risk example: PBC Mayo Clinic
# Topic: Competing risks
###############################################################################

data(pbc, package = "survival")

pbc$id <- NULL ## remove the ID

## status at endpoint, 0/1/2 for censored, transplant, dead
pbc.cr <- pbc


###############################################################################
# Slide 21: Competing risk example: PBC Mayo Clinic
# Topic: Competing risks
###############################################################################

## canonical example: default Gray's splitting-rule
o <- rfsrc(Surv(time, status) ~ ., pbc)
o


###############################################################################
# Slide 22: event specific and non-event specific variable selection
# Topic: Competing risks
###############################################################################

## canonical example: default Gray's splitting-rule
## status: 0/1/2 for censored, transplant, dead
o <- rfsrc(Surv(time, status) ~ ., pbc)

## log-rank splitting where each event type is treated as the event of interest
## log-rank cause-1 specific splitting and targeted VIMP for cause 1="transplant"
o.log1 <- rfsrc(Surv(time, status) ~ ., pbc,
                splitrule = "logrank", cause = 1, importance = "permute")

## log-rank cause-2 specific splitting and targeted VIMP for cause 2="death"
o.log2 <- rfsrc(Surv(time, status) ~ ., pbc,
                splitrule = "logrank", cause = 2, importance = "permute")

## extract minimal depth from the Gray split forest: non-event specific
## extract VIMP from the log-rank forests: event-specific
var.perf <- data.frame(md = max.subtree(o)$order[, 1],
                       vimp1 = 100 * o.log1$importance[ ,1],
                       vimp2 = 100 * o.log2$importance[ ,2])
print(var.perf[order(var.perf$md), ], digits = 2)


###############################################################################
# Slide 24: CIF stratified by edema
# Topic: Competing risks
###############################################################################

## cumulative incidence function (CIF) for transplant and dead stratified by edema
cif <- o$cif.oob; Time <- o$time.interest
edema <- o$xvar$edema
cif.transplant <- cbind(apply(cif[,,1][edema == 0,], 2, mean),
                        apply(cif[,,1][edema > 0,], 2, mean))
cif.dead  <- cbind(apply(cif[,,2][edema == 0,], 2, mean),
                   apply(cif[,,2][edema > 0,], 2, mean))
matplot(Time, cbind(cif.transplant, cif.dead), type = "l",
        lty = c(1,2,1,2), col = c(4, 4, 2, 2), lwd = 3, ylab = "CIF")
legend("topleft", legend = c("Transplant (No Edema)", "Transplant (Edema)",
                  "Dead (No Edema)", "Dead (Edema)"),
       lty = c(1,2,1,2), col = c(4, 4, 2, 2), lwd = 3, cex = 1.1)


###############################################################################
# Slide 25: The run.rfsrc function for an overview
# Topic: Competing risks
###############################################################################

## tip!!! perform the same analysis as above with one line
run.rfsrc(Surv(time, status) ~ ., pbc, ntree=1000, alpha=.10)


###############################################################################
# Slide 27: Partial plot
# Topic: Competing risks
###############################################################################

pbc.cr$time <- pbc.cr$time/365
## target = an integer value between 1 and J indicating the event of interest
plot.variable(o.log1, target = 1,
              xvar.names = "age", partial = TRUE, smooth.lines = TRUE)


###############################################################################
# Slide 28: Partial plot
# Topic: Competing risks
###############################################################################

# Code example 1
## target = an integer value between 1 and J indicating the event of interest
## where J is the number of event types
plot.variable(o.log1, target = 1,
              xvar.names = "age", partial = TRUE, smooth.lines = TRUE)

# Code example 2
## target = an integer value between 1 and J indicating the event of interest
## where J is the number of event types
plot.variable(o.log2, target = 2,
              xvar.names = "age", partial = TRUE, smooth.lines = TRUE)


###############################################################################
# Slide 29: Multivariate analysis
# Topic: Multivariate forests
###############################################################################

# Syntax shown on the slide: rfsrc(Ozone~., data = airquality)
# Syntax shown on the slide: quantreg(mpg~., data = mtcars)
# Syntax shown on the slide: rfsrc(Species~., data = iris)
# Syntax shown on the slide: imbalanced(status~., data = breast)
# Syntax shown on the slide: rfsrc(Surv(time, status)~., data = veteran)
# Syntax shown on the slide: rfsrc(Surv(time, status)~., data = wihs)
# Syntax shown on the slide: rfsrc(cbind(Species,Sepal.Length)~.,data=iris)
# Syntax shown on the slide: quantreg(cbind(mpg, cyl)~., data = mtcars)
# Syntax shown on the slide: quantreg(cbind(Species,Sepal.Length)~.,data=iris)
# Syntax shown on the slide: rfsrc(data = mtcars)
# Syntax shown on the slide: sidClustering(data = mtcars)
# Syntax shown on the slide: sidClustering(data = mtcars, method = "sh")


###############################################################################
# Slide 30: Multivariate example: Nutrigenomic Study
# Topic: Multivariate forests
###############################################################################

# Code example 1
data(nutrigenomic, package = "randomForestSRC")
names(nutrigenomic)

dim(nutrigenomic$lipids)
dim(nutrigenomic$genes)

# Code example 2
## diet and genotype are factors
head(nutrigenomic$diet)

head(nutrigenomic$genotype)


###############################################################################
# Slide 31: Multivariate example: Nutrigenomic Study
# Topic: Multivariate forests
###############################################################################

# Code example 1
## parse into y and x data
ydta <- nutrigenomic$lipids
xdta <- data.frame(nutrigenomic$genes,
                   diet = nutrigenomic$diet,
                   genotype = nutrigenomic$genotype)

## multivariate regression forest call
o <- rfsrc(get.mv.formula(colnames(ydta)),
            data.frame(ydta, xdta),
            importance=TRUE, nsplit = 10,
            splitrule = "mahalanobis")

# Code example 2
print(o)


###############################################################################
# Slide 32: Multivariate example: Nutrigenomic Study
# Topic: Multivariate forests
###############################################################################

## acquire the error rate for each of the 21 coordinates
## standardize to allow comparison across coordinates
serr <- get.mv.error(o, standardize = TRUE)
serr

## acquire standardized VIMP
# The slide displays obj; o is the fitted multivariate forest from Slide 31.
svimp <- get.mv.vimp(o, standardize = TRUE)
head(svimp)


###############################################################################
# Slide 34: Split rules
# Topic: Multivariate forests
###############################################################################

o <- rfsrc(get.mv.formula(colnames(ydta)),
             data.frame(ydta, xdta),
             importance=TRUE, nsplit = 10,
             splitrule = "mahalanobis")
print(o)


###############################################################################
# Slide 35: Split rules
# Topic: Multivariate forests
###############################################################################

o2 <- rfsrc(get.mv.formula(colnames(ydta)),
              data.frame(ydta, xdta),
              importance=TRUE, nsplit = 10)

print(o2)


###############################################################################
# Slide 36: Split rules
# Topic: Multivariate forests
###############################################################################

# Code example 1
## compare standardized VIMP for top 25 variables
imp <- data.frame(mahalanobis = rowMeans(get.mv.vimp(o,  standardize = TRUE)),
                  default     = rowMeans(get.mv.vimp(o2, standardize = TRUE)))

# Code example 2
print(100 * imp[order(imp[,"mahalanobis"], decreasing = TRUE)[1:25], ])


###############################################################################
# Slide 37: The run.rfsrc function for an overview
# Topic: Multivariate forests
###############################################################################

library(randomForestSRC.run)
run.rfsrc(get.mv.formula(colnames(ydta)), data.frame(ydta, xdta))


###############################################################################
# Slide 42: OTFI for training data
# Topic: Missing-data imputation and OOD scoring
###############################################################################

# Code example 1
data(pbc, package = "randomForestSRC")
pbc.impute <- impute(Surv(days, status)~.,pbc)

# Code example 2
data(pbc, package = "randomForestSRC")
pbc.impute <- impute(data=pbc)


###############################################################################
# Slide 43: missForest and mForest for training data
# Topic: Missing-data imputation and OOD scoring
###############################################################################

# Code example 1
data(pbc, package = "randomForestSRC")
pbc.impute <- impute(data=pbc, mf.q=1)

# Code example 2
data(housing, package = "randomForestSRC")
housing.impute <- impute(data=housing, mf.q=.5)
housing.impute <- impute(data=housing, mf.q=40)


###############################################################################
# Slide 44: Test time imputation using impute.learn
# Topic: Missing-data imputation and OOD scoring
###############################################################################

# General test-time imputation workflow shown on the slide:
# fit <- impute.learn(...)
# newdata.imp <- predict(fit, newdata = ...)
# save.impute.learn(fit, path = ...)
# load.fit <- load.impute.learn(path = ...)


###############################################################################
# Slide 45: Test time imputation
# Topic: Missing-data imputation and OOD scoring
###############################################################################

aq <- airquality[, c("Ozone", "Solar.R", "Wind", "Temp", "Month")]

id <- sample(seq_len(nrow(aq)), 100); train <- aq[id, ]; test  <- aq[-id, ]

## imputation/training
fit <- impute.learn(
  data = train,
  mf.q = 1,
  max.iter = 5,
  full.sweep.options = list(ntree = 25, nsplit = 5),
  target.mode = "all"
)

## test time imputation
test.imp <- predict(fit, test, max.predict.iter = 2)


###############################################################################
# Slide 48: OOD scoring example
# Topic: Missing-data imputation and OOD scoring
###############################################################################

aq <- airquality[, c("Ozone", "Solar.R", "Wind", "Temp", "Month")]

id <- sample(seq_len(nrow(aq)), 100); train <- aq[id, ]; test  <- aq[-id, ]

## supervised training and imputation
sup.fit <- impute.learn(
  data = train,
  mf.q = 1,
  supervised.formula = Solar.R ~ .,
  supervised.args = list(ntree = 50, nsplit = 5),
  full.sweep.options = list(ntree = 25, nsplit = 5),
  save.ood = TRUE
)

## test time scoring and imputation
ood <- impute.ood(sup.fit, test)
print(head(ood$score))
print(head(ood$score.percentile))


###############################################################################
# Slide 54: Tuning hcut
# Topic: Super Greedy Trees
###############################################################################

# Simulate data
n <- 2500
p <- 50
noise <- matrix(runif(n * p), ncol = p)
dta   <- data.frame(mlbench:::mlbench.friedman1(n, sd = 0), noise = noise)

# Tune hcut
filter <- tune.hcut(y ~ ., dta, hcut = 3)


###############################################################################
# Slide 55: Using the tuned hcut
# Topic: Super Greedy Trees
###############################################################################

# Use tuned hcut and pre-selected bases
print(rfsgt(y ~ ., dta, filter = filter))


###############################################################################
# Slide 56: Specific hcut families
# Topic: Super Greedy Trees
###############################################################################

# Code example 1
print(rfsgt(y ~ ., dta, filter = use.tune.hcut(filter, hcut = 0)))

# Code example 2
print(rfsgt(y ~ ., dta, filter = use.tune.hcut(filter, hcut = 1)))


###############################################################################
# Slide 57: SGTs as model explainers
# Topic: Super Greedy Trees
###############################################################################

# Code example 1
o <- rfsgt(y ~ ., dta, pure.lasso = TRUE, filter = filter, treesize = 5)

# Code example 2
bo      <- get.beta(o, bag = "oob")
yhat    <- bo$predicted
beta    <- bo$beta[, -1, drop = FALSE]
partial <- bo$partial[, -1, drop = FALSE]


###############################################################################
# Slide 58: SGT \(\beta\) and partial effects
# Topic: Super Greedy Trees
###############################################################################

## compare yhat to OOB values from forest object
print(head(yhat))
print(head(o$predicted.oob))

## beta values
print(head(beta[, 1:6]), digits = 2)

## partial effect values
print(head(partial[, 1:6]), digits = 2)


###############################################################################
# Slide 59: Random Hazard Forests (RHF)
# Topic: Random Hazard Forests
###############################################################################

# Canonical RHF syntax; replace data with a counting-process data frame:
# rhf(Surv(id, start, stop, event) ~ ., data)


###############################################################################
# Slide 61: Time-static setting
# Topic: Random Hazard Forests
###############################################################################

library("randomForestRHF")
## load data
data(peakVO2, package = "randomForestSRC")

## convert to counting-process format
d <- convert.counting(Surv(ttodead, died) ~ ., peakVO2)

## set the formula
f <- "Surv(id, start, stop, event) ~ ."

## canonical call
o <- rhf(f, d)


###############################################################################
# Slide 63: Time-dependent AUC
# Topic: Random Hazard Forests
###############################################################################

## try different nodesizes
fit.n1   <- rhf(f, d, nodesize = 1)
fit.n15  <- rhf(f, d, nodesize = 15)

## AUC-t with chf/hazard markers
auc.n1.chf  <- auct.rhf(fit.n1)
auc.n1.haz  <- auct.rhf(fit.n1,  marker = "haz")
auc.n15.chf <- auct.rhf(fit.n15)
auc.n15.haz <- auct.rhf(fit.n15, marker = "haz")

## plot AUC-t curves
ylim <- c(0.6, 0.85)
par(mfrow = c(2, 2))
plot(auc.n1.chf,  ylim = ylim, main = "nodesize 1, CHF marker")
plot(auc.n1.haz,  ylim = ylim, main = "nodesize 1, hazard marker")
plot(auc.n15.chf, ylim = ylim, main = "nodesize 15, CHF marker")
plot(auc.n15.haz, ylim = ylim, main = "nodesize 15, hazard marker")


###############################################################################
# Slide 64: Hazard plots
# Topic: Random Hazard Forests
###############################################################################

## smoothed hazard
shaz.n15 <- smoothed.hazard(fit.n15)

## pull ids for first 3 patients
id <- fit.n15$ensemble.id[1:3]

## display OOB/smoothed hazards
par(mfrow = c(1, 2))
plot(fit.n15, idx = id, main = "OOB Hazard")
plot(shaz.n15, idx = id, main = "Smoothed Hazard")


###############################################################################
# Slide 65: Time-localized VarPro importance
# Topic: Random Hazard Forests
###############################################################################

## time-localized RHF importance (across the full time grid)
imp.t <- importance.rhf(fit.n15)

## different ways to visualize time-dependent importance
plot(imp.t, type = "dotmatrix")
plot(imp.t, type = "lines")
