# R

setwd("C:\\Users\\luizh\\Documents\\R\\ObservaSampa")
getwd()

dados_net <- read.csv("https://dados-abertos-observasampa.prefeitura.sp.gov.br/_temp/DadosAbertos/ObservaSampaDadosAbertosVariaveisCSV.csv", sep = ";")
dados_net %>% 
  glimpse()

library(nycflights13) # Carregar alguns dados que vamos utilizar

# GGPLOT2 

library(ggplot2)

test <- dados_net %>% 
  pivot_wider(
    names_from = variavel,
    values_from = casos
  ) %>% 
  arrange(regiao, ano) %>% 
  select("regiao", "ano", "V0001-População total") %>% 
  filter(str_detect(regiao, "Distrito")) %>% 
  rename(população = 'V0001-População total') %>% 
  mutate(população = as.integer(população))


# Grammar of graphs 

ggplot(data = flights,  # Dataset que contém as variáveis de interesse
       aes(arr_time)    # Atributos estéticos que queremos visualizar no eixo x ou y
)+               # Operador que adicionar camada aos objetos gráficos
  geom_histogram()    #geom_[inserir tipo de visualização desejada]


# Gráficos UNIVARIADOS 


# 1. Histograma: geom_histogram() 

weather %>% # dataset que contém as informações
  ggplot(    # função que constrói elementos gráficos
    aes(x = temp)  # variável a ser visualizada
  )+
  geom_histogram()

# Como alterar a cor e a bins de um histograma

weather %>% 
  ggplot(
    aes(x = temp)
  )+
  geom_histogram(bins = 40,
                 olor = "white",    # Muda o contorno do objeto geométrico
                 fill = "steelblue")+  # Preenche o objeto geométrico
  facet_wrap(~month, nrow = 2) # divide o gráfico em painéis ou subgráficos


# 2. Box-plot: geom_boxplot() 

weather %>% 
  ggplot(
    aes(x = factor(month),
        y = temp)
  )+
  geom_boxplot()

# 3. Gráfico de barras 
# 3.1 Barras: geom_bar() 
# 3.2 Barras: geom_bar() 

exemplo %>% 
  ggplot(
    aes(x = exemplo,
        y = exemplo)
  )+
  geom_bar()

exemplo %>% 
  ggplot(
    aes(x = exemplo,
        y = exemplo)
  )+
  geom_col()

# 3.3 Gráfico de barras com proporções 

flights %>% 
  ggplot(
    aes(x = carrier, fill = origin)
  )+
  geom_bar()