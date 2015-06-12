#### Functions ####

#function to compute absolute rice index
rice.abs <- function(x){
	sim <-	sum(x == 1, na.rm=T)
	nao <-	sum(x == 2, na.rm=T)
	bancada <- sum(!is.na(x))
	rice.tot <- abs(sim - nao)/bancada*100
	return(rice.tot)
}

#function to compute relative rice index
rice.rel <- function(x){
	sim <-	sum(x == 1, na.rm=T)
	nao <-	sum(x == 2, na.rm=T)
	valido <- sum(sim, nao)
	rice.vot <- abs(sim - nao)/valido*100
	return(rice.vot)
}

#function to totalize votes by deputy
totais <- function(x){
	sim <-	sum(x == 1, na.rm=T)
	nao <-	sum(x == 2, na.rm=T)
	abs <-sum(x == 3, na.rm=T)
	falta <- sum(x == 4, na.rm=T)
	obs <- sum(x == 5, na.rm=T)
	pres <- sum(x == 7, na.rm=T)
	tot <- sum(sim,nao,abs,falta,obs,pres)
	tots <- cbind(sim,nao,abs,falta,obs,pres,tot)
	return(tots)
}

#function to compute support raw and rates by deputy
apoio <- function(x){
	segue <-sum(x == TRUE, na.rm=T)
	vota <- sum(!is.na(x))
	apoio <- segue/vota*100
	gov <- cbind(segue,vota,apoio)
	return(gov)
}

#function to compute support rate
apoio.tot <- function(x){
	segue <-sum(x == TRUE, na.rm=T)
	vota <- sum(!is.na(x))
	apoio <- segue/vota*100
	return(apoio)
}

