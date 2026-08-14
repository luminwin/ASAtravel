###############################################################################
# ASA Traveling Course: Tree-Based Machine Learning Methods
# Part IV: Advanced Topics
#
# Student R-code companion
# Code is organized in slide order for use during and after the workshop.
# Required packages and data are identified near their first use.
#
# Console output has been removed. Display-only syntax and incomplete calls
# are retained as comments. Run examples in slide order; the presentations
# intentionally reuse short object names such as o, fit, and pred.
###############################################################################

# Core packages used in the first half of this module.
library(randomForestSRC)
library(survival)

# Optional installation steps (run once, as needed):
# install.packages(c("varPro", "randomForestSGT", "randomForestRHF", "mlbench"))


###############################################################################
# Slide 3: Imbalanced classification
# Topic: Class-imbalanced classification
###############################################################################

# Family-specific grow calls shown on the slide:
# rfsrc(Ozone ~ ., data = airquality)
# quantreg(mpg ~ ., data = mtcars)
# rfsrc(Species ~ ., data = iris)
# imbalanced(status ~ ., data = breast)
# rfsrc(Surv(time, status) ~ ., data = veteran)
# rfsrc(Surv(time, status) ~ ., data = wihs)
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

library(varPro)
data(glioma, package = "varPro")
table(glioma$y)

# Combine four original labels into a super-majority class.
class.combine <- c(
  "Classic-like", "Codel", "G-CIMP-high", "Mesenchymal-like"
)
ynew <- factor(1 * !is.element(glioma$y, class.combine))

# Replace the original multiclass outcome by the new binary outcome.
glioma2 <- glioma
glioma2$y <- ynew
table(glioma2$y)


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
# Slide 15: Imbalanced classification: Glioma
# Topic: Class-imbalanced classification
###############################################################################

# Balanced random forest (BRF).
o3 <- imbalanced(y ~ ., data = glioma2, method = "brf")
print(o3)


###############################################################################
# Slide 16: Imbalanced classification: Glioma
# Topic: Class-imbalanced classification
###############################################################################

# G-mean variable importance with subsampling confidence intervals.
o2 <- imbalanced(
  y ~ ., data = glioma2,
  importance = "permute", block.size = 20
)
oo2 <- subsample(o2)
plot.subsample(oo2)


###############################################################################
# Slide 18: General call to impute
# Topic: Missing-data imputation and OOD scoring
###############################################################################

# Principal interfaces shown in this section:
# impute(formula, data = data, ...)
# impute(data = data, ...)


###############################################################################
# Slide 19: OTFI for training data
# Topic: Missing-data imputation and OOD scoring
###############################################################################

# Supervised on-the-fly imputation.
data(pbc, package = "randomForestSRC")
pbc.impute <- impute(Surv(days, status) ~ ., data = pbc)

# Unsupervised on-the-fly imputation.
pbc.impute <- impute(data = pbc)


###############################################################################
# Slide 20: missForest and mForest for training data
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
# Slide 21: Test time imputation using impute.learn
# Topic: Missing-data imputation and OOD scoring
###############################################################################

# Display-only interface summary; ellipses denote user-supplied arguments.
# fit         <- impute.learn(...)
# newdata.imp <- predict(fit, newdata = ...)
# save.impute.learn(fit, path = ...)
# load.fit    <- load.impute.learn(path = ...)


###############################################################################
# Slide 23: Test time imputation
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
# Slide 26: OOD scoring example
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
# Slide 30: The randomForestSGT package
# Topic: Super Greedy Trees
###############################################################################

library(randomForestSGT)

# Canonical SGT forest interface:
# rfsgt(formula, data, ...)
# hcut = 0 gives CART splits; larger hcut values enlarge the geometric
# dictionary used to define candidate splits.


###############################################################################
# Slide 32: Tuning hcut
# Topic: Super Greedy Trees
###############################################################################

# Simulate Friedman-1 signal and append noise variables.
n <- 2500
p <- 50
noise <- matrix(runif(n * p), ncol = p)
dta <- data.frame(
  mlbench:::mlbench.friedman1(n, sd = 0),
  noise = noise
)

# Tune hcut over values up to 3.
filter <- tune.hcut(y ~ ., data = dta, hcut = 3)


###############################################################################
# Slide 33: Using the tuned hcut
# Topic: Super Greedy Trees
###############################################################################

# Use the tuned hcut and the preselected basis functions.
o.sgt <- rfsgt(y ~ ., data = dta, filter = filter)
print(o.sgt)


###############################################################################
# Slide 34: Specific hcut families
# Topic: Super Greedy Trees
###############################################################################

# hcut = 0 recovers axis-aligned CART/random-forest splitting.
o.hcut0 <- rfsgt(
  y ~ ., data = dta,
  filter = use.tune.hcut(filter, hcut = 0)
)
print(o.hcut0)

# hcut = 1 gives hyperplane splits.
o.hcut1 <- rfsgt(
  y ~ ., data = dta,
  filter = use.tune.hcut(filter, hcut = 1)
)
print(o.hcut1)


###############################################################################
# Slide 35: SGTs as model explainers
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
# Slide 36: SGT beta and partial effects
# Topic: Super Greedy Trees
###############################################################################

# Compare extracted predictions with the forest's OOB predictions.
print(head(yhat))
print(head(o$predicted.oob))

# Inspect local coefficients and partial-effect contributions.
print(head(beta[, 1:6]), digits = 2)
print(head(partial[, 1:6]), digits = 2)


###############################################################################
# Slide 37: Random Hazard Forests (RHF)
# Topic: Random Hazard Forests
###############################################################################

library(randomForestRHF)

# Canonical RHF syntax for longitudinal counting-process data:
# rhf(Surv(id, start, stop, event) ~ ., data = data)


###############################################################################
# Slide 38: RHF data format
# Topic: Random Hazard Forests
###############################################################################

# Required response columns in long form:
#   id     subject identifier; repeated rows belong to the same subject
#   start  beginning of the interval
#   stop   end of the interval, with stop > start
#   event  event indicator at stop (1 = event, 0 = no event)
# A typical inspection command is:
# head(data[, c("id", "start", "stop", "event")])


###############################################################################
# Slide 39: Time-static setting
# Topic: Random Hazard Forests
###############################################################################

# Load ordinary baseline survival data.
data(peakVO2, package = "randomForestSRC")

# Convert one-row-per-subject survival data to counting-process form.
d <- convert.counting(Surv(ttodead, died) ~ ., data = peakVO2)

# Set the RHF formula and grow the forest.
f <- "Surv(id, start, stop, event) ~ ."
o <- rhf(f, data = d)


###############################################################################
# Slide 40: Time-static results
# Topic: Random Hazard Forests
###############################################################################

# Display the summary shown on the slide.
print(o)


###############################################################################
# Slide 41: Time-dependent AUC
# Topic: Random Hazard Forests
###############################################################################

# Compare two terminal-node sizes.
fit.n1 <- rhf(f, data = d, nodesize = 1)
fit.n15 <- rhf(f, data = d, nodesize = 15)

# AUC-t using cumulative-hazard and hazard markers.
auc.n1.chf <- auct.rhf(fit.n1)
auc.n1.haz <- auct.rhf(fit.n1, marker = "haz")
auc.n15.chf <- auct.rhf(fit.n15)
auc.n15.haz <- auct.rhf(fit.n15, marker = "haz")

# Plot the four AUC-t curves.
ylim <- c(0.6, 0.85)
par(mfrow = c(2, 2))
plot(auc.n1.chf, ylim = ylim, main = "nodesize 1, CHF marker")
plot(auc.n1.haz, ylim = ylim, main = "nodesize 1, hazard marker")
plot(auc.n15.chf, ylim = ylim, main = "nodesize 15, CHF marker")
plot(auc.n15.haz, ylim = ylim, main = "nodesize 15, hazard marker")


###############################################################################
# Slide 43: Hazard plots
# Topic: Random Hazard Forests
###############################################################################

# Smooth the fitted case-specific hazards.
shaz.n15 <- smoothed.hazard(fit.n15)

# Select the first three subject IDs represented in the ensemble.
id <- fit.n15$ensemble.id[1:3]

# Compare OOB and smoothed hazard curves.
par(mfrow = c(1, 2))
plot(fit.n15, idx = id, main = "OOB Hazard")
plot(shaz.n15, idx = id, main = "Smoothed Hazard")


###############################################################################
# Slide 45: Time-localized VarPro importance
# Topic: Random Hazard Forests
###############################################################################

# Estimate time-localized RHF variable importance over the full time grid.
imp.t <- importance.rhf(fit.n15)

# Two complementary displays of time-dependent importance.
plot(imp.t, type = "dotmatrix")
plot(imp.t, type = "lines")
