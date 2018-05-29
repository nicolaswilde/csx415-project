#' predict salary according to player's performance
#' @import randomForest
#' @param player: player name
#' @return salary prediction(in dollar)
#' @export

salaryPred <- function(player) {
    #library(randomForest)

    # player_stats_per_game_1718 <- read.csv("..\\data\\PlayerStatsPerGame1718.csv", stringsAsFactors=F)
    player_data <- subset(player_stats_per_game_1718, Player==player)

    salary_pred <- stats::predict(salary_model, player_data)

    return(unname(salary_pred))
}
