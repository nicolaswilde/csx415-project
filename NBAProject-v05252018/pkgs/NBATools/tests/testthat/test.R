context("NBATools")

test_that("Salary prediction", {
    expect_is(salaryPred("Stephen Curry"), "numeric")
})


warriors = c("Stephen Curry", "Kevin Durant", "Klay Thompson", "Draymond Green", "Andre Iguodala", "Shaun Livingston", "Nick Young", "Zaza Pachulia", "David West", "JaVale McGee", "Omri Casspi", "Kevon Looney", "Damian Jones", "Patrick McCaw", "Jason Thompson", "Jordan Bell")
cavaliers = c("LeBron James", "Kevin Love", "George Hill", "Tristan Thompson", "J.R. Smith", "Jordan Clarkson", "Kyle Korver", "Cedi Osman", "Rodney Hood", "Jose Calderon", "Jeff Green", "Ante Zizic", "Larry Nance", "Okaro White", "Marcus Thornton")
test_that("Game prediction", {
    expect_is(gamePred(warriors, cavaliers), "factor")
})

test_that("Team quality prediction", {
    expect_is(teamQualityPred(warriors), "numeric")
})
