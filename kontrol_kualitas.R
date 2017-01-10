rm(list = ls())
wulan='Dec'
num_wulan='12'
sasi='2014'
tanggal_akhir='31' #(28,29,30,31)

setwd(sprintf('~/download_mtsat/%s/%s/IR1',sasi,wulan)) # "MTS210013123IR1.pgm.gz"


namadata <- list.files()

intime <- seq(from=as.POSIXct(sprintf("%s-%s-01 00:00:00",sasi,num_wulan), tz="UTC"), 
    to=as.POSIXct(sprintf("%s-%s-%s 23:00:00",sasi,num_wulan,tanggal_akhir), tz="UTC"), by="hour")

tahun <- substr(intime,3,4)
bulan <- substr(intime,6,7)
hari <- substr(intime,9,10)
jam <- substr(intime,12,13)
indeks <- sprintf('MTS2%s%s%s%sIR1.pgm.gz', tahun,bulan,hari,jam)

# <<<<<<<< total data hilang head - middle >>>>>> #
tengah <- function(namadata,indeks){
  selisih <- length(indeks)-length(namadata)
  joz <- indeks
  hasil <- namadata
  k <- 1
  g <- c()
  h <- c()
  yo <- list()
  data_ilang=list()
  while(k <= selisih){
    yo[[k]]=hasil[]
    h <- joz!= yo[[k]]
    data_ilang[[k]]=indeks[min(which(h == TRUE))]

    if(min(which(h == TRUE)) > 1 & min(which(h == TRUE)) < length(yo[[k]]) ){
      hasil <- c(yo[[k]][1:(min(which(h == TRUE))-1)],data_ilang[[k]],
                 yo[[k]][min(which(h == TRUE)):length(yo[[k]])])
    } else if(min(which(h == TRUE)) == 1){
      hasil <- c(data_ilang[[k]], yo[[k]][min(which(h == TRUE)):length(yo[[k]])])
    } else if(min(which(h == TRUE)) == length(yo[[k]])){
      hasil <- c(yo[[k]][1:(min(which(h == TRUE))-1)],data_ilang[[k]])
    }
    k = k+1
  }
  if(data_ilang[length(data_ilang)] != indeks[length(indeks)]){
    urutan_ilang <- data_ilang==data_ilang[[length(data_ilang)]]
    indeks_tambahan <- indeks == data_ilang[length(data_ilang)]
    urutan_ilang <- c(data_ilang[1:min(which(urutan_ilang==TRUE))],
                      indeks[(min(which(indeks_tambahan == TRUE))+1):length(indeks)] )
  } else if(data_ilang[length(data_ilang)] == indeks[length(indeks)]){
    
  }
  return(data_ilang)
}

# <<<<<<<< total_data_hilang_Tail >>>>>>>>> #
 desmon <- tengah(namadata,indeks)

kontrol_data <- function(namadata,indeks){
  selisih <- length(indeks)-length(namadata)
  joz <- indeks
  hasil <- namadata
  k <- 1
  g <- c()
  h <- c()
  yo <- list()
  data_ilang=c()
  while(k <= selisih){
    yo[[k]]=hasil[]
    h <- joz!= yo[[k]]
    data_ilang[k]=indeks[min(which(h == TRUE))]
    
    if(min(which(h == TRUE)) > 1 & min(which(h == TRUE)) < length(yo[[k]]) ){
      hasil <- c(yo[[k]][1:(min(which(h == TRUE))-1)],data_ilang[k],
                 yo[[k]][min(which(h == TRUE)):length(yo[[k]])])
    } else if(min(which(h == TRUE)) == 1){
      hasil <- c(data_ilang[k], yo[[k]][min(which(h == TRUE)):length(yo[[k]])])
    } else if(min(which(h == TRUE)) == length(yo[[k]])){
      hasil <- c(yo[[k]][1:(min(which(h == TRUE))-1)],data_ilang[k])
    }
    k = k+1
  } 
  if(data_ilang[length(data_ilang)] != indeks[length(indeks)]){
    urutan_ilang <- data_ilang==data_ilang[length(data_ilang)]
    indeks_tambahan <- indeks == data_ilang[length(data_ilang)]
    urutan_ilang <- c(data_ilang[1:min(which(urutan_ilang==TRUE))],
                      indeks[(min(which(indeks_tambahan == TRUE))+1):length(indeks)] )
    return(urutan_ilang)
  } 
  return(data_ilang)
}


yosik <- kontrol_data(namadata,indeks)

if(length(namadata)==length(indeks)){
  cat('saya Kliwon AI, perkenankan ane untuk melayani DR NORMAN.\n')
  cat('DR NORMAN alhamdulillah datanya Very Good -- congratulations')
} else if(length(namadata) > length(indeks)){  
  cat('saya Kliwon AI, perkenankan ane untuk melayani DR NORMAN.\n')
  print('Dr NORMAN, datanya berlebihan ') 
} else if(length(yosik) == length(indeks)-length(namadata)){  
  hasil_akhir = yosik
  cat('saya Kliwon AI, perkenankan ane untuk melayani DR NORMAN.\n')
  cat(sprintf('DR NORMAN, Jadi beberapa data yang hilang pada %s %s adalah:\n',wulan,sasi),paste(hasil_akhir,'\n',sep=''))
  write.table(hasil_akhir, sprintf("~/download_mtsat/missing_mtsat/%s_%s.txt",wulan,sasi), sep="\t")
} else if(length(desmon) == length(indeks)-length(namadata)){  
  hasil_akhir = unlist(desmon)
  cat('saya Kliwon AI, perkenankan ane untuk melayani DR NORMAN.\n')
  cat(sprintf('DR NORMAN, Jadi beberapa data yang hilang pada %s %s adalah:\n',wulan,sasi),paste(hasil_akhir,'\n',sep=''))
  write.table(hasil_akhir, sprintf("~/download_mtsat/missing_mtsat/%s_%s.txt",wulan,sasi), sep="\t")
} else{
  print('tidak benar')
}




