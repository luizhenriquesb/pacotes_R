# R

setwd("C:\\Users\\luizh\\Documents\\R\\ObservaSampa")
getwd()

dados_net <- read.csv("https://dados-abertos-observasampa.prefeitura.sp.gov.br/_temp/DadosAbertos/ObservaSampaDadosAbertosVariaveisCSV.csv", sep = ";")
dados_net %>% 
  glimpse()

dados <- read.csv("observa_sampa_variaveis_csv.csv", sep = ";")
dados %>% 
  glimpse() 

# DPLYR

library(dplyr)

# Funções que lidam com LINHAS 

# 1. dplyr::filter() 
# Seleciona as linhas de um dado valor

starwars %>% 
  filter(species == "Droid")

dados2 %>% 
  filter(Região == "Lajeado (Distrito)") %>% 
  glimpse()

# 2. dplyr::slice() 
# Seleciona uma linha dado um valor numérico

starwars %>% 
  slice(1:10)

dados2 %>% 
  slice(1:10)

# 3. dplyr::arrange() 

# Ordena as linhas do dataset dado uma coluna

dplyr::arrange(starwars, height) # Ordena por altura

# Por default, a função ordena por ordem crescente

starwars %>% 
  arrange(mass)

# Ordem decrescente

starwars %>% 
  arrange(desc(mass))


# Funções que lidam com COLUNAS 

# 1. dplyr::pull() 
# Puxa os elementos de uma coluna

starwars %>% 
  pull(height) %>% 
  tabel()

starwars %>% 
  pull(name = name)

dados_net %>% 
  pull(Período) %>% 
  table()

# 2. dplyr::select() 
# Seleciona colunas de um dataset

starwars %>% 
  select(name, mass)


# 3. dplyr::rename() 
# Renomeia as colinas

starwars %>% 
  rename(nome = name,
         altura = height,
         peso = mass,
         cabelo = hair_color,
         cor_da_pele = skin_color)

dados_net <- dados_net %>% 
  rename(variavel = Nome,
         regiao = Região,
         ano = Período,
         casos = Resultado)


# 4. dplyr::mutate() 
# Cria e altera colunas

# Exemplo

starwars_resumido <- select(starwars,
                            name, height, species)

# Recodificando as alturas em alto e baixo e as espécies em alienígenas e humanos

starwars_resumido %>% 
  mutate(altura_recodificada = ifelse(height > 180, "alto", "baixo")) %>% 
  mutate(alienigena = ifelse(species %in% c("Human", "Droid"), "alienigena", "humano"))

starwars_resumido %>% 
  mutate(altura_recodificada = ifelse(height > 180, "alto", "baixo"),
         alienigena = ifelse(species %in% c("Human"), "humano", "alienigena"))


# 5. dplyr::recode() 
# O ifelse() permite apenas recodificar em duas dimensões. A função recode()
# permite recodificar em mais dimensões. Por ex., traduzindo.

starwars %>% 
  select(name, eye_color) %>% 
  mutate(cor_dos_olhos = recode(eye_color,
                                "blue" = "azul",
                                "yellow" = "amarelo",
                                "red" = "vermelho",
                                "brown" = "marrom",
                                "blue-gray" = "azul acizentado"))

# 6. dplyr::case_when() 
# Permite recodificar os valores de uma coluna alterando o tipo de valor, por 
# exemplo, alterando de tipo numérico para texto

starwars %>% 
  select(name, height, mass) %>% 
  mutate(altura_recodificada = case_when(height <= 120 ~ "pequenino",
                                         height >= 121 & height <= 165 ~ "pequena",
                                         height >= 166 & height <= 179 ~ "mediana",
                                         height >= 180 & height <= 199 ~ "alta",
                                         height >= 200 ~"altissima"))


# 7. dplyr::relocate() 
# Permite reordenar a posição das colunas

starwars %>% 
  relocate(films, .after = mass)

# 8. dplyr::group_by()  
# Permite agrupar os dados de um data frame por uma ou mais variáveis

starwars %>% 
  group_by(species) %>% 
  summarise(media_altura = mean(height, na.rm = TRUE),
            media_peso = mean(mass, na.rm = TRUE), 
            mediana_peso = median(mass, na.rm = TRUE))

# 9. dplyr::summarise() 
# É usada para resumir informações em um data frame, conforme visto no ex. acima

starwars %>% 
  filter(species %in% c("Human", "Droid")) %>% 
  group_by(species) %>% 
  summarise(Minimos = min(height, na.rm = TRUE),
            Media = mean(height, na.rm = TRUE),
            Desvio_Padrão = sd(height, na.rm = TRUE),
            Variancia = var(height, na.rm = TRUE),
            Maxima = max(height, na.rm = TRUE))


# 10. dplyr::across() 
# É usada para aplicar funções a várias colunas de um data frame de uma só vez

iris %>% 
  tibble() %>% 
  mutate(
    across(c(Sepal.Length:Petal.Width), # o : serve como operador lógico
           round) # round arredona os valores p/ o número inteiro mais próximo
  )