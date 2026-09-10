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
