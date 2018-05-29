#' predict team quality according to player's performance
#' @param team: c(player names)
#' @param accuracy: number of simulating games
#' @return team quality(60 ~ 100)
#' @export

teamQualityPred <- function(team, accuracy=1000) {

    # load 2017/18 regular season player stats per game
    # player_stats_per_game_1718 <- read.csv("..\\data\\PlayerStatsPerGame1718.csv", stringsAsFactors=F)
    # player_stats_per_game_1718 <- player_stats_per_game_1718[, c("Player", "Age", "Pos", "G", "GS", "MP", "FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "eFGP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS")]
    # print(player_stats_per_game_1718)

    # group players by position and starter/substitution
    team_data <- playersToTeamData(team)
    PG1 <- subset(player_stats_per_game_1718, Pos=="PG"&G>50&MP>=25, select=c("Player"))
    PG2 <- subset(player_stats_per_game_1718, Pos=="PG"&G>50&MP>10&MP<25, select=c("Player"))
    SG1 <- subset(player_stats_per_game_1718, Pos=="SG"&G>50&MP>=25, select=c("Player"))
    SG2 <- subset(player_stats_per_game_1718, Pos=="SG"&G>50&MP>10&MP<25, select=c("Player"))
    SF1 <- subset(player_stats_per_game_1718, Pos=="SF"&G>50&MP>=25, select=c("Player"))
    SF2 <- subset(player_stats_per_game_1718, Pos=="SF"&G>50&MP>10&MP<25, select=c("Player"))
    PF1 <- subset(player_stats_per_game_1718, Pos=="PF"&G>50&MP>=25, select=c("Player"))
    PF2 <- subset(player_stats_per_game_1718, Pos=="PF"&G>50&MP>10&MP<25, select=c("Player"))
    C1 <- subset(player_stats_per_game_1718, Pos=="C"&G>50&MP>=25, select=c("Player"))
    C2 <- subset(player_stats_per_game_1718, Pos=="C"&G>50&MP>10&MP<25, select=c("Player"))

    # biuld prediction data
    team_quality_pred_data = data.frame()
    for (i in 1:accuracy) {
        # pick a virtual team randomly
        PG_index1 <- sample(1:nrow(PG1), 1)
        PG_index2 <- sample(1:nrow(PG2), 1)
        SG_index1 <- sample(1:nrow(SG1), 1)
        SG_index2 <- sample(1:nrow(SG2), 1)
        SF_index1 <- sample(1:nrow(SF1), 1)
        SF_index2 <- sample(1:nrow(SF2), 1)
        PF_index1 <- sample(1:nrow(PF1), 1)
        PF_index2 <- sample(1:nrow(PF2), 1)
        C_index1 <- sample(1:nrow(C1), 1)
        C_index2 <- sample(1:nrow(C1), 1)
        opp_players <- c(PG1[,"Player"][PG_index1], PG2[,"Player"][PG_index2], SG1[,"Player"][SG_index1], SG2[,"Player"][SG_index2], SF1[,"Player"][SF_index1], SF2[,"Player"][SF_index2], PF1[,"Player"][PF_index1], PF2[,"Player"][PF_index2], C1[,"Player"][C_index1], C2[,"Player"][C_index2])
        opp_team <- data.frame(Player=opp_players)
        opp_team_data <- playersToTeamData(opp_team)
        new_game_data <- data.frame(team_data, opp_team_data)
        team_quality_pred_data <- rbind(team_quality_pred_data, new_game_data)
    }

    # make prediction
    team_quality_pred <- predict(game_model, team_quality_pred_data)
    team_quality_pred <- data.frame(Result=team_quality_pred)
    score <- 100 * nrow(subset(team_quality_pred, Result=="W")) / nrow(team_quality_pred)

    return(60 + score * 0.4)
}
