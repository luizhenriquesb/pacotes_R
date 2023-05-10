# R

setwd("C:\\Users\\luizh\\Documents\\R\\ObservaSampa")
getwd()

dados_net <- read.csv("https://dados-abertos-observasampa.prefeitura.sp.gov.br/_temp/DadosAbertos/ObservaSampaDadosAbertosVariaveisCSV.csv", sep = ";")
dados_net %>% 
  glimpse()


# TIDYR 

library(tidyr)
library(tidyverse) # Contém tidyr, tibble, dplyr e ggplot


# Conceito de TIDY DATA 
# Tidy data deve atender a três princípios:

# 1. Cada variável deve ter sua própria coluna
# 2. Cada linha deve representar uma única observação
# 3. Cada tipo de unidade observacional deve ter sua própria coluna

tidyr::table1 # Exemplo


# Dataset WIDE, não tidy 

tidyr::table4a # Exemplo 1
tidyr::table4b # Exemplo 2

# 1. Transformando Wide em Tidy 
# 1.1 tidyr::pivot_longer 

table4a %>% # dataset Wide
  pivot_longer( # função que transforma dados em formato tidy
    # definir colunas que serão empilhadas
    c('1999', '2000'),
    names_to = "year", # indica a coluna que receberá o rótulo das colunas empilhadas
    values_to = "cases" # indica a coluna que recebrá o valor das colunas empilhadas
  )


# Dataset LONG, não Tidy 

tidyr::table2 # Exemplo


# 2. Transformando Long  Tidy 
# 2.1 tidyr::pivot_wider 

table2 %>% # dataset Long
  pivot_wider( # função que transforma os dados em formato tidy
    names_from = type, # indica a coluna que contém o rotulo das variaveis
    values_from = count # indica a coluna que contém os valores das variáveis
  )

dados_net %>% 
  pivot_wider(
    names_from = variavel,
    values_from = casos
  ) %>% 
  arrange(regiao, ano) %>% 
  select("regiao", "ano", "V0001-População total") %>% 
  filter(str_detect(regiao, "Distrito"))

# EXERCÍCIO 1 

# O dataset a seguir mede os ativos listados na B3 com o retorno de resultado por mês

dados_b3_2010_2022.csv <- read.csv("https://raw.githubusercontent.com/BaruqueRodrigues/Curso-de-R/master/dados/dados_b3_2010_2022.csv")

dados_b3_2010_2022.csv %>% 
  tibble()

# Remover a coluna 1

dados_b3_2010_2022.csv %>% 
  select(-1) %>% 
  tibble()

# Transformar o dataset em um formato tidy()

dados_b3_2010_2022.csv %>% 
  select(-1) %>%
  pivot_wider(
    names_from = ticker,
    values_from = ret_adjusted_prices
  )


# Como separar e juntar dados? 


# tidyr::separate() 
# Permite dividir uma coluna em várias colunas

table3 %>% 
  separate( # Função que separa os dados de colunas
    rate, # Coluna que será separada
    sep = "/", # Separador utilizado para separar as infos dentro da coluna
    into = c("cases", "population") # nomes das novas colunas
  )

table3 %>% 
  separate(
    year, 
    sep = 2, # separar a partir do segundo elemento
    into = c("século", "ano")
  )


# tidyr::unite() 

table5 %>% 
  unite(
    ano_completo, # nova coluna
    century, year, # colunas que serão juntadas
    sep = ""
  )


# REVISÃO 

# Importe o dataset pedidos

pedidos <- readr::read_csv("https://raw.githubusercontent.com/BaruqueRodrigues/Curso-de-R/master/dados/pedidos.csv")

# Remova a primeira coluna

pedidos %>%
  select(-1)

# Transforme esse dataset em formato tidy onde:
# 1. A descrição do pedido seja separada em múltiplos itens
# 2. O dataset tenha formato long

pedidos %>% 
  select(-1) %>% 
  separate(
    descricao_por_pedido,
    into = c("item_1", "item_2", "item_3", "item_4", "item_5"),
    sep = ","
  ) %>% 
  pivot_longer(
    c(item_1:item_5),
    names_to = "item_do_pedido",
    values_to = "descricao_por_pedido"
  )


# MISSING DATA 

# drop_na() 
# Remove os casos com o valor NA

pedidos %>% 
  drop_na()

# fill_na() 
# Preenche valores NA com os valores númericos mais próximos


# replace_na() 
# Substitui os dados ausentes por valores especificados

pedidos_final %>% 
  replace_na(                      # função que vai substituit NA pelo valor desejado
    list(                          # para inserir várias colunas
      desc_pedido = "item ausente" # indica o substituto por coluna
    )
  )


