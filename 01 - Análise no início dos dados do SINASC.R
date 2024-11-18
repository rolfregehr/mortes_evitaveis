rm(list = ls())
# lista os arquivos ####
arq_sinasc <- list.files('f:/r/Dados Públicos/SINASC/fonte', full.names = T)
arq_sinasc <- arq_sinasc[which(str_detect(arq_sinasc, 'BR', negate = T))]


# Lê os arquivos e agrupa em um DF ####
library(read.dbc)
library(tidyverse)
library(lubridate)


for(i in 1:length(arq_sinasc)){
  
  res <- try(read.dbc(arq_sinasc[i]))
  if(inherits(res, "try-error"))
      {
        next
  }  
  
  if(!exists('sinasc')){
    sinasc <- res |> 
      mutate(DTNASC = dmy(DTNASC)) |> 
      filter(!is.na(DTNASC)) |> 
      group_by(CODMUNNASC, DTNASC, SEXO, RACACOR) |> 
      summarise(n=n()) |> 
      ungroup()
    
  }
  temp <- res |>
    mutate(DTNASC = dmy(DTNASC)) |> 
    filter(!is.na(DTNASC)) |> 
    group_by(CODMUNNASC, DTNASC, SEXO, RACACOR) |> 
    summarise(n=n()) |> 
    ungroup()
  
  sinasc <- bind_rows(sinasc, temp)
  print(i)

}





# Avaliação do % de cor raca informado
sinasc_cor_raca_informado <- sinasc |> 
  mutate(mes = floor_date(DTNASC, unit = 'month'),
         RACACOR = if_else(is.na(RACACOR), 'NI', 'Informado')) |> 
  group_by(mes, RACACOR) |> 
  summarise(n=sum(n)) |> 
  ungroup() |> 
  pivot_wider(names_from = RACACOR, values_from = n, values_fill = 0) |> 
  mutate(info_racacor = NI/(Informado + NI)) 

save(sinasc_cor_raca_informado, file = './rda/sinasc_cor_raca_informado.rda')
save(sinasc, file = './rda/sinasc_avaliacao_inicial.rda')




