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
