source('cabeçalho.r')

# FTP ---> LOCAL ####
# Lê os arquivos no FTP
url <- "ftp://ftp.datasus.gov.br/dissemin/publicos/CIHA/201101_/Dados/"
h = new_handle()
con = curl(url, "r", h)



ciha_ftp = read.table(con, stringsAsFactors=TRUE, fill=TRUE) 
names(ciha_ftp) <- c('data_arq', 'hora', 'tamanho', 'nome_arq')
ciha_ftp <- ciha_ftp |> 
  mutate(data_calc = mdy(data_arq))
close(con)

# Lê os DBC já baixados 

ciha_local <- tibble(nome_arq = list.files('F:/r/Dados Públicos/ciha/fonte/')) |> 
  bind_cols(tibble(data_local = file.mtime(list.files('F:/r/Dados Públicos/ciha/fonte/', full.names = T)))) |> 
  mutate(data_local = as.Date(data_local))

arq_ciha <- ciha_ftp |> 
  left_join(ciha_local, by = 'nome_arq') |> 
  filter(data_local < data_calc | is.na(data_local)) |> 
  pull(nome_arq)




if(length(arq_ciha) > 0){
  for(i in 1:length(arq_ciha)){
    download.file(url = paste0(url,
                               arq_ciha[i]),
                  destfile =  paste0('F:/r/Dados Públicos/ciha/fonte/', as.character(arq_ciha[i])), 
                  mode = "wb")
    
  }
  
}


