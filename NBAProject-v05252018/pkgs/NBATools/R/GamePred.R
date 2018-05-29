#' predict game result with team and oppteam
#' @import randomForest
#' @param team: c(player names)
#' @param opp_team: c(player names in opposite team)
#' @return game result prediction: W / L
#' @export

gamePred <- function(team, opp_team) {
    #library(randomForest)

    team_stats = playersToTeamData(team)
    opp_team_stats = playersToTeamData(opp_team)
    pred_data = data.frame(team_stats, opp_team_stats)

    game_pred <- stats::predict(game_model, pred_data)

    return(game_pred)
}
