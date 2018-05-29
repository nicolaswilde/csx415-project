#' provide free agent signing proposal with given team
#' @param team (list of players)
#' @param cap (salary cap, default $121000000, which is the luxury tax line)
#' @param accuracy (default 50, run time is directly proportion to accuracy)
#' @return no return
#' @export

freeAgentProp <- function(team, cap=121000000, accuracy=50) {
  
  player_list <- team
  free_agent_name <- free_agent_list[,1]
  player_list <- setdiff(player_list, free_agent_name)
  
  salary_sum <- 0
  for (i in 1:nrow(data.frame(player_list))) {
    name <- player_list[i]
    salary <- subset(player_salary, Player==name, select=c("X1819"))
    salary_sum <- salary_sum + salary
  }
  salary_sum <- salary_sum[,1][1]
  salary_capacity <- cap - salary_sum
  
  print(paste("The team has a salary space of $", as.character(salary_capacity)))
  print("----------------------------------------")
  
  print("Player list before signing:")
  print(player_list)
  print("----------------------------------------")
  
  free_agent_salary <- c()
  for (i in 1:nrow(data.frame(free_agent_name))) {
    name <- free_agent_name[i]
    salary <- salaryPred(name)
    if(!is.logical(salary)) {
      free_agent_salary <- c(free_agent_salary, salary)
    } else {
      free_agent_salary <- c(free_agent_salary, 0)
    }
  }
  
  free_agent <- data.frame(Player=free_agent_name, Salary=free_agent_salary)
  free_agent <- subset(free_agent, Salary>0 & Salary<=salary_capacity)
  
  ubound <- 15 - nrow(data.frame(player_list))
  lbound <- 12 - nrow(data.frame(player_list))
  
  if(ubound <= 0) {
    print("Cannot sign any free agent")
  }
  
  while(ubound>0) {
    print("Searching...")
    max_player <- -1
    max_quality <- -1
    if(lbound<=0) {
      max_quality <- teamQualityPred(player_list, accuracy)
    }
    if(nrow(free_agent)<=0) {
      print("End signing, no salary space.")
      print("----------------------------------------")
      break
    }
    for(i in 1:nrow(free_agent)) {
      cur_team <- c(player_list, free_agent[i,][1])
      cur_quality <- teamQualityPred(player_list, accuracy)
      if(cur_quality>max_quality) {
        max_quality <- cur_quality
        max_player <- i
      }
    }
    
    if(max_player>=0) {
      new_player <- free_agent[,1][max_player]
      print(paste("Sign", as.character(new_player), "with $", free_agent[,2][max_player]))
      print("----------------------------------------")
      player_list <- c(player_list, as.character(new_player))
      salary_capacity <- salary_capacity - as.numeric(free_agent[max_player,][2])
      print(paste("Remain a salary space of $", salary_capacity))
      free_agent <- subset(free_agent, Salary<=salary_capacity)
    } else {
      print("End signing.")
      print("----------------------------------------")
      break;
    }
    ubound <- ubound - 1
    lbound <- lbound - 1
  }
  
  print("Player list after signing:")
  print(player_list)
}

