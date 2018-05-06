#' calculate team stats with players stats
#' @param team: c(player names)
#' @return team stats
#' @export

playersToTeamData <- function(team){

    # load 2017/18 regular season player stats per game
    # player_stats_per_game_1718 <- read.csv("..\\data\\PlayerStatsPerGame1718.csv", stringsAsFactors=F)
    # player_stats_per_game_1718_subset <- player_stats_per_game_1718[, c("Player", "Age", "G", "GS", "MP", "FG", "FGA", "FGP", "X3P", "X3PA", "X3PP", "X2P", "X2PA", "X2PP", "eFGP", "FT", "FTA", "FTP", "ORB", "DRB", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS")]
    # print(player_stats_per_game_1718)

    # get individual stats
    team <- data.frame(team)
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
