sinasc_grupos_nascimento |> 
  group_by(grupo) |> 
  summarise(n=n()) |> 
  arrange(-n)
