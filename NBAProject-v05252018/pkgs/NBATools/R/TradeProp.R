#' provide proposal of a certain trade
#' @param team_bt (team before trade, list of players)
#' @param team_at (team after trade, list of players)
#' @param accuracy (default 1000)
#' @return no return
#' @export

tradeProp <- function(team_bt, team_at, accuracy=1000) {

  quality_bt <- teamQualityPred(team_bt, accuracy)
  quality_at <- teamQualityPred(team_at, accuracy)

  change <- quality_at - quality_bt
  print("Trade score:")

  if(change < -20) {
      print("D")
  } else if(change < -10) {
      print("C")
  } else if(change < 0) {
      print("B")
  } else if(change < 10) {
      print("A")
  } else if(change <20 ) {
      print("S")
  } else {
      print("S+")
  }
}
