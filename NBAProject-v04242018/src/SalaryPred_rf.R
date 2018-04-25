library(randomForest)

# use 2017/18 data to train
# input:
#     null
# output:
#     random forest model
salaryPredTrain <- function(mplot=FALSE) {

    # load 2017/18 salary
    salary <- read.csv("..\\data\\PlayerSalary.csv", stringsAsFactors=F)
    salary_1718 <- salary[, c("Player", "Conversion1718")]
    # print(salary_1718)

    # load 2017/18 regular season player stats per game
    player_stats_per_game_1718 <- read.csv("..\\data\\PlayerStatsPerGame1718.csv", stringsAsFactors=F)
    player_stats_per_game_1718 <- player_stats_per_game_1718[, c("Player", "Age", "G", "GS", "MP", "FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "eFGP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS")]
    # print(player_stats_per_game_1718)

    # merge salary and performance
    salary_data <- merge(salary_1718, player_stats_per_game_1718, by="Player")
    # print(salary_data)

    # train model: random forest
    salary_model <- randomForest(Conversion1718~Age+G+GS+MP+FG+FGA+FGP+X3P+X3PA+X3PP+X2P+X2PA+X2PP+eFGP+FT+FTA+FTP+ORB+DRB+TRB+AST+STL+BLK+TOV+PF+PTS, data=salary_data)
    # print(importance(salary_model))
    # print(salary_model)
    if (mplot=TRUE) {
        plot(salary_model)
    }
    
    return(salary_model)
}

# predict salary with given model and data
# input:
#     model: random forest model
#     data: c("Player", "Age", "G", "GS", "MP", "FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "eFGP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS")
# output:
#     predicted salary: c("Player", "SalaryPred")
salaryPred <- function(model, data) {

    # predict salary by random forest model
    salary_pred <- predict(model, data)
    salary_pred_name <- data[, c("Player")]
    salary_pred <- data.frame(Player=salary_pred_name, SalaryPred=salary_pred)
    salary_pred <- salary_pred[order(-salary_pred$SalaryPred),]
    return(salary_pred)
}
