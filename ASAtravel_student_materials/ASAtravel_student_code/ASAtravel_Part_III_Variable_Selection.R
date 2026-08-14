###############################################################################
# ASA Traveling Course: Tree-Based Machine Learning Methods
# Part III: Variable Selection
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
library(varPro)

# Optional installation step for the Boston Housing example on Slide 38:
# install.packages("mlbench")


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
# Slide 29: VarPro canonical illustration
# Topic: VarPro examples
###############################################################################

# This is an incremental/zoomed continuation of Slide 28 and reuses the same
# VIMP and cross-validated VarPro plotting code. Run the Slide 28 block again
# when reproducing this display independently.


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
data(BostonHousing, package = "mlbench")
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
