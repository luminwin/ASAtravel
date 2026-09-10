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
