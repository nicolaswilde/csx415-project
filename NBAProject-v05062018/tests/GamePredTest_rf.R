source("..\\src\\GamePred_rf.R")


gamePredTest <- function() {

    # load 3 chars team id
    team_list <- read.csv("..\\data\\TeamList.csv", stringsAsFactors=F)
    # print(team_list)

    # load 2017/18 regular season team stats per game
    team_stats_per_game_1718 <- read.csv("..\\data\\TeamStatsPerGame1718.csv", stringsAsFactors=F)
    team_stats_per_game_1718 <- team_stats_per_game_1718[, c("Team", "FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS")]
    # print(team_stats_per_game_1718)

    # biuld test data
    game_pred_data = data.frame()
    for (i in 1:30) {
        team_id <- team_list[,1][i]
        team_data <- subset(team_stats_per_game_1718, Team==team_id, select=c("FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS"))
        for (j in 1:30) {
            if (i != j) {
                opp_team_id <- team_list[,1][j]
                opp_team_data <- subset(team_stats_per_game_1718, Team==opp_team_id, select=c("FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS"))
                new_game_data <- data.frame(Team=team_id, OppTeam=opp_team_id, team_data[1:21], opp_team_data[1:21])
                game_pred_data <- rbind(game_pred_data, new_game_data)
            }
        }
    }

    model = gamePredTrain(mplot=TRUE)
    result = gamePred(model, game_pred_data)
    print(result)
}

gamePredTest()
