#############################################################
##### Ideal point estimation - BR Chamber of Deputies    ####
################ REFORMA POLÍTICA ###########################
#############################################################

library(pscl)
library(wnominate)

#read data for roll call object

# reforma política
info<-read.csv("data/data.voteDescription2015.csv")
votes<-read.csv("data/brvotes2015.csv")
orient<-read.csv("data/brleaders2015.csv")

#cleaning votes for rc object
legis<-votes[,1:4]
colnames(legis) <- c("id","name","party","state")
votes<-votes[,-1:-4]
legis$fullID <- paste(legis$name,legis$party,sep="/")

## recodes 
votes[votes==1] <- 1
votes[votes==2] <- 0
votes[votes==3 | votes==4 | votes==5 | votes==6 | votes==7] <- 9

rc<-rollcall(votes,
              legis.names=legis$fullID,
              legis.data=legis,
              vote.data=info,
              vote.names=info$orig.vote)

resumo.rc <- summary(rc, verbose = T)

# Lopsided
resumo.rc$lopSided

# Legis Tab
resumo.rc$legisTab

# Party Loyalty
resumo.rc$partyLoyalty

# Vote Tab
write.csv(resumo.rc$voteTab, "resumo.csv")

#Run Ideal
ideal2<-ideal(rc,d=2,verbose=TRUE,normalize=TRUE, maxiter=200000,
	      thin = 200, store.item = TRUE)

resumo.id2<-summary(ideal2, verbose=T, include.beta = TRUE)

# Plot with Ideal
plot(ideal2, overlayCuttingPlanes = TRUE)

# Plot with base
plot(resumo.id2$xm, pch = 19)
for(i in 1:nrow(resumo.id2$bm)){
	abline(a=-resumo.id2$bm[i,3]/resumo.id2$bm[i,2],
               b=-resumo.id2$bm[i,1]/resumo.id2$bm[i,2],
               col="blue",lwd=.5)
}

##########################################
###### Orientacoes
ptys<-orient[,1]

#cleaning votes for rc object
orient<-orient[,-1]

## recodes 
orient[orient==1] <- 1
orient[orient==2] <- 0
orient[orient==3] <- 9
orient[orient==4] <- 9
orient[orient==5] <- 9
orient[orient==8] <- 9

rc.o<-rollcall(orient,
              legis.names=ptys,
              vote.data=info,
              vote.names=info$orig.vote)

resumo.rco <- summary(rc.o, verbose = T)

# Run ideal
idealc2<-ideal(rc.o,d=2,verbose=TRUE,normalize=TRUE, maxiter=200000,
	       thin = 200, store.item = TRUE)

res<-summary(idealc2, verbose=T, include.beta = TRUE)


# Plot with ideal
plot(idealc2, overlayCuttingPlanes = TRUE)

# Plot with base
plot(res$xm)
for(i in 1:nrow(res$bm)){
	abline(a=-res$bm[i,3]/res$bm[i,2],
               b=-res$bm[i,1]/res$bm[i,2],
               col="blue",lwd=.5)
}

########## Legislators data

deps <- read.csv("data/camara.csv")[,3:11]
deps$fullID <- paste(deps$nome,deps$partido,sep="/")

x.m <- as.data.frame(resumo.id2$xm)
x.sd <- as.data.frame(resumo.id2$xsd)
x.hdr <- as.data.frame(resumo.id2$xHDR)

points.estimates <- cbind(x.m, x.sd, x.hdr)
points.estimates$fullID <- rownames(points.estimates)

camara <- merge(deps, points.estimates)
names(camara) <- c("fullID", "matricula", "nome", "partido", "uf", "id", "idparlamentar",
		   "urlFoto", "sexo", "email", "xD1", "xD2", "sdD1", "sdD2", "lowerD1", 
		   "upperD1", "lowerD2", "upperD2")

write.csv(camara, "data/camara.csv")

# party means from legislators ideal points
write.csv(resumo.id2$party.quant, "data/party-means.csv")


########## Vote data

bills <- read.csv("data/data.voteDescription2015.csv")

bill.par <- as.data.frame(resumo.id2$bm)
bill.par$orig.vote <- rownames(bill.par)

bills <- merge(bills, bill.par)

write.csv(bills, "data/bills.csv")


########## orient data

p.m <- as.data.frame(res$xm)
p.sd <- as.data.frame(res$xsd)
p.hdr <- as.data.frame(res$xHDR)

p.estimates <- cbind(p.m, p.sd, p.hdr)
names(p.estimates) <- c("xD1", "xD2", "sdD1", "sdD2", "lowerD1", 
		   "upperD1", "lowerD2", "upperD2")

write.csv(p.estimates, "data/partidos.csv")


########## Vote-orient data

bills <- read.csv("data/data.voteDescription2015.csv")

bill.o.par <- as.data.frame(res$bm)
bill.o.par$orig.vote <- rownames(bill.o.par)

bills <- merge(bills, bill.o.par)

write.csv(bills, "data/bills-orient.csv")

