library(randomForest)


# use 2017/18 data to train
# input:
#     null
# output:
#     random forest model
gamePredTrain <- function(mplot=FALSE) {

    # load 3 chars team id
    team_list <- read.csv("..\\data\\TeamList.csv", stringsAsFactors=F)
    # print(team_list)

    # load 2017/18 regular season team stats per game
    team_stats_per_game_1718 <- read.csv("..\\data\\TeamStatsPerGame1718.csv", stringsAsFactors=F)
    team_stats_per_game_1718 <- team_stats_per_game_1718[, c("Team", "FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS")]
    # print(team_stats_per_game_1718)

    # biuld dataset according to team game log
    # format: own avg stats, opp avg stats, W/L
    game_data = data.frame()
    for (i in 1:30) {
        team_id <- team_list[,1][i]
        team_data <- subset(team_stats_per_game_1718, Team==team_id, select=c("FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS"))
        team_log <- read.csv(paste("..\\data\\TeamGameLog1718\\", team_id, ".csv", sep=""), stringsAsFactors=F)
        for (j in 1:82) {
            opp_team_id <- team_log[,"Opp"][j]
            opp_team_data <- subset(team_stats_per_game_1718, Team==opp_team_id, select=c("FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS"))
            game_result <- team_log[,"W.L"][j]
            new_game_data <- data.frame(team_data[1:21], opp_team_data[1:21], game_result)
            game_data <- rbind(game_data, new_game_data)
        }
    }
    # print(game_data)

    # train model
    game_model <- randomForest(game_result~., data=game_data)
    # print(importance(game_model))
    # print(game_model)
    if (mplot==TRUE) {
        plot(game_model)
    }

    return(game_model)
}

# predict game result with given model and data
# input:
#     model: random forest model
#     data: data.frame(Team, OppTeam, TeamData[1:21], OppTeamData[1:21])
# output:
#     predicted salary: c("Team", "OppTeam", "gamePred")
gamePred <- function(model, data) {

    # predict game result by random forest model
    game_pred <- predict(model, data)
    game_pred_name <- data[, c("Team", "OppTeam")]
    game_pred <- data.frame(game_pred_name, game_pred)
    #print(game_pred)

    return(game_pred)
}
