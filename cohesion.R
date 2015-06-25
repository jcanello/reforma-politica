library(dplyr)
library(plyr)
library(reshape2)
source("functions.R")  

#load data
votes<-read.csv("data/brvotes2015.csv")
gov.orient<-read.csv("data/brleaders2015.csv")

#Absolute cohesion
coesao.tot <- votes %>%
	group_by(party) %>%
	summarise_each(funs(rice.abs), contains("vote"))

#Relative cohesion
coesao <- votes %>%
	group_by(party) %>%
	summarise_each(funs(rice.rel), contains("vote"))

# organize gov orientaton
gov.orient[gov.orient==8] <- NA
gov.orient <- gov.orient[1,-1]
gov.orient <- t(gov.orient[,!is.na(gov.orient)])
filtro.gov <- rownames(gov.orient)

#select votes with gov orientation
votes.gov <- select(votes, one_of(filtro.gov)) 

# creates a data.frame for gov support
with.gov <- matrix(NA,nrow(votes.gov),ncol(votes.gov))
for(i in 1:ncol(votes.gov)){
	with.gov[,i] <- votes.gov[,i] == gov.orient[i]
}
with.gov <- as.data.frame(with.gov)
colnames(with.gov) <- gsub(pattern = "vote.", x = filtro.gov, replacement = "apoio.")

#total votes by deputy
tot.ind <- as.data.frame(t(apply(votes[,-1:-4],1,totais)))
names(tot.ind) <- c("sim","nao","abs","falta","obs","pres","total")

#total votes by vote
tot.bill <- as.data.frame(t(apply(votes[,-1:-4],2,totais)))
names(tots) <- c("sim","nao","abs","falta","obs","pres","total")

#total votes gov bills by deputy
tot.gov.ind <- as.data.frame(t(apply(votes.gov,1,totais)))
names(tot.gov.ind) <- c("gsim","gnao","gabs","gfalta","gobs","gpres","gtotal")

#support by deputy
apoio.ind <- as.data.frame(t(apply(votes.gov,1,apoio)))
names(apoio.ind) <- c("segue","vota","apoio")

#combine data.frames
legis <- cbind(votes[,1:4],tot.ind,tot.gov.ind,apoio.ind,with.gov)

#compute support by party
governismo <- legis %>%
	group_by(party) %>%
	summarise_each(funs(apoio.tot), contains("apoio."))


#Save as csv
write.csv(coesao, "coesao.csv")
write.csv(coesao.tot, "coesaotot.csv")
write.csv(legis, "apoio_individual.csv")
write.csv(governismo, "apoio_abs_partidos.csv")



# Totals for plots
sims <- votes %>%
	group_by(party) %>%
	summarise_each(funs(sum(.==1, na.rm = TRUE)), contains("vote"))
sims <- melt(sims,id=c("party"), variable.name = "vote", value.name = "sim")

naos <- votes %>%
	group_by(party) %>%
	summarise_each(funs(sum(.==2, na.rm = TRUE)), contains("vote"))
naos <- melt(naos,id=c("party"), variable.name = "vote", value.name = "nao")

abs <- votes %>%
	group_by(party) %>%
	summarise_each(funs(sum(.==3, na.rm = TRUE)), contains("vote"))
abs <- melt(abs,id=c("party"), variable.name = "vote", value.name = "abs")

faltas <- votes %>%
	group_by(party) %>%
	summarise_each(funs(sum(.==4, na.rm = TRUE)), contains("vote"))
faltas <- melt(faltas,id=c("party"), variable.name = "vote", value.name = "falta")

obs <- votes %>%
	group_by(party) %>%
	summarise_each(funs(sum(.==5, na.rm = TRUE)), contains("vote"))
obs <- melt(obs,id=c("party"), variable.name = "vote", value.name = "obs")

tot <- votes %>%
	group_by(party) %>%
	summarise_each(funs(n()), contains("vote"))
tot <- melt(tot,id=c("party"), variable.name = "vote", value.name = "tot")


tot.list = list(sims,naos,abs,faltas,obs,tot)
totals <- join_all(tot.list)

desc <- read.csv("data/data.voteDescription2015.csv", encoding = "latin1")
desc$vote <- paste("vote.", desc$orig.vote, sep ="")
desc <- desc[, c("item", "vote")]

totals <- merge(totals, desc)


tots <- subset(totals, tot >= 8)
tots <- arrange(tots,desc(tot))
tots <- tots[,-8]
tots <- melt(tots,id=c("party", "vote", "item"))


write.csv(tots, "data/tots.csv")
