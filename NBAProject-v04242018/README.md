# NBAProject-v04242018

## version

Apr 24, 2018


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

## layout

From this version, ProjectTemplate is used.

However, I do not like 'RStudio + ProjectTemplate' management mode.
Therefore, I only use ProjectTemplate to create the project layout and I never use the other functions provided in ProjectTemplate.

/data folder contains:

- All datasets

/src folder contains:

- All .R source, including 'SalaryPred_xxx.R', 'GamePred_xxx.R', 'TeamQualityPred_xxx.R', 'SigningProposal_xxx.R', and 'TradeProposal_xxx.R'.
Each .R file has 3 version: linear model(lm), CART(rpart), and random forest(rf).

- A R notebook, 'NBAProject.Rmd', which includes all the source code and shows the project result

- A html file, 'NBAProject.nb.html', which is the product of 'NBAProject.Rmd'

/tests folder contains:

- Test codes for every .R file in /src folder

/reports folder contains

- problem-formal-statement.Rmd (Assignment 1)

- project-performance.Rmd (Assignment 2)

- project-performance-linear.Rmd (Assignment 3)

- project-performance-rpart.Rmd (Assignment 3)

- NBAProject.Rmd (R notebook of the best version, which is random forest currently)

And the html outputs of those R markdown / notebook files.

## codes management

### individual .R file layout

.R files in /src folder follow the layout:

- definition of functional functions
- definition of main function

.R files in /tests folder follow the layout:

- definition of test function
- call test function

### test .R files

I have never used 'RStudio + ProjectTemplate' to manage the .R files but you can try it.

Execute 'Rscript xxxTest.R' in /tests folder is a valid way to run any xxxTest.R file.

Though there exist function calls among different .R files, .R files dependency has been handled. You can execute 'Rscript xxxTest.R' with any individual test file and I promise it works.

For example, you can run 'Rscript SalaryPredTest.R' in /tests folder to test the SalaryPred model and get predicted salary of all NBA players.

If you would like to write your own test case, you can open a new .R file, then (also take SalaryPred as an example)

```{r}
source('path\\SalaryPred.R')
model = salaryPredTrain()
data = ... # your data, which conform to the format given in SalaryPred.R
result = salaryPred(model, data)
```
