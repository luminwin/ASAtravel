# Random Forest Workshop Code — All Parts
# Auto-generated from Quarto/Reveal HTML by a simple parser.
# Notes:
#  - Each section below is annotated with Part and Slide title so users can match code to slides.
#  - Output printed in slides is intentionally omitted; code is intended to run in R.
#  - Some slides include illustrative snippets (e.g., argument values) without full context.
#  - You may need to attach packages and data as in the slides (randomForestSRC, varPro, survival, etc.).
#  - Please report any extraction glitches (e.g., missing lines) and we can refine the parser heuristics.


##############################################################################
# Part I
##############################################################################

# --- Slide 6: Brief Overview --- (Code block 1)
o <- rfsrc(y ~ a + z, data= dta, ntree = 1)

# --- Slide 6: Brief Overview --- (Code block 2)
o <- impute(y ~ ., data = dta, nimpute = 3) # for supervised problem
o <- impute(data = dta) # for unsupervised problem

# --- Slide 7: Quick Start: Iowa Housing --- (Code block 1)
data(housing, package = "randomForestSRC")
dim(housing)
[1] 2930   81

# --- Slide 9: Quick Start --- (Code block 1)
library(randomForestSRC)
o <- rfsrc(SalePrice~., data = housing)

# --- Slide 10: Quick Start --- (Code block 1)
library(randomForestSRC)
o <- rfsrc(SalePrice~., data = housing)
print(o)
1                           Sample size: 2274
2                       Number of trees: 500
3             Forest terminal node size: 5
4         Average no. of terminal nodes: 311.04
5  No. of variables tried at each split: 27
6                Total no. of variables: 80
7         Resampling used to grow trees: swor
8      Resample size used to grow trees: 1437
9                              Analysis: RF-R
10                               Family: regr
11                       Splitting rule: mse *random*
12        Number of random split points: 10
13                      (OOB) R squared: 0.90947926
14    (OOB) Requested performance error: 628691481.703799

# --- Slide 11: Quick Start --- (Code block 1)
13                      (OOB) R squared: 0.90947926
14    (OOB) Requested performance error: 628691481.703799

# --- Slide 12: Quick Start: Iowa Housing --- (Code block 1)
o <- rfsrc(SalePrice~., data= housing)
1                           Sample size: 2274
2                       Number of trees: 500
3             Forest terminal node size: 5
4         Average no. of terminal nodes: 311.04
5  No. of variables tried at each split: 27
6                Total no. of variables: 80
7         Resampling used to grow trees: swor
8      Resample size used to grow trees: 1437
9                              Analysis: RF-R
10                               Family: regr
11                       Splitting rule: mse *random*
12        Number of random split points: 10
13                      (OOB) R squared: 0.90947926
14    (OOB) Requested performance error: 628691481.703799

# --- Slide 12: Quick Start: Iowa Housing --- (Code block 2)
housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice~., data= housing)
o
1                           Sample size: 2274
2                       Number of trees: 500
3             Forest terminal node size: 5
4         Average no. of terminal nodes: 310.61
5  No. of variables tried at each split: 27
6                Total no. of variables: 80
7         Resampling used to grow trees: swor
8      Resample size used to grow trees: 1437
9                              Analysis: RF-R
10                               Family: regr
11                       Splitting rule: mse *random*
12        Number of random split points: 10
13                      (OOB) R squared: 0.89837879
14    (OOB) Requested performance error: 0.01688687

# --- Slide 13: Quick Start --- (Code block 1)
data(housing, package = "randomForestSRC")
housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice~., data= housing)
print(o)
1                           Sample size: 2274
2                       Number of trees: 500
3             Forest terminal node size: 5
4         Average no. of terminal nodes: 310.61
5  No. of variables tried at each split: 27
6                Total no. of variables: 80
7         Resampling used to grow trees: swor
8      Resample size used to grow trees: 1437
9                              Analysis: RF-R
10                               Family: regr
11                       Splitting rule: mse *random*
12        Number of random split points: 10
13                      (OOB) R squared: 0.89837879
14    (OOB) Requested performance error: 0.01688687

# --- Slide 13: Quick Start --- (Code block 2)
rfsrc(…, ntree = 500)

# --- Slide 14: Quick Start --- (Code block 1)
data(housing, package = "randomForestSRC")
housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice~., data= housing)
print(o)
1                           Sample size: 2274
2                       Number of trees: 500
3             Forest terminal node size: 5
4         Average no. of terminal nodes: 310.61
5  No. of variables tried at each split: 27
6                Total no. of variables: 80
7         Resampling used to grow trees: swor
8      Resample size used to grow trees: 1437
9                              Analysis: RF-R
10                               Family: regr
11                       Splitting rule: mse *random*
12        Number of random split points: 10
13                      (OOB) R squared: 0.89837879
14    (OOB) Requested performance error: 0.01688687

# --- Slide 14: Quick Start --- (Code block 2)
rfsrc(…, nodesize = 5)

# --- Slide 15: Quick Start --- (Code block 1)
data(housing, package = "randomForestSRC")
housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice~., data= housing)
print(o)
1                           Sample size: 2274
2                       Number of trees: 500
3             Forest terminal node size: 5
4         Average no. of terminal nodes: 310.61
5  No. of variables tried at each split: 27
6                Total no. of variables: 80
7         Resampling used to grow trees: swor
8      Resample size used to grow trees: 1437
9                              Analysis: RF-R
10                               Family: regr
11                       Splitting rule: mse *random*
12        Number of random split points: 10
13                      (OOB) R squared: 0.89837879
14    (OOB) Requested performance error: 0.01688687

# --- Slide 15: Quick Start --- (Code block 2)
rfsrc(…, mtry = NULL)

# --- Slide 16: Quick Start --- (Code block 1)
data(housing, package = "randomForestSRC")
housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice~., data= housing)
print(o)
1                           Sample size: 2274
2                       Number of trees: 500
3             Forest terminal node size: 5
4         Average no. of terminal nodes: 310.61
5  No. of variables tried at each split: 27
6                Total no. of variables: 80
7         Resampling used to grow trees: swor
8      Resample size used to grow trees: 1437
9                              Analysis: RF-R
10                               Family: regr
11                       Splitting rule: mse *random*
12        Number of random split points: 10
13                      (OOB) R squared: 0.89837879
14    (OOB) Requested performance error: 0.01688687

# --- Slide 16: Quick Start --- (Code block 2)
rfsrc(…, samptype ="swor")

# --- Slide 17: Quick Start --- (Code block 1)
data(housing, package = "randomForestSRC")
housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice~., data= housing)
print(o)
1                           Sample size: 2274
2                       Number of trees: 500
3             Forest terminal node size: 5
4         Average no. of terminal nodes: 310.61
5  No. of variables tried at each split: 27
6                Total no. of variables: 80
7         Resampling used to grow trees: swor
8      Resample size used to grow trees: 1437
9                              Analysis: RF-R
10                               Family: regr
11                       Splitting rule: mse *random*
12        Number of random split points: 10
13                      (OOB) R squared: 0.89837879
14    (OOB) Requested performance error: 0.01688687

# --- Slide 18: Quick Start --- (Code block 1)
data(housing, package = "randomForestSRC")
housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice~., data= housing)
print(o)
1                           Sample size: 2274
2                       Number of trees: 500
3             Forest terminal node size: 5
4         Average no. of terminal nodes: 310.61
5  No. of variables tried at each split: 27
6                Total no. of variables: 80
7         Resampling used to grow trees: swor
8      Resample size used to grow trees: 1437
9                              Analysis: RF-R
10                               Family: regr
11                       Splitting rule: mse *random*
12        Number of random split points: 10
13                      (OOB) R squared: 0.89837879
14    (OOB) Requested performance error: 0.01688687

# --- Slide 18: Quick Start --- (Code block 2)
rfsrc(…, splitrule =“mse")

# --- Slide 19: Quick Start --- (Code block 1)
data(housing, package = "randomForestSRC")
housing$SalePrice <- log(housing$SalePrice)
o <- rfsrc(SalePrice~., data= housing)
print(o)
1                           Sample size: 2274
2                       Number of trees: 500
3             Forest terminal node size: 5
4         Average no. of terminal nodes: 310.61
5  No. of variables tried at each split: 27
6                Total no. of variables: 80
7         Resampling used to grow trees: swor
8      Resample size used to grow trees: 1437
9                              Analysis: RF-R
10                               Family: regr
11                       Splitting rule: mse *random*
12        Number of random split points: 10
13                      (OOB) R squared: 0.89837879
14    (OOB) Requested performance error: 0.01688687

# --- Slide 19: Quick Start --- (Code block 2)
rfsrc(…, nsplit = 10)

# --- Slide 20: Quick Start --- (Code block 1)
o.pred <- predict(o, newdata = housing[c(1:10),])
head(o.pred$predicted)
12.07895 11.69826 11.93491 12.43315 12.12497 12.13906

# --- Slide 22: Quick Start: Iowa Housing --- (Code block 1)
data(housing, package = "randomForestSRC")
nrow(housing)
[1] 2930
o <- rfsrc(SalePrice~., data= housing, ntree = 1)
length(o$yvar)
[1] 2274
nrow(o$xvar)
[1] 2274

# --- Slide 23: Quick Start: Iowa Housing --- (Code block 1)
nrow(housing)
[1] 2930
# Use supervised OTF imputation
housing.im <- impute(SalePrice~., data = housing)
nrow(housing.im)
[1] 2930
housing[c(12,15,23,24,25,56,28,120,2846,126,130,214,2671),c(1:9,4,60)]
PID MS.SubClass MS.Zoning Lot.Frontage Lot.Area Street         Alley Lot.Shape Land.Contour Lot.Frontage.1 Garage.Yr.Blt
12   527165230          20        RL           NA     7980   Pave noAlleyAccess       IR1          Lvl             NA          1992
15   527182190         120        RL           NA     6820   Pave noAlleyAccess       IR1          Lvl             NA          1985
23   527368020          60        FV           NA     7500   Pave noAlleyAccess       Reg          Lvl             NA          2000
24   527402200          20        RL           NA    11241   Pave noAlleyAccess       IR1          Lvl             NA          1970
25   527402250          20        RL           NA    12537   Pave noAlleyAccess       IR1          Lvl             NA          1971
56   528240070          60        RL           NA     7851   Pave noAlleyAccess       Reg          Lvl             NA          2002
28   527425090          20        RL           70    10500   Pave noAlleyAccess       Reg          Lvl             70            NA
120  534276360          20        RL           77     9320   Pave noAlleyAccess       IR1          Lvl             77            NA
2846 909131125         190        RH           NA     7082   Pave noAlleyAccess       Reg          Lvl             NA            NA
126  534427010          90        RL           98    13260   Pave noAlleyAccess       IR1          Lvl             98            NA
130  534450180          20        RL           50     7207   Pave noAlleyAccess       IR1          Lvl             50            NA
214  904351040          70   C (all)           NA     6449   Pave noAlleyAccess       IR1          Lvl             NA            NA
2671 903200050          30        RL           NA     7446   Pave noAlleyAccess       Reg          Lvl             NA            NA

# --- Slide 23: Quick Start: Iowa Housing --- (Code block 2)
nrow(housing)
[1] 2930
# do quick and dirty imputation
housing.im <- impute(SalePrice~., data = housing)
nrow(housing.im)
[1] 2930
housing.im[c(12,15,23,24,25,56,28,120,2846,126,130,214,2671),c(1:9,4,60)]
PID MS.SubClass MS.Zoning Lot.Frontage Lot.Area Street         Alley Lot.Shape Land.Contour Lot.Frontage.1 Garage.Yr.Blt
12   527165230          20        RL     68.85565     7980   Pave noAlleyAccess       IR1          Lvl       68.85565      1992.000
15   527182190         120        RL     68.56751     6820   Pave noAlleyAccess       IR1          Lvl       68.56751      1985.000
23   527368020          60        FV     66.21796     7500   Pave noAlleyAccess       Reg          Lvl       66.21796      2000.000
24   527402200          20        RL     74.53002    11241   Pave noAlleyAccess       IR1          Lvl       74.53002      1970.000
25   527402250          20        RL     80.12155    12537   Pave noAlleyAccess       IR1          Lvl       80.12155      1971.000
56   528240070          60        RL     71.88750     7851   Pave noAlleyAccess       Reg          Lvl       71.88750      2002.000
28   527425090          20        RL     70.00000    10500   Pave noAlleyAccess       Reg          Lvl       70.00000      1965.035
120  534276360          20        RL     77.00000     9320   Pave noAlleyAccess       IR1          Lvl       77.00000      1961.286
2846 909131125         190        RH     63.99655     7082   Pave noAlleyAccess       Reg          Lvl       63.99655      1946.405
126  534427010          90        RL     98.00000    13260   Pave noAlleyAccess       IR1          Lvl       98.00000      1968.485
130  534450180          20        RL     50.00000     7207   Pave noAlleyAccess       IR1          Lvl       50.00000      1962.214
214  904351040          70   C (all)     64.52222     6449   Pave noAlleyAccess       IR1          Lvl       64.52222      1942.500
2671 903200050          30        RL     66.49275     7446   Pave noAlleyAccess       Reg          Lvl       66.49275      1952.198

# --- Slide 24: Quick Start: Iowa Housing --- (Code block 1)
o <- rfsrc(SalePrice~., data = housing)
                         Sample size: 2274
                     Number of trees: 500
           Forest terminal node size: 5
       Average no. of terminal nodes: 310.83
No. of variables tried at each split: 27
              Total no. of variables: 80
       Resampling used to grow trees: swor
    Resample size used to grow trees: 1437
                            Analysis: RF-R
                              Family: regr
                      Splitting rule: mse *random*
       Number of random split points: 10
                     (OOB) R squared: 0.90907743
   (OOB) Requested performance error: 631482361.907825

# --- Slide 24: Quick Start: Iowa Housing --- (Code block 2)
o <- rfsrc(SalePrice~., data = housing, na.action = "na.impute")
                         Sample size: 2930
                    Was data imputed: yes
                     Number of trees: 500
           Forest terminal node size: 5
       Average no. of terminal nodes: 402.424
No. of variables tried at each split: 27
              Total no. of variables: 80
       Resampling used to grow trees: swor
    Resample size used to grow trees: 1852
                            Analysis: RF-R
                              Family: regr
                      Splitting rule: mse *random*
       Number of random split points: 10
                     (OOB) R squared: 0.90785994
   (OOB) Requested performance error: 588027121.705363

# --- Slide 29: Regression example: Iowa housing --- (Code block 1)
o <- quantreg(SalePrice ~ ., housing, splitrule = "mse", ntree = 250)
o <- quantreg(SalePrice ~ ., housing, splitrule = "quantile.regr", ntree = 250)
o <- quantreg(SalePrice ~ ., housing, splitrule = "la.quantile.regr", ntree = 250) # (default)

# --- Slide 29: Regression example: Iowa housing --- (Code block 2)
o
                         Sample size: 2274
                     Number of trees: 250
           Forest terminal node size: 5
       Average no. of terminal nodes: 263.86
No. of variables tried at each split: 27
              Total no. of variables: 80
       Resampling used to grow trees: swor
    Resample size used to grow trees: 1437
                            Analysis: RF-R
                              Family: regr
                      Splitting rule: la.quantile.regr *random*
       Number of random split points: 10
                     (OOB) R squared: 0.85752024
   (OOB) Requested performance error: 0.02367652

# --- Slide 29: Regression example: Iowa housing --- (Code block 3)
plot.quantreg(o)

# --- Slide 32: Regression example: Iowa housing --- (Code block 1)
library(devtools)
devtools::install_github("kogalur/randomForestSRC.run")

# --- Slide 33: Regression example: Iowa housing --- (Code block 1)
library(randomForestSRC.run)
run.rfsrc(SalePrice ~ ., housing, ntree = 500)

# --- Slide 36: Classification example: Glioma --- (Code block 1)
# install.packages("devtools") # if you have not installed "devtools" package
devtools::install_github("kogalur/varPro")
data(glioma, package = "varPro")
dim(glioma)
[1]  880 1242

# --- Slide 37: Classification example: Glioma --- (Code block 1)
o <- rfsrc(y~., data = glioma)
                         Sample size: 878
           Frequency of class labels: Classic-like=148, Codel=174, G-CIMP-high=249, G-CIMP-low=25, LGm6-GBM=41, Mesenchymal-like=215, PA-like=26
                     Number of trees: 500
           Forest terminal node size: 1
       Average no. of terminal nodes: 73.896
No. of variables tried at each split: 36
              Total no. of variables: 1241
       Resampling used to grow trees: swor
    Resample size used to grow trees: 555
                            Analysis: RF-C
                              Family: class
                      Splitting rule: gini *random*
       Number of random split points: 10
                   (OOB) Brier score: 0.02292715
        (OOB) Normalized Brier score: 0.18723839
                           (OOB) AUC: 0.99338879
                      (OOB) Log-loss: 0.33872539
   (OOB) Requested performance error: 0.07061503, 0.05405405, 0.01149425, 0.00803213, 0.52, 0.51219512, 0.06046512, 0.11538462
                  predicted
      (OOB) Misclassification rate: 0.07061503
   Brier: 0.12244898   Normalized Brier: 1   Log-loss: 1.94591015

# --- Slide 39: Classification example: Glioma --- (Code block 1)
o <- rfsrc(y~., data = glioma,
           splitrule="gini") ## default splitrule as in the previous slide
                         Sample size: 878
           Frequency of class labels: Classic-like=148, Codel=174, G-CIMP-high=249, G-CIMP-low=25, LGm6-GBM=41, Mesenchymal-like=215, PA-like=26
                     Number of trees: 500
           Forest terminal node size: 1
       Average no. of terminal nodes: 73.636
No. of variables tried at each split: 36
              Total no. of variables: 1241
       Resampling used to grow trees: swor
    Resample size used to grow trees: 555
                            Analysis: RF-C
                              Family: class
                      Splitting rule: gini *random*
       Number of random split points: 10
                   (OOB) Brier score: 0.02300423
        (OOB) Normalized Brier score: 0.18786787
                           (OOB) AUC: 0.99356381
                      (OOB) Log-loss: 0.3398169
   (OOB) Requested performance error: 0.07061503, 0.06081081, 0.00574713, 0.01204819, 0.56, 0.46341463, 0.05116279, 0.19230769
                  predicted
      (OOB) Misclassification rate: 0.06947608
   Brier: 0.12244898   Normalized Brier: 1   Log-loss: 1.94591015

# --- Slide 40: Classification example: Glioma --- (Code block 1)
o <- rfsrc(y~., data = glioma,
           splitrule="auc")
                         Sample size: 878
           Frequency of class labels: Classic-like=148, Codel=174, G-CIMP-high=249, G-CIMP-low=25, LGm6-GBM=41, Mesenchymal-like=215, PA-like=26
                     Number of trees: 500
           Forest terminal node size: 1
       Average no. of terminal nodes: 433.12
No. of variables tried at each split: 36
              Total no. of variables: 1241
       Resampling used to grow trees: swor
    Resample size used to grow trees: 555
                            Analysis: RF-C
                              Family: class
                      Splitting rule: auc *random*
       Number of random split points: 10
                   (OOB) Brier score: 0.04718235
        (OOB) Normalized Brier score: 0.38532251
                           (OOB) AUC: 0.97729984
                      (OOB) Log-loss: 0.61612302
   (OOB) Requested performance error: 0.16287016, 0.29054054, 0.06321839, 0.02409639, 0.8, 0.95121951, 0.02325581, 0.73076923

# --- Slide 41: Classification example: Glioma --- (Code block 1)
o <- rfsrc(y~., data = glioma,
           splitrule="entropy")
                         Sample size: 878
           Frequency of class labels: Classic-like=148, Codel=174, G-CIMP-high=249, G-CIMP-low=25, LGm6-GBM=41, Mesenchymal-like=215, PA-like=26
                     Number of trees: 500
           Forest terminal node size: 1
       Average no. of terminal nodes: 286.726
No. of variables tried at each split: 36
              Total no. of variables: 1241
       Resampling used to grow trees: swor
    Resample size used to grow trees: 555
                            Analysis: RF-C
                              Family: class
                      Splitting rule: entropy *random*
       Number of random split points: 10
                   (OOB) Brier score: 0.04477743
        (OOB) Normalized Brier score: 0.3656823
                           (OOB) AUC: 0.95964316
                      (OOB) Log-loss: 0.64452045
   (OOB) Requested performance error: 0.14920273, 0.14864865, 0.02873563, 0.01606426, 0.76, 1, 0.09767442, 0.73076923
                  predicted
      (OOB) Misclassification rate: 0.1480638
   Brier: 0.12244898   Normalized Brier: 1   Log-loss: 1.94591015

# --- Slide 42: The run.rfsrc function for an overview --- (Code block 1)
run.rfsrc(y~., data = glioma)

# --- Slide 45: Survival example: PBC Mayo Clinic --- (Code block 1)
data(pbc, package = "survival")
dim(pbc)
[1] 418  20

# --- Slide 46: Survival example: PBC Mayo Clinic --- (Code block 1)
pbc$id <- NULL ## remove the ID
## keep the original competing risk framework for later
## status at endpoint, 0/1/2 for censored, transplant, dead
pbc.cr <- pbc
## convert to right-censoring with death as the event
pbc$status[pbc$status > 0] <- 1
o <- rfsrc(Surv(time, status) ~ ., data = pbc)
                         Sample size: 276
                    Number of deaths: 129
                     Number of trees: 500
           Forest terminal node size: 15
       Average no. of terminal nodes: 14.326
No. of variables tried at each split: 5
              Total no. of variables: 17
       Resampling used to grow trees: swor
    Resample size used to grow trees: 174
                            Analysis: RSF
                              Family: surv
                      Splitting rule: logrank *random*
       Number of random split points: 10
                          (OOB) CRPS: 553.15107271
                   (OOB) stand. CRPS: 0.13198546
   (OOB) Requested performance error: 0.18814768

# --- Slide 48: Split rules --- (Code block 1)
o <- rfsrc(Surv(time, status) ~ ., data = pbc,
                  splitrule="logrank") ## default splitrule
                         Sample size: 276
                    Number of deaths: 129
                     Number of trees: 500
           Forest terminal node size: 15
       Average no. of terminal nodes: 14.326
No. of variables tried at each split: 5
              Total no. of variables: 17
       Resampling used to grow trees: swor
    Resample size used to grow trees: 174
                            Analysis: RSF
                              Family: surv
                      Splitting rule: logrank *random*
       Number of random split points: 10
                          (OOB) CRPS: 553.15107271
                   (OOB) stand. CRPS: 0.13198546
   (OOB) Requested performance error: 0.18814768

# --- Slide 49: Split rules --- (Code block 1)
o <- rfsrc(Surv(time, status) ~ ., data = pbc,
                  splitrule="bs.gradient")
                         Sample size: 276
                    Number of deaths: 129
                     Number of trees: 500
           Forest terminal node size: 15
       Average no. of terminal nodes: 13.226
No. of variables tried at each split: 5
              Total no. of variables: 17
       Resampling used to grow trees: swor
    Resample size used to grow trees: 174
                            Analysis: RSF
                              Family: surv
                      Splitting rule: bs.gradient *random*
       Number of random split points: 10
                          (OOB) CRPS: 570.11311519
                   (OOB) stand. CRPS: 0.13603272
   (OOB) Requested performance error: 0.19299269

# --- Slide 50: Split rules --- (Code block 1)
o <- rfsrc(Surv(time, status) ~ ., data = pbc,
                  splitrule="logrankscore")
                         Sample size: 276
                    Number of deaths: 129
                     Number of trees: 500
           Forest terminal node size: 15
       Average no. of terminal nodes: 13.46
No. of variables tried at each split: 5
              Total no. of variables: 17
       Resampling used to grow trees: swor
    Resample size used to grow trees: 174
                            Analysis: RSF
                              Family: surv
                      Splitting rule: logrankscore *random*
       Number of random split points: 10
                          (OOB) CRPS: 626.32256755
                   (OOB) stand. CRPS: 0.14944466
   (OOB) Requested performance error: 0.19231977

# --- Slide 51: The run.rfsrc function for an overview --- (Code block 1)
run.rfsrc(Surv(time, status) ~ ., data = pbc)


##############################################################################
# Part II
##############################################################################

# --- Slide 4: OOB prediction --- (Code block 1)
13                      (OOB) R squared: 0.89837879
14    (OOB) Requested performance error: 0.01688687

# --- Slide 4: OOB prediction --- (Code block 2)
print(mean((o$yvar - o$predicted.oob)^2))
[1] 0.01688687

# --- Slide 5: Key quantities for classification --- (Code block 1)
o$predicted     --->   inbag estimated probabilities
o$predicted.oob --->   OOB estimated probabilities
o$class         --->   inbag class predictions
o$class.oob     --->   OOB class predictions

# --- Slide 6: OOB classification example: Glioma --- (Code block 1)
o <- rfsrc(y~., data = glioma)
mean(o$class!=o$yvar)
[1] 0
# inbag misclassification is zero!
mean(o$class.oob!=o$yvar)
[1] 0.07061503

# --- Slide 7: Key quantities --- (Code block 1)
o$predicted     --->   inbag estimated probabilities
o$predicted.oob --->   OOB estimated probabilities
o$class         --->   inbag class predictions
o$class.oob     --->   OOB class predictions

# --- Slide 7: Key quantities --- (Code block 2)
o$predicted[1:5,]     # --->   inbag estimated probabilities
Classic-like Codel G-CIMP-high G-CIMP-low LGm6-GBM Mesenchymal-like PA-like
[1,]        0.006 0.002       0.000      0.004    0.084            0.892   0.012
[2,]        0.136 0.008       0.000      0.004    0.014            0.832   0.006
[3,]        0.064 0.004       0.008      0.010    0.018            0.892   0.004
[4,]        0.928 0.008       0.004      0.004    0.002            0.054   0.000
[5,]        0.936 0.000       0.000      0.002    0.000            0.062   0.000
o$predicted.oob[1:5,] # --->   OOB estimated probabilities
Classic-like       Codel G-CIMP-high  G-CIMP-low    LGm6-GBM Mesenchymal-like    PA-like
[1,]   0.01840491 0.006134969  0.00000000 0.012269939 0.257668712        0.6687117 0.03680982
[2,]   0.38857143 0.022857143  0.00000000 0.011428571 0.040000000        0.5200000 0.01714286
[3,]   0.17391304 0.010869565  0.02173913 0.027173913 0.048913043        0.7065217 0.01086957
[4,]   0.81443299 0.020618557  0.01030928 0.010309278 0.005154639        0.1391753 0.00000000
[5,]   0.82222222 0.000000000  0.00000000 0.005555556 0.000000000        0.1722222 0.00000000
o$class[1:5]       #  --->   inbag class predictions
[1] Mesenchymal-like Mesenchymal-like Mesenchymal-like Classic-like     Classic-like
o$class.oob[1:5]   #  --->   OOB class predictions
[1] Mesenchymal-like Mesenchymal-like Mesenchymal-like Classic-like     Classic-like

# --- Slide 8: OOB classification example: Glioma --- (Code block 1)
o <- tune.nodesize(y~., data = glioma)
o$nsize.opt
[1] 3

# --- Slide 8: OOB classification example: Glioma --- (Code block 2)
nodesize =  1    error = 11.95%
nodesize =  2    error = 8.85%
nodesize =  3    error = 8.41%
nodesize =  4    error = 12.83%
nodesize =  5    error = 11.5%
nodesize =  6    error = 14.6%
nodesize =  7    error = 12.83%
nodesize =  8    error = 15.49%
nodesize =  9    error = 14.6%
nodesize =  10    error = 17.26%
nodesize =  15    error = 15.04%
nodesize =  20    error = 18.14%
nodesize =  25    error = 18.14%
nodesize =  30    error = 22.57%
nodesize =  35    error = 27.43%
nodesize =  40    error = 28.32%
nodesize =  45    error = 32.3%
nodesize =  50    error = 34.51%
nodesize =  55    error = 50.88%
nodesize =  60    error = 50.88%
nodesize =  65    error = 50.88%
nodesize =  70    error = 50.88%
nodesize =  75    error = 50.88%
nodesize =  80    error = 50.88%
nodesize =  85    error = 50.88%
nodesize =  90    error = 74.34%
nodesize =  95    error = 74.34%
nodesize =  100    error = 74.34%
nodesize =  105    error = 74.34%
nodesize =  110    error = 74.34%
optimal nodesize: 3

# --- Slide 9: Key quantities for survival --- (Code block 1)
o$time.interest --->   event times (everything keys off this)
o$predicted     --->   inbag estimated mortality
o$predicted.oob --->   OOB estimated mortality
o$survival      --->   inbag survival estimator for each case
o$survival.oob  --->   OOB survival estimator for each case
o$chf          --->    inbag CHF estimator for each case
o$chf.oob      --->    OOB CHF estimator for each case

# --- Slide 10: OOB survival example: PBC Mayo Clinic --- (Code block 1)
o$survival      --->   inbag survival estimator for each case
o$survival.oob  --->   OOB survival estimator for each case

# --- Slide 10: OOB survival example: PBC Mayo Clinic --- (Code block 2)
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

# --- Slide 11: Key quantities --- (Code block 1)
o$time.interest --->   event times (everything keys off this)

# --- Slide 11: Key quantities --- (Code block 2)
o$time.interest[1:5]
[1]  41  51  71  77 110

# --- Slide 11: Key quantities --- (Code block 3)
o$predicted     --->   inbag estimated mortality
o$predicted.oob --->   OOB estimated mortality

# --- Slide 11: Key quantities --- (Code block 4)
o$predicted[1:5]
[1] 200.83450  17.07501  76.31131  57.77577  79.27206
o$predicted.oob[1:5]
[1] 190.04590  28.05044  66.25447  55.03181  72.55308

# --- Slide 11: Key quantities --- (Code block 5)
o$survival      --->   inbag survival estimator for each case
o$survival.oob  --->   OOB survival estimator for each case

# --- Slide 11: Key quantities --- (Code block 6)
dim(o$yvar) ## sample size (complete cases) n = 276
[1] 276   2
length(o$time.interest)
[1] 127
dim(o$survival)      # --->   inbag survival estimator for each case
[1] 276 127
dim(o$survival.oob)  # --->   OOB survival estimator for each case
[1] 276 127

# --- Slide 12: Key quantities --- (Code block 1)
o$chf          --->    inbag CHF estimator for each case
o$chf.oob      --->    OOB CHF estimator for each case

# --- Slide 12: Key quantities --- (Code block 2)
dim(o$chf)
[1] 276 127
dim(o$chf.oob)
[1] 276 127
o$chf[1:5, 1:5]
[,1]         [,2]        [,3]         [,4]         [,5]
[1,] 0.039904941 8.981063e-02 0.103197429 0.1338071668 0.1686493781
[2,] 0.000000000 8.333333e-05 0.000245671 0.0003326275 0.0004976107
[3,] 0.004064919 7.977572e-03 0.012491370 0.0227012085 0.0244150195
[4,] 0.004566626 9.643876e-03 0.013209059 0.0146954141 0.0163487486
[5,] 0.000000000 1.598746e-04 0.003271896 0.0052661647 0.0054040957
o$chf.oob[1:5, 1:5]
[,1]        [,2]         [,3]         [,4]         [,5]
[1,] 0.034459694 0.085894243 0.0978252512 0.1301985027 0.1682733452
[2,] 0.000000000 0.000000000 0.0004719118 0.0004719118 0.0004719118
[3,] 0.004215783 0.007519603 0.0122166452 0.0244321624 0.0264688132
[4,] 0.005733225 0.013259881 0.0155376855 0.0168153866 0.0187680623
[5,] 0.000000000 0.000000000 0.0037021133 0.0057619372 0.0061102479

# --- Slide 12: Key quantities --- (Code block 3)
## plot survival curves for first 10 individuals
matplot(o$time.interest,
        100 * t(o$chf.oob[1:10, ]),
        xlab = "Time", ylab = "Cumulative hazard", type = "l", lty = 1)

# --- Slide 13: Key quantities --- (Code block 1)
plot(o$predicted.oob, rowSums(o$chf.oob), xlab="OOB Mortality", ylab="Sum of OOB CHF")
abline(0,1)

# --- Slide 16: Classification example: Glioma --- (Code block 1)
(OOB) Brier score: 0.02333115
        (OOB) Normalized Brier score: 0.19053769
                           (OOB) AUC: 0.99304797
                      (OOB) Log-loss: 0.34115074
   (OOB) Requested performance error: 0.07061503, 0.06756757, 0.01149425, 0.00803213, 0.52, 0.53658537, 0.04651163, 0.11538462

# --- Slide 16: Classification example: Glioma --- (Code block 2)
tail(o$err.rate, 1)
all   Classic-like      Codel G-CIMP-high G-CIMP-low  LGm6-GBM   Mesenchymal-like   PA-like
[500,] 0.07403189   0.07061503, 0.06756757, 0.01149425, 0.00803213, 0.52, 0.53658537, 0.04651163, 0.11538462

# --- Slide 17: Classification example: Glioma --- (Code block 1)
o <- rfsrc(y~., data = glioma,
           perf.type = "misclass") ## default
                         Sample size: 878
           Frequency of class labels: Classic-like=148, Codel=174, G-CIMP-high=249, G-CIMP-low=25, LGm6-GBM=41, Mesenchymal-like=215, PA-like=26
                     Number of trees: 500
           Forest terminal node size: 1
       Average no. of terminal nodes: 74.302
No. of variables tried at each split: 36
              Total no. of variables: 1241
       Resampling used to grow trees: swor
    Resample size used to grow trees: 555
                            Analysis: RF-C
                              Family: class
                      Splitting rule: gini *random*
       Number of random split points: 10
                   (OOB) Brier score: 0.02333115
        (OOB) Normalized Brier score: 0.19053769
                           (OOB) AUC: 0.99304797
                      (OOB) Log-loss: 0.34115074
   (OOB) Requested performance error: 0.07061503, 0.06756757, 0.01149425, 0.00803213, 0.52, 0.53658537, 0.04651163, 0.11538462

# --- Slide 17: Classification example: Glioma --- (Code block 2)
o <- rfsrc(y~., data = glioma,
           perf.type = "brier")
                         Sample size: 878
           Frequency of class labels: Classic-like=148, Codel=174, G-CIMP-high=249, G-CIMP-low=25, LGm6-GBM=41, Mesenchymal-like=215, PA-like=26
                     Number of trees: 500
           Forest terminal node size: 1
       Average no. of terminal nodes: 74.088
No. of variables tried at each split: 36
              Total no. of variables: 1241
       Resampling used to grow trees: swor
    Resample size used to grow trees: 555
                            Analysis: RF-C
                              Family: class
                      Splitting rule: gini *random*
       Number of random split points: 10
                   (OOB) Brier score: 0.02315138
        (OOB) Normalized Brier score: 0.18906962
                           (OOB) AUC: 0.99397374
                      (OOB) Log-loss: 0.33892075
   (OOB) Requested performance error: 0.18906962, 0.0402637, 0.01401861, 0.02455222, 0.01455572, 0.02340584, 0.06200621, 0.01026732

# --- Slide 18: Classification example: Glioma --- (Code block 1)
err <- data.frame(brier=get.brier.error(o$yvar,o$predicted.oob,FALSE),
                  brier.norm=get.brier.error(o$yvar,o$predicted.oob),
                  log.loss=get.logloss(o$yvar,o$predicted.oob),
                  auc=get.auc(o$yvar,o$predicted.oob),
                  misclass=mean(o$yvar!=o$class.oob))
rownames(err) <- "error"
err.cond <- data.frame(rbind(
  c(err$brier.norm, get.brier.error(o$yvar,o$predicted.oob,TRUE,TRUE)),
  c(err$misclass, get.misclass.error(o$yvar,o$class.oob))))
colnames(err.cond) <- paste0("err.", colnames(o$err.rate))
err.cond <- data.frame(metric=c("brier.norm", "misclass"), err.cond)
rownames(err.cond) <- NULL

# --- Slide 18: Classification example: Glioma --- (Code block 2)
print(t(err))
print(err.cond)

# --- Slide 23: Prediction: canonical example --- (Code block 1)
data(veteran, package = "randomForestSRC")
dim(veteran)
[1]  137   8

# --- Slide 24: Prediction: canonical example --- (Code block 1)
## veteran data (with factors)
data(veteran, package = "randomForestSRC")
veteran2 <- data.frame(lapply(veteran, factor))
veteran2$time <- veteran$time
veteran2$status <- veteran$status
## split the data into unbalanced train/test data (25/75)
## the train/test data have the same levels, but different labels
train <- sample(1:nrow(veteran2), round(nrow(veteran2) * .25))

# --- Slide 24: Prediction: canonical example --- (Code block 2)
summary(veteran2[train,])
 1:18   1: 8     Min.   :  3.00   Min.   :0.0000   60     :7   3      : 7   60     : 3   0 :27
 2:16   2:10     1st Qu.: 29.25   1st Qu.:1.0000   40     :6   2      : 6   66     : 3   10: 7
        3: 9     Median : 53.50   Median :1.0000   80     :6   5      : 3   67     : 3
        4: 7     Mean   :104.29   Mean   :0.9412   70     :4   8      : 3   69     : 3
                 3rd Qu.:140.25   3rd Qu.:1.0000   90     :4   1      : 2   38     : 2
                 Max.   :389.00   Max.   :1.0000   30     :3   4      : 2   48     : 2
                                                   (Other):4   (Other):11   (Other):18

# --- Slide 24: Prediction: canonical example --- (Code block 3)
summary(veteran2[-train,])
 1:51   1:27     Min.   :  1.0   Min.   :0.000   60     :20   4      :17   63     :10   0 :70
 2:52   2:38     1st Qu.: 21.5   1st Qu.:1.000   70     :19   2      :13   62     : 8   10:33
        3:18     Median : 83.0   Median :1.000   80     :18   3      :11   64     : 7
        4:20     Mean   :127.3   Mean   :0.932   30     :11   5      :11   65     : 7
                 3rd Qu.:147.5   3rd Qu.:1.000   50     :11   11     : 5   68     : 5
                 Max.   :999.0   Max.   :1.000   40     :10   12     : 5   70     : 5
                                                 (Other):14   (Other):41   (Other):61

# --- Slide 25: Prediction: canonical example --- (Code block 1)
## train the forest and use this to predict on test data
o <- rfsrc(Surv(time, status) ~ ., veteran2[train, ])
pred <- predict(o, veteran2[-train , ])

# --- Slide 25: Prediction: canonical example --- (Code block 2)
print(o)
                         Sample size: 34
                    Number of deaths: 32
                     Number of trees: 500
           Forest terminal node size: 15
       Average no. of terminal nodes: 1
No. of variables tried at each split: 3
              Total no. of variables: 6
       Resampling used to grow trees: swor
    Resample size used to grow trees: 21
                            Analysis: RSF
                              Family: surv
                      Splitting rule: logrank *random*
       Number of random split points: 10
                          (OOB) CRPS: 57.73879973
                   (OOB) stand. CRPS: 0.14842879
   (OOB) Requested performance error: 0.88246269

# --- Slide 25: Prediction: canonical example --- (Code block 3)
print(pred)
  Sample size of test (predict) data: 103
                Number of grow trees: 500
  Average no. of grow terminal nodes: 1
         Total no. of grow variables: 6
       Resampling used to grow trees: swor
    Resample size used to grow trees: 21
                            Analysis: RSF
                              Family: surv
                                CRPS: 54.3104615
                         stand. CRPS: 0.13961558
         Requested performance error: 0.49749046

# --- Slide 26: Prediction: canonical example --- (Code block 1)
## even harder ... factor level not previously encountered in training
veteran3 <- veteran2[1:3, ]
veteran3$celltype <- factor(c("newlevel", "1", "3"))
pred2 <- predict(o, veteran3)
print(pred2)
Sample size of test (predict) data: 3
Number of grow trees: 500
Average no. of grow terminal nodes: 1
Total no. of grow variables: 6
Resampling used to grow trees: swor
Resample size used to grow trees: 21
Analysis: RSF
Family: surv
CRPS: 60.6330452
stand. CRPS: 0.15586901
Requested performance error: 0.5
## the unusual level is treated like a missing value but is not removed
print(pred2$xvar)
trt celltype karno diagtime age prior
1   1     <NA>    60        7  69     0
2   1        1    70        5  64    10
3   1        3    60        3  38     0

# --- Slide 27: Restore --- (Code block 1)
predict(object, ...)

# --- Slide 28: Restore --- (Code block 1)
o <- rfsrc(y~., data = glioma)
                         Sample size: 878
           Frequency of class labels: Classic-like=148, Codel=174, G-CIMP-high=249, G-CIMP-low=25, LGm6-GBM=41, Mesenchymal-like=215, PA-like=26
                     Number of trees: 500
           Forest terminal node size: 1
       Average no. of terminal nodes: 73.79
No. of variables tried at each split: 36
              Total no. of variables: 1241
       Resampling used to grow trees: swor
    Resample size used to grow trees: 555
                            Analysis: RF-C
                              Family: class
                      Splitting rule: gini *random*
       Number of random split points: 10
                   (OOB) Brier score: 0.02270041
        (OOB) Normalized Brier score: 0.18538666
                           (OOB) AUC: 0.99380046
                      (OOB) Log-loss: 0.33499374
   (OOB) Requested performance error: 0.06719818, 0.04054054, 0.01149425, 0.00803213, 0.52, 0.48780488, 0.05581395, 0.15384615
                  predicted
      (OOB) Misclassification rate: 0.06605923
   Brier: 0.12244898   Normalized Brier: 1   Log-loss: 1.94591015

# --- Slide 28: Restore --- (Code block 2)
p <- predict(o, perf.type = "brier")
  Sample size of test (predict) data: 878
                Number of grow trees: 500
  Average no. of grow terminal nodes: 73.79
         Total no. of grow variables: 1241
       Resampling used to grow trees: swor
                            Analysis: RF-C
                              Family: class
                         Brier score: 0.02270041
              Normalized Brier score: 0.18538666
                                 AUC: 0.99380046
                            Log-loss: 0.33499374
                  predicted
      (OOB) Misclassification rate: 0.06605923
   Brier: 0.12244898   Normalized Brier: 1   Log-loss: 1.94591015

# --- Slide 29: Restore --- (Code block 1)
## create your own estimator for regression
o <- rfsrc(mpg~.,mtcars)
fwt <- predict(o, forest.wt="oob")$forest.wt
yhat <- c(fwt %*% o$yvar)
## compare to the OOB ensemble
print(summary(yhat - o$predicted.oob))
## compare prediction error to OOB ensemble
print(o)
                        Sample size: 32
                     Number of trees: 500
           Forest terminal node size: 5
       Average no. of terminal nodes: 3.476
No. of variables tried at each split: 4
              Total no. of variables: 10
       Resampling used to grow trees: swor
    Resample size used to grow trees: 20
                            Analysis: RF-R
                              Family: regr
                      Splitting rule: mse *random*
       Number of random split points: 10
                     (OOB) R squared: 0.76585425
   (OOB) Requested performance error: 8.50513415
print(mean((yhat - o$yvar)^2))

# --- Slide 33: Survival example: peakVO2 --- (Code block 1)
data(peakVO2, package = "randomForestSRC")
dim(peakVO2)
[1]  2231   41

# --- Slide 34: Survival example: peakVO2 --- (Code block 1)
o <- rfsrc(Surv(ttodead,died)~., peakVO2)
## partial effect for age
plot.variable(o, surv.type = "surv", xvar.names = "age",
              time = 2, partial = TRUE)

# --- Slide 35: Survival example: peakVO2 --- (Code block 1)
## partial effect for age
plot.variable(o, surv.type = "surv", xvar.names = "age",
              smooth.lines = TRUE,
              time = 2, partial = TRUE)

# --- Slide 36: Survival example: peakVO2 --- (Code block 1)
## partial effect for age
plot.variable(o, surv.type = "rel.freq", xvar.names = "age",
              smooth.lines = TRUE,
              partial = TRUE)

# --- Slide 37: Survival example: peakVO2 --- (Code block 1)
## partial effect of peak V02 on mortality
partial.o <- partial(o,
                     partial.type = "mort",
                     partial.xvar = "peak.vo2",
                     partial.values = o$xvar$peak.vo2,
                     partial.time = o$time.interest)
pdta.m <- get.partial.plot.data(partial.o)

# --- Slide 37: Survival example: peakVO2 --- (Code block 2)
## partial effect of peak V02 on survival
pvo2 <- quantile(o$xvar$peak.vo2)
partial.o <- partial(o,
                     partial.type = "surv",
                     partial.xvar = "peak.vo2",
                     partial.values = pvo2,
                     partial.time = o$time.interest)
pdta.s <- get.partial.plot.data(partial.o)

# --- Slide 37: Survival example: peakVO2 --- (Code block 3)
## compare the two plots
par(mfrow=c(1,2))
plot(lowess(pdta.m$x, pdta.m$yhat, f = 2/3),
     type = "l", xlab = "peak VO2", ylab = "adjusted mortality")
rug(o$xvar$peak.vo2)
matplot(pdta.s$partial.time, t(pdta.s$yhat), type = "l", lty = 1,
        xlab = "years", ylab = "peak VO2 adjusted survival")
legend("bottomleft", legend = paste0("peak VO2 = ", pvo2),
       bty = "n", cex = .75, fill = 1:5)


##############################################################################
# Part III
##############################################################################

# --- Slide 5: Different VIMP in the package --- (Code block 1)
importance = c("anti", "permute", "random")
importance = TRUE       -->   anti-VIMP
importance = "permute"  -->   Breiman-Cutler
importance = "random"   -->   random-VIMP

# --- Slide 6: Obtaining VIMP using the package --- (Code block 1)
rfsrc(mpg~., importance="permute")$importance
rfsrc(mpg~., importance="permute", block.size=10)$importance

# --- Slide 6: Obtaining VIMP using the package --- (Code block 2)
predict(obj, importance="permute")$importance
predict(obj, importance="permute", block.size=10)$importance

# --- Slide 6: Obtaining VIMP using the package --- (Code block 3)
vimp(obj, importance="permute")
vimp(obj, importance="permute", block.size=10)$importance

# --- Slide 6: Obtaining VIMP using the package --- (Code block 4)
## paired permutation vimp
obj <- rfsrc(Species~., data=iris)
vimp(obj, obj$xvar.names[1:2], importance="permute", joint=TRUE)$importance
vimp(obj, obj$xvar.names[3:4], importance="permute", joint=TRUE)$importance

# --- Slide 7: General call to vimp --- (Code block 1)
## VIMP for all variables
iris.obj <- rfsrc(Species ~ ., data = iris)
print(vimp(iris.obj, importance = "permute")$importance)

# --- Slide 7: General call to vimp --- (Code block 2)
## joint VIMP
print(vimp(iris.obj, c("Petal.Length", "Petal.Width"), joint = TRUE, importance = "permute")$importance)

# --- Slide 10: Confidence intervals for VIMP --- (Code block 1)
## example using peakVO2
data(peakVO2, package = "randomForestSRC")
o <- rfsrc(Surv(ttodead, died)~., peakVO2, importance="permute")
oo <- subsample(o)
plot.vimp.ci(oo, alpha=.05)

# --- Slide 17: Minimal depth illustration using peakVO2 --- (Code block 1)
md <- max.subtree(o)$order[, 1]
barplot(sort(md),
        las=2, horiz = TRUE, col = "cadetblue3")

# --- Slide 18: Minimal depth illustration using peakVO2 --- (Code block 1)
md <- max.subtree(o)$order[, 1]
barplot(sort(md),
        las=2, horiz = TRUE, col = "cadetblue3")

# --- Slide 18: Minimal depth illustration using peakVO2 --- (Code block 2)
## guide random feature selection with number of times variable splits
xvar.used <- predict(o,
               var.used="all.trees")$var.used
os <- rfsrc(Surv(ttodead, died)~., peakVO2, xvar.wt = xvar.used)
mds <- max.subtree(os)$order[, 1]
barplot(sort(mds),
        las=2, horiz = TRUE, col = "cadetblue3")

# --- Slide 20: VarPro --- (Code block 1)
summary(peakVO2[,c("bun","interval", "peak.vo2")])
 Min.   :  4.322   Min.   :  21.0   Min.   : 4.20
 1st Qu.: 17.000   1st Qu.: 345.0   1st Qu.:12.80
 Median : 23.000   Median : 480.0   Median :15.70
 Mean   : 25.278   Mean   : 503.3   Mean   :16.27
 3rd Qu.: 29.334   3rd Qu.: 641.0   3rd Qu.:19.30
 Max.   :129.000   Max.   :1415.0   Max.   :43.80

# --- Slide 24: VarPro canonical illustration --- (Code block 1)
## varpro canonical call
o <-varpro(Surv(ttodead, died)~., peakVO2)
importance(o)
## cv.varpro canonical call
o.cv <- cv.varpro(Surv(ttodead, died)~., peakVO2)

# --- Slide 24: VarPro canonical illustration --- (Code block 2)
importance(o)

# --- Slide 25: VarPro canonical illustration --- (Code block 1)
## cv.varpro canonical call
o.cv <- cv.varpro(Surv(ttodead, died)~., peakVO2)

# --- Slide 25: VarPro canonical illustration --- (Code block 2)
o.cv
$imp
$imp.conserve
$imp.liberal
$err
[1,] 0.1000000   14 0.3120663 0.007186951
[2,] 0.5265306   13 0.3137940 0.004717065
[3,] 0.7591837   12 0.3141295 0.004068593
[4,] 1.2632653   11 0.3099739 0.003270832
[5,] 1.3020408   10 0.3123732 0.004680203
$zcut
[1] 1.263265
$zcut.conserve
[1] 1.302041
$zcut.liberal
[1] 0.1

# --- Slide 26: VarPro canonical illustration --- (Code block 1)
o <- rfsrc(Surv(ttodead, died)~., peakVO2, importance="permute")
oo <- subsample(o)
plot.vimp.ci(oo, alpha=.05)

# --- Slide 26: VarPro canonical illustration --- (Code block 2)
o.cv <- cv.varpro(Surv(ttodead, died)~., peakVO2)
barplot(o.cv$imp.liberal$z, names.arg=o.cv$imp.liberal$variable,
        las=2, horiz = TRUE, col = "coral2")

# --- Slide 27: VarPro canonical illustration --- (Code block 1)
o <- rfsrc(Surv(ttodead, died)~., peakVO2, importance="permute")
oo <- subsample(o)
plot.vimp.ci(oo, alpha=.05)

# --- Slide 27: VarPro canonical illustration --- (Code block 2)
o.cv <- cv.varpro(Surv(ttodead, died)~., peakVO2)
barplot(o.cv$imp.liberal$z, names.arg=o.cv$imp.liberal$variable,
        las=2, horiz = TRUE, col = "coral2")

# --- Slide 28: VarPro high-dimensional example --- (Code block 1)
data(vdv, package = "randomForestSRC")
dim(vdv)
[1] 78  4707

# --- Slide 29: VarPro high-dimensional example --- (Code block 1)
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

# --- Slide 30: VarPro high-dimensional example --- (Code block 1)
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

# --- Slide 30: VarPro high-dimensional example --- (Code block 2)
$lasso
[1] "AF201951"       "AL080059"
[3] "Contig25991"    "Contig28552_RC"
[5] "NM_000436"      "NM_003748"
[7] "NM_005915"      "NM_006681"
[9] "NM_020974"
$lasso.vimp
 [1] "AL137718"       "Contig25991"
 [3] "Contig28552_RC" "Contig51464_RC"
 [5] "Contig55377_RC" "NM_000436"
 [7] "NM_003239"      "NM_003748"
 [9] "NM_005915"      "NM_006681"
[11] "NM_016448"      "NM_020974"
$lasso.vimp.tree
 [1] "AA555029_RC"    "AF201951"
 [3] "AL080059"       "Contig25991"
 [5] "Contig28552_RC" "Contig55377_RC"
 [7] "NM_000436"      "NM_003748"
 [9] "NM_005915"      "NM_006117"
[11] "NM_006681"      "NM_016448"
[13] "NM_020974"
$lasso.vimp.sparseoff
 [1] "AF201951"       "AF257175"
 [3] "AL080059"       "AL137718"
 [5] "Contig25991"    "Contig28552_RC"
 [7] "Contig40831_RC" "Contig48328_RC"
 [9] "Contig51464_RC" "Contig55377_RC"
[11] "Contig63102_RC" "NM_002916"
[13] "NM_003239"      "NM_003748"
[15] "NM_005915"      "NM_006117"
[17] "NM_006681"      "NM_016448"
[19] "NM_020974"

# --- Slide 32: UVarPro illustration with Iowa housing --- (Code block 1)
## load the data
data(housing, package = "randomForestSRC")
## rough impute
## convert factors to numerical
iowa <- randomForestSRC:::get.na.roughfix(housing)
iowa <- data.frame(data.matrix(iowa))
## uvarpro canonical call
o <- uvarpro(iowa)
print(importance(o))

# --- Slide 33: UVarPro \(s\)-dependence table --- (Code block 1)
## lasso beta values
beta <- get.beta.entropy(o)

# --- Slide 34: UVarPro \(s\)-dependence graph --- (Code block 1)
##  beta <- get.beta.entropy(o)
## sdependent  graph
sdependent(beta)


##############################################################################
# Part IV
##############################################################################

# --- Slide 10: Classification example: Glioma --- (Code block 1)
data(glioma, package = "varPro")
table(glioma$y)
Classic-like            Codel      G-CIMP-high       G-CIMP-low         LGm6-GBM Mesenchymal-like          PA-like
148              174              249               25               41              215               26
## make a super majority class
class.combine <- c("Classic-like", "Codel", "G-CIMP-high", "Mesenchymal-like")
ynew <- factor(1 * !is.element(glioma$y, class.combine))
## replace y with the new super class
glioma2 <- glioma
glioma2$y <- ynew
table(glioma2$y)
0   1
786  94

# --- Slide 11: Imbalanced classification: Glioma --- (Code block 1)
## standard RF classifier
o1 <- rfsrc(y~.,glioma2)
print(o1)
                         Sample size: 880
           Frequency of class labels: 0=786, 1=94
                     Number of trees: 500
           Forest terminal node size: 1
       Average no. of terminal nodes: 29.802
No. of variables tried at each split: 36
              Total no. of variables: 1241
       Resampling used to grow trees: swor
    Resample size used to grow trees: 556
                            Analysis: RF-C
                              Family: class
                      Splitting rule: gini *random*
       Number of random split points: 10
                    Imbalanced ratio: 8.3617
                   (OOB) Brier score: 0.03485757
        (OOB) Normalized Brier score: 0.13943029
                           (OOB) AUC: 0.98882031
                      (OOB) Log-loss: 0.12614254
                        (OOB) PR-AUC: 0.92976788
                        (OOB) G-mean: 0.750886
   (OOB) Requested performance error: 0.04659091, 0, 0.43617021
          predicted
      (OOB) Misclassification rate: 0.04772727
   Brier: 0.25   Normalized Brier: 1   Log-loss: 0.69314718

# --- Slide 12: Imbalanced classification: Glioma --- (Code block 1)
## RFQ classifier
o2 <- imbalanced(y~.,glioma2)
print(o2)
                         Sample size: 880
           Frequency of class labels: 0=786, 1=94
                     Number of trees: 3000
           Forest terminal node size: 1
       Average no. of terminal nodes: 26.6797
No. of variables tried at each split: 36
              Total no. of variables: 1241
       Resampling used to grow trees: swor
    Resample size used to grow trees: 556
                            Analysis: RFQ
                              Family: class
                      Splitting rule: auc *random*
       Number of random split points: 10
                    Imbalanced ratio: 8.3617
                   (OOB) Brier score: 0.03394608
        (OOB) Normalized Brier score: 0.13578431
                           (OOB) AUC: 0.99057983
                      (OOB) Log-loss: 0.12099248
                        (OOB) PR-AUC: 0.94056031
                        (OOB) G-mean: 0.93762192
   (OOB) Requested performance error: 0.06237808
          predicted
      (OOB) Misclassification rate: 0.1079545
   Brier: 0.25   Normalized Brier: 1   Log-loss: 0.69314718

# --- Slide 14: Imbalanced classification: Glioma --- (Code block 1)
## BRF classifier
o3 <- imbalanced(y~.,glioma2, method = "brf")
print(o3)
                         Sample size: 880
           Frequency of class labels: 0=786, 1=94
                     Number of trees: 3000
           Forest terminal node size: 1
       Average no. of terminal nodes: 15.208
No. of variables tried at each split: 36
              Total no. of variables: 1241
       Resampling used to grow trees: swr
    Resample size used to grow trees: 188
                            Analysis: RF-C
                              Family: class
                      Splitting rule: auc *random*
       Number of random split points: 10
                    Imbalanced ratio: 8.3617
                   (OOB) Brier score: 0.04790004
        (OOB) Normalized Brier score: 0.19160015
                           (OOB) AUC: 0.9861269
                      (OOB) Log-loss: 0.1954276
                        (OOB) PR-AUC: 0.91991245
                        (OOB) G-mean: 0.91159495
   (OOB) Requested performance error: 0.08840505
          predicted
      (OOB) Misclassification rate: 0.04659091
   Brier: 0.25   Normalized Brier: 1   Log-loss: 0.69314718

# --- Slide 15: Imbalanced classification: Glioma --- (Code block 1)
## BRF - brute force
o4 <- rfsrc(y~.,glioma2,
            case.wt = randomForestSRC:::make.wt(glioma2$y),
            sampsize = randomForestSRC:::make.size(glioma2$y))
print(o4)
                         Sample size: 880
           Frequency of class labels: 0=786, 1=94
                     Number of trees: 500
           Forest terminal node size: 1
       Average no. of terminal nodes: 19.308
No. of variables tried at each split: 36
              Total no. of variables: 1241
       Resampling used to grow trees: swor
    Resample size used to grow trees: 188
                            Analysis: RF-C
                              Family: class
                      Splitting rule: gini *random*
       Number of random split points: 10
                    Imbalanced ratio: 8.3617
                   (OOB) Brier score: 0.05228461
        (OOB) Normalized Brier score: 0.20913846
                           (OOB) AUC: 0.985775
                      (OOB) Log-loss: 0.20764199
                        (OOB) PR-AUC: 0.92327639
                        (OOB) G-mean: 0.9413532
   (OOB) Requested performance error: 0.05454545, 0.05343511, 0.06382979
          predicted
      (OOB) Misclassification rate: 0.05681818
   Brier: 0.25   Normalized Brier: 1   Log-loss: 0.69314718

# --- Slide 16: Imbalanced classification: Glioma --- (Code block 1)
## gmean variable importance with ci
o2 <- imbalanced(y~.,glioma2, importance="permute", block.size=20)
oo2 <- subsample(o2)
plot.subsample(oo2)

# --- Slide 20: Competing risk example: PBC Mayo Clinic --- (Code block 1)
data(pbc, package = "survival")
pbc$id <- NULL ## remove the ID
## status at endpoint, 0/1/2 for censored, transplant, dead
pbc.cr <- pbc

# --- Slide 21: Competing risk example: PBC Mayo Clinic --- (Code block 1)
## canonical example: default Gray's splitting-rule
o <- rfsrc(Surv(time, status) ~ ., pbc)
                         Sample size: 276
                    Number of events: 1=18, 2=111
                     Number of trees: 500
           Forest terminal node size: 15
       Average no. of terminal nodes: 13.272
No. of variables tried at each split: 5
              Total no. of variables: 17
       Resampling used to grow trees: swor
    Resample size used to grow trees: 174
                            Analysis: RSF
                              Family: surv-CR
                      Splitting rule: logrankCR *random*
       Number of random split points: 10
   (OOB) Requested performance error: 0.19981499, 0.1685511

# --- Slide 22: event specific and non-event specific variable selection --- (Code block 1)
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

# --- Slide 23: event specific and non-event specific variable selection --- (Code block 1)
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

# --- Slide 23: event specific and non-event specific variable selection --- (Code block 2)
md  vimp1   vimp2

# --- Slide 24: CIF stratified by edema --- (Code block 1)
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

# --- Slide 25: The run.rfsrc function for an overview --- (Code block 1)
## tip!!! perform the same analysis as above with one line
run.rfsrc(Surv(time, status) ~ ., pbc, ntree=1000, alpha=.10)

# --- Slide 27: Partial plot --- (Code block 1)
pbc.cr$time <- pbc.cr$time/365
## target = an integer value between 1 and J indicating the event of interest
plot.variable(o.log1, target = 1,
              xvar.names = "age", partial = TRUE, smooth.lines = TRUE)

# --- Slide 28: Partial plot --- (Code block 1)
## target = an integer value between 1 and J indicating the event of interest
## where J is the number of event types
plot.variable(o.log1, target = 1,
              xvar.names = "age", partial = TRUE, smooth.lines = TRUE)

# --- Slide 28: Partial plot --- (Code block 2)
## target = an integer value between 1 and J indicating the event of interest
## where J is the number of event types
plot.variable(o.log2, target = 2,
              xvar.names = "age", partial = TRUE, smooth.lines = TRUE)

# --- Slide 30: Multivariate example: Nutrigenomic Study --- (Code block 1)
data(nutrigenomic, package = "randomForestSRC")
names(nutrigenomic)
[1]  "lipids"   "genes"    "diet"     "genotype"
dim(nutrigenomic$lipids)
[1]  40 21
dim(nutrigenomic$genes)
[1]  40 120

# --- Slide 30: Multivariate example: Nutrigenomic Study --- (Code block 2)
## diet and genotype are factors
head(nutrigenomic$diet)
[1]  lin  sun  sun  fish ref  coc
Levels: coc fish lin ref sun
head(nutrigenomic$genotype)
[1]  wt wt wt wt wt wt
Levels: ppar wt

# --- Slide 31: Multivariate example: Nutrigenomic Study --- (Code block 1)
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

# --- Slide 31: Multivariate example: Nutrigenomic Study --- (Code block 2)
print(o)
                         Sample size: 40
                     Number of trees: 500
           Forest terminal node size: 5
       Average no. of terminal nodes: 4.774
No. of variables tried at each split: 41
              Total no. of variables: 122
       Resampling used to grow trees: swor
    Resample size used to grow trees: 25
                            Analysis: mRF-R
                              Family: regr+
                      Splitting rule: mahalanobis *random*
       Number of random split points: 10
   (OOB) Requested performance error: 9.828, 0.554, 8.29, 4.695, 0.059, 7.816, 42.496, 9.231, 0.015, 0.434, 63.52, 0.765, 0.034, 0.158, 16.66, 0.058, 0.392, 30.194, 0.029, 4.556, 0.632, 15.793

# --- Slide 32: Multivariate example: Nutrigenomic Study --- (Code block 1)
## acquire the error rate for each of the 21-coordinates
## standardize to allow for comparison across coordinates
serr <- get.mv.error(o, standardize = TRUE)

# --- Slide 32: Multivariate example: Nutrigenomic Study --- (Code block 2)
serr

# --- Slide 32: Multivariate example: Nutrigenomic Study --- (Code block 3)
## acquire standardized VIMP
svimp <- get.mv.vimp(obj, standardize = TRUE)

# --- Slide 32: Multivariate example: Nutrigenomic Study --- (Code block 4)
head(svimp)

# --- Slide 34: Split rules --- (Code block 1)
o <- rfsrc(get.mv.formula(colnames(ydta)),
             data.frame(ydta, xdta),
             importance=TRUE, nsplit = 10,
             splitrule = "mahalanobis")
print(o)
                         Sample size: 40
                     Number of trees: 500
           Forest terminal node size: 5
       Average no. of terminal nodes: 4.754
No. of variables tried at each split: 41
              Total no. of variables: 122
       Resampling used to grow trees: swor
    Resample size used to grow trees: 25
                            Analysis: mRF-R
                              Family: regr+
                      Splitting rule: mahalanobis *random*
       Number of random split points: 10
   (OOB) Requested performance error: 9.68, 0.553, 8.162, 4.763, 0.06, 7.737, 42.574, 9.289, 0.015, 0.442, 61.226, 0.766, 0.033, 0.156, 16.106, 0.054, 0.383, 30.393, 0.03, 4.733, 0.609, 15.203

# --- Slide 35: Split rules --- (Code block 1)
o2 <- rfsrc(get.mv.formula(colnames(ydta)),
              data.frame(ydta, xdta),
              importance=TRUE, nsplit = 10)
print(o2)
                         Sample size: 40
                     Number of trees: 500
           Forest terminal node size: 5
       Average no. of terminal nodes: 4.454
No. of variables tried at each split: 41
              Total no. of variables: 122
       Resampling used to grow trees: swor
    Resample size used to grow trees: 25
                            Analysis: mRF-R
                              Family: regr+
                      Splitting rule: mv *random*
       Number of random split points: 10
   (OOB) Requested performance error: 7.119, 0.387, 6.725, 3.527, 0.044, 5.519, 29.603, 5.488, 0.016, 0.28, 41.112, 0.757, 0.023, 0.101, 10.656, 0.036, 0.312, 27.217, 0.027, 3.551, 0.52, 13.606

# --- Slide 36: Split rules --- (Code block 1)
## compare standardized VIMP for top 25 variables
imp <- data.frame(mahalanobis = rowMeans(get.mv.vimp(o,  standardize = TRUE)),
                  default     = rowMeans(get.mv.vimp(o2, standardize = TRUE)))

# --- Slide 36: Split rules --- (Code block 2)
print(100 * imp[order(imp[,"mahalanobis"], decreasing = TRUE)[1:25], ])

# --- Slide 37: The run.rfsrc function for an overview --- (Code block 1)
library(randomForestSRC.run)
run.rfsrc(get.mv.formula(colnames(ydta)), data.frame(ydta, xdta))

# --- Slide 42: OTFI --- (Code block 1)
data(pbc, package = "randomForestSRC")
pbc.impute <- impute(Surv(days, status)~.,pbc)

# --- Slide 42: OTFI --- (Code block 2)
data(pbc, package = "randomForestSRC")
pbc.impute <- impute(data=pbc)

# --- Slide 43: missForest and mForest --- (Code block 1)
data(pbc, package = "randomForestSRC")
pbc.impute <- impute(data=pbc, mf.q=1)

# --- Slide 43: missForest and mForest --- (Code block 2)
data(housing, package = "randomForestSRC")
housing.impute <- impute(data=housing, mf.q=.5)
housing.impute <- impute(data=housing, mf.q=40)

