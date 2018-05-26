library(dplyr)
batting <- read.csv('Batting.csv')
sal <- read.csv('Salaries.csv')

head(batting)
str(batting)
head(batting$AB)
head(batting$X2B)

batting$BA <- batting$H / batting$AB
tail(batting$BA)

batting$OBP <- (batting$H + batting$BB + batting$HBP) / (batting$AB + batting$BB + batting$HBP + batting$SF)
tail(batting$OBP)

batting$X1B <- batting$H - batting$X2B - batting$X3B - batting$HR
batting$SLG <- ((batting$X1B) + (2 * batting$X2B) + (3 * batting$X3B) + (4 * batting$HR)) / (batting$AB)
str(batting)



summary(batting)

batting <- subset(batting, yearID>=1985)

summary(batting)

combo <- merge(batting,sal,by = c('playerID','yearID'))

summary(combo)

lost_players <- subset(combo, playerID %in% c('giambja01','damonjo01',
                                            'saenzol01'))
lost_players <- subset(lost_players, yearID==2001)
summary(lost_players)
lost_players <- select(lost_players,playerID,H,X2B,X3B,HR,OBP,SLG,BA,AB)


rem_players <- subset(combo,!playerID %in% c('giambja01','damonjo01',
                                             'saenzol01'))
rem_players <- subset(rem_players, yearID==2001)
rem_players <- select(rem_players,playerID,salary,HR,OBP,AB)


## we need to select 3 replacements for the lost players from the remaining players 
#3Conditions are: 
#The total combined salary of the three players can not exceed 15 million dollars.
#Their combined number of At Bats (AB) needs to be equal to or greater than the lost players.
#Their mean OBP had to equal to or greater than the mean OBP of the lost players
#This corresposnds to having sum of AB > 1469 and sum of OBP> 1.091


#First let us plot the salaries to see how they look like

library(ggplot2)
ggplot(rem_players,aes(x=OBP,y=salary)) + geom_point(aes(color=AB))

#From the graph we can see there are many players who have an OBP of at least 0.25 and have salary less than
#7.5 million and also have an AB greater than 500. These would be our ideal players

rem_players <- filter(rem_players,salary<7500000,OBP>0.25,AB>500)

#arranging the players in descending order of OBP,AB and increasing order of Salary, we get
buy_list <- arrange(rem_players,salary,desc(OBP),desc(AB))
head(buy_list,10)

#It is recommended to buy the following players at their salary:
#pujolal01 200000
#eckstda01 200000
#mientdo01 215000

#Of course, Depending on the availiability of players and budget, it is recommended to buy players from the given list.
buy_list
