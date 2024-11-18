source('cabeçalho.r')
load('./rda/sinasc_grupos_nascimento.rda')



# num ignorados ####
sum(sinasc_grupos_nascimento$n[which(sinasc_grupos_nascimento$RACACOR == 'NI')])/sum(sinasc_grupos_nascimento$n)


sinasc_grupos_nascimento |> 
  group_by(SEXO_BIOLOGICO, RACACOR) |> 
  summarise(n=sum(n)) |> 
  arrange(RACACOR) |> 
  pivot_wider(names_from = RACACOR, values_from = n, values_fill = 0) |> 
  mutate(`Proporção de NI` = NI/(Amarela+Branca+Indígena+NI+Parda+Preta))
            


sinasc_grupos_nascimento |> 
  group_by(grupo) |> 
  summarise(n=n()) |> 
  arrange(-n)



