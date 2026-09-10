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
