source("..\\src\\GamePred_rpart.R")

# define function which calculate team avg data according to a list of players
playersToTeamData <- function(team){

    # load 2017/18 regular season player stats per game
    player_stats_per_game_1718 <- read.csv("..\\data\\PlayerStatsPerGame1718.csv", stringsAsFactors=F)
    player_stats_per_game_1718 <- player_stats_per_game_1718[, c("Player", "Age", "G", "GS", "MP", "FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "eFGP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS")]
    # print(player_stats_per_game_1718)

    # get individual stats
    players_data <- data.frame()
    for (i in 1:nrow(team)) {
         player_data <- subset(player_stats_per_game_1718, Player==team[,1][i], select=c("MP", "FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS"))
        players_data <- rbind(players_data, player_data)
    }

    # calculate team stats in 240 mins
    total_MP <- sum(players_data[,"MP"])
    factor <- 240 / total_MP
    team_FG <- sum(players_data[,"FG"])*factor
    team_FGA <- sum(players_data[,"FGA"])*factor
    team_FGP <- team_FG / team_FGA
    team_X3P <- sum(players_data[,"X3P"])*factor
    team_X3PA <- sum(players_data[,"X3PA"])*factor
    team_X3PP <- team_X3P / team_X3PA
    team_X2P <- sum(players_data[,"X2P"])*factor
    team_X2PA <- sum(players_data[,"X2PA"])*factor
    team_X2PP <- team_X2P / team_X2PA
    team_FT <- sum(players_data[,"FT"])*factor
    team_FTA <- sum(players_data[,"FTA"])*factor
    team_FTP <- team_FT / team_FTA
    team_ORB <- sum(players_data[,"ORB"])*factor
    team_DRB <- sum(players_data[,"DRB"])*factor
    team_TRB <- sum(players_data[,"TRB"])*factor
    team_AST <- sum(players_data[,"AST"])*factor
    team_STL <- sum(players_data[,"STL"])*factor
    team_BLK <- sum(players_data[,"BLK"])*factor
    team_TOV <- sum(players_data[,"TOV"])*factor
    team_PF <- sum(players_data[,"PF"])*factor
    team_PTS <- sum(players_data[,"PTS"])*factor
    team_data <- data.frame(FG=c(team_FG), FGA=c(team_FGA), FGP=c(team_FGP), X3P=c(team_X3P), X3PA=c(team_X3PA), X3PP=c(team_X3PP), X2P=c(team_X2P), X2PA=c(team_X2PA), X2PP=c(team_X2PP), FT=c(team_FT), FTA=c(team_FTA), FTP=c(team_FTP), ORB=c(team_ORB), DRB=c(team_DRB), TRB=c(team_TRB), AST=c(team_AST), STL=c(team_STL), BLK=c(team_BLK), TOV=c(team_TOV), PF=c(team_PF), PTS=c(team_PTS))

    return(team_data)
}

# define function to predict team quality
teamQualityPred <- function(team, echo=1000) {

    # load 2017/18 regular season player stats per game
    player_stats_per_game_1718 <- read.csv("..\\data\\PlayerStatsPerGame1718.csv", stringsAsFactors=F)
    player_stats_per_game_1718 <- player_stats_per_game_1718[, c("Player", "Age", "Pos", "G", "GS", "MP", "FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "eFGP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS")]
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
    for (i in 1:echo) {
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

    # train model
    model <- gamePredTrain()

    # make prediction
    team_quality_pred <- predict(model, team_quality_pred_data)
    team_quality_pred <- data.frame(Result=team_quality_pred)
    names(team_quality_pred) = c("W", "L")
    return(100 * nrow(subset(team_quality_pred, W>0.5)) / nrow(team_quality_pred))
}
