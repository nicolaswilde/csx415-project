source("..\\src\\SalaryPred_lm.R")

salaryPredTest <- function() {

    # load 2017/18 regular season player stats per game
    player_stats_per_game_1718 <- read.csv("..\\data\\PlayerStatsPerGame1718.csv", stringsAsFactors=F)
    player_stats_per_game_1718 <- player_stats_per_game_1718[, c("Player", "Age", "G", "GS", "MP", "FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "eFGP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS")]
    # print(player_stats_per_game_1718)

    model = salaryPredTrain(mplot=TRUE)
    result = salaryPred(model, player_stats_per_game_1718)
    print(result)
}

salaryPredTest()
