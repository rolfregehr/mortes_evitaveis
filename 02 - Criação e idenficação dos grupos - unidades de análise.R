source('cabeçalho.r')


load('./rda/sinasc_avaliacao_inicial.rda')
load('./rda/sinasc_cor_raca_informado.rda')
load('./rda/ref_corte.rda')




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
  mutate(grupo = paste(DTNASC, RACACOR, SEXO_BIOLOGICO, sep = '--')) |> 
  group_by(DTNASC, RACACOR, SEXO_BIOLOGICO, grupo) |> 
  summarise(n=sum(n)) |> 
  ungroup()


save(sinasc_grupos_nascimento, file = './rda/sinasc_grupos_nascimento.rda')
