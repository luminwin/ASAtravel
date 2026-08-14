###############################################################################
# ASA Traveling Course: Tree-Based Machine Learning Methods
# Part II: Inference and Prediction
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

# Recreate the classification fit from Slide 6 because the short object
# name o was subsequently reused for the PBC survival example.
o.glioma <- rfsrc(y ~ ., data = glioma)
tail(o.glioma$err.rate, 1)


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
