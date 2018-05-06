source("..\\src\\TeamQualityPred_lm.R")


teamQualityPredTest <- function() {

    # load 3 chars team id
    team_list <- read.csv("..\\data\\TeamList.csv", stringsAsFactors=F)
    # print(team_list)

    # load 2017/18 regular season player stats per game
    player_stats_per_game_1718 <- read.csv("..\\data\\PlayerStatsPerGame1718.csv", stringsAsFactors=F)
    player_stats_per_game_1718 <- player_stats_per_game_1718[, c("Player", "Age", "Tm", "Pos", "G", "GS", "MP", "FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "eFGP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS")]
    # print(player_stats_per_game_1718)

    real_team_test_result = data.frame()
    for (i in 1:30) {
        team_id = team_list[,1][i]
        team = subset(player_stats_per_game_1718, Tm==team_id, select=c("Player", "MP"))
        #select 12 players
        team = team[order(-team$MP),][1:12,]
        team = data.frame(Player=team$Player)
        team_quality = teamQualityPred(team, echo=1000)
        team_result = data.frame(Team=team_id, Quality=team_quality)
        real_team_test_result = rbind(real_team_test_result, team_result)
    }
    real_team_test_result = real_team_test_result[order(-real_team_test_result$Quality),]
    print(real_team_test_result)
}

teamQualityPredTest()
