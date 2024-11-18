library(RCurl)


# Sistema de Informações sobre Nascidos Vivos ( SINASC ) ####

# Configurações de conexão FTP público
ftp_host <- "ftp.datasus.gov.br"
remote_dir <- "/dissemin/publicos/SINASC/1996_/Dados/DNRES/"
local_dir <- "F:/r/Dados Públicos/SINASC/SINASC/fonte/"

# Estabalece a conexão
ftp_connection <- getURL(
  paste0("ftp://", ftp_host, remote_dir),
  dirlistonly = TRUE)

arquivos_ftp <- strsplit(ftp_connection, "\r\n")[[1]]


for(i in 1:length(arquivos_ftp)){
  
  download.file(paste0("ftp://", ftp_host, remote_dir, arquivos_ftp[i]),
                paste0("F:/r/Dados Públicos/SINASC/SINASC/fonte/", toupper(arquivos_ftp[i])),
                mode = "wb")
  
  }


# Sistema de Informações de Mortalidade ( SIMN ) ####

# Configurações de conexão FTP público
ftp_host <- "ftp.datasus.gov.br"
remote_dir <- "/dissemin/publicos/SINASC/1996_/Dados/DNRES/"
local_dir <- "F:/r/Dados Públicos/SIM/CID10/DORES/"

# Estabalece a conexão
ftp_connection <- getURL(
  paste0("ftp://", ftp_host, remote_dir),
  dirlistonly = TRUE)

arquivos_ftp <- strsplit(ftp_connection, "\r\n")[[1]]


for(i in 1:length(arquivos_ftp)){
  
  download.file(paste0("ftp://", ftp_host, remote_dir, arquivos_ftp[i]),
                paste0("F:/r/Dados Públicos/SINASC/SINASC/fonte/", toupper(arquivos_ftp[i])),
                mode = "wb")
  
}





# Sistema de Informações Ambulatoriais do SUS (SIA/SUS) ####

# Configurações de conexão FTP público
ftp_host <- "ftp.datasus.gov.br"
remote_dir <- "/dissemin/publicos/SIASUS/200801_/Dados/"
local_dir <- "F:/r/Dados Públicos/SIASUS/fonte/"

# Estabalece a conexão
ftp_connection <- getURL(
  paste0("ftp://", ftp_host, remote_dir),
  dirlistonly = TRUE)

arquivos_ftp <- strsplit(ftp_connection, "\r\n")[[1]]
arquivos_ftp <- arquivos_ftp[which(str_detect(arquivos_ftp, '^RD'))] # filtra os arquivos de atendimento - RD: 




for(i in 1:length(arquivos_ftp)){
  
  download.file(paste0("ftp://", ftp_host, remote_dir, arquivos_ftp[i]),
                paste0("F:/r/Dados Públicos/SIASUS/fonte/", toupper(arquivos_ftp[i])),
                mode = "wb")
  
}
