# Cabeçalho 
rm(list = ls())
library(read.dbc)
library(tidyverse)
library(lubridate)


load('./rda/sinasc_avaliacao_inicial.rda')
load('./rda/sinasc_cor_raca_informado.rda')
str(sinasc)

# Recodificando



ref_corte <- .05

ano_ref = year(min(sinasc_cor_raca_informado$mes[which(sinasc_cor_raca_informado$info_racacor < ref_corte)]))
  

sinasc_grupos_nascimento <- sinasc |> 
  filter(year(DTNASC) == ano_ref) |> 
  mutate(SEXO_BIOLOGICO = case_when(SEXO == '0' ~ 'Ignorado',
                                    SEXO == '1' ~ 'Masculino',
                                    SEXO == '2' ~ 'Feminino',),
         RACACOR = case_when(RACACOR == '1' ~ 'Branca',
                             RACACOR == '2' ~ 'Preta',
                             RACACOR == '3' ~ 'Amarela',
                             RACACOR == '4' ~ 'Parda',
                             RACACOR == '5' ~ 'Indígena',
                             T ~ 'NI')) |> 
  arrange(CODMUNNASC) |> 
  select(-c(SEXO)) |> 
  mutate(grupo = paste(CODMUNNASC , DTNASC, RACACOR, SEXO_BIOLOGICO, sep = '--'))


save(sinasc_grupos_nascimento, file = './rda/sinasc_grupos_nascimento.rda')
save(ref_corte, file = './rda/ref_corte.rda')
