# NBAProject-v05252018

## version

May 25, 2018


## log

### Apr 17, 2018

Random forest algorithm has been accomplished in salary prediction and game result prediction.

Team quality prediction is based on game result prediction and is accomplished too.

Signing and trade proposal part is still waiting to be done.

### Apr 24, 2018

Random forest algorithm has been accomplished in the last version v04172018.
This week I optimized the first part, salary prediction.
Because of the existence of salary cap, there are huge gaps between contracts signed in different years.
Therefore, I calculate the conversion salary under salary cap in 2018-19 and use the conversion salary to train model.
The randomForest-based codes are located in /src/xxx_rf.R.

However, assignment of this week requires me to try lm and CART algorithm, which is poorer than the current random forest algorithm.
I just simply replace the algorithm to finish the assignment.
The lm-based codes are located in /src/xxx_lm.R and the rpart codes are located in /src/xxx_rpart.R.

Signing and trade proposal part is still waiting to be done.

### May 6, 2018

Package "devtools" is used to build my own package "NBATools", which located in /pkgs/NBATools.

How to install "NBATools"?

- Use RStudio

    - setwd("yourpath/csx415-project\NBAProject-v05062018\pkgs\NBATools")

    - library(devtools)

    - install(".")

- Use Rscript

    - cd yourpath/csx415-project\NBAProject-v05062018\pkgs\NBATools

    - Rscript setup.R

Simple test has been designed to test package "NBATools", you can test

- Use Rstudio

    - setwd("yourpath/csx415-project\NBAProject-v05062018\pkgs\NBATools")

    - library(devtools)

    - test()

### May 25, 2018

Finish Part4 Free-Agent Signing Proposal and Part5 Trade proposal

Add function freeAgentProp() and tradeProp() to package "NBATools"

Finish deployment, which located in /deploy folder

Redo model measurement, which located in /deploy/project-performance.Rmd

## layout

From this version, ProjectTemplate is used.

However, I do not like 'RStudio + ProjectTemplate' management mode.
Therefore, I only use ProjectTemplate to create the project layout and I never use the other functions provided in ProjectTemplate.

/pkgs folder contains:

- package "NBATools". You can find the install instruction in log on May 6, 2018. A test demo is located in /pkgs/NBATools/tests/testthat/test.R

/data folder contains:

- All datasets for training

/src folder contains:

- All .R source, including 'SalaryPred_xxx.R', 'GamePred_xxx.R', 'TeamQualityPred_xxx.R', 'SigningProposal_xxx.R', and 'TradeProposal_xxx.R'.
Each .R file has 3 version: linear model(lm), CART(rpart), and random forest(rf).

- A R notebook, 'NBAProject.Rmd', which includes all the source code and shows the project result

- A html file, 'NBAProject.nb.html', which is the product of 'NBAProject.Rmd'

- Actually, the codes in /src are just experiments, the final version codes are located in /pkgs and the model measurement are located in /report/project-performance.Rmd

/reports folder contains

- problem-formal-statement.Rmd (Assignment 1)

- project-performance.Rmd (Assignment 2)

And the html outputs of those R markdown / notebook files.
