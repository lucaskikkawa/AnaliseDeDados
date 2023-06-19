# Tidyverse
#install.packages("tidyverse")
library(tidyverse)

# Funções presentes na biblioteca tidyverse

# Operador pipe %>% em tidyverse
# Ao invés de fazer uma implementação de algoritmo "nested"
# voce utiliza este operador.
# E.G.

# esfrie(
#   asse(
#     coloque(
#       bata(
#         acrescente(
#           recipiente(
#             rep("farinha", 2), 
#             "água", 
#             "fermento", 
#             "leite", 
#             "óleo"
#           ), 
#           "farinha", 
#           ate = "macio"
#         ), 
#         duracao = "3min"
#       ), 
#       lugar = "forma", 
#       tipo = "grande", 
#       untada = TRUE
#     ), 
#     duracao = "50min"
#   ), 
#   lugar = "geladeira", 
#   duracao = "20min"
# )

# Com o operador pipe %>%
# recipiente(rep("farinha", 2), "água", "fermento", "leite", "óleo") %>%
#   acrescente("farinha", até = "macio") %>%
#   bata(duração = "3min") %>%
#   coloque(lugar = "forma", tipo = "grande", untada = TRUE) %>%
#   asse(duração = "50min") %>%
#   esfrie("geladeira", "20min")

#-----------------------------------------------------------------

# Filter e Select

# Padrão R
# agua1[which(agua1$UF == "SP" & agua1$IDH > 0.85),c("NOME_MUN", "IDH")]


# Tidyverse
# agua1 %>%
#   filter(UF == "SP" & IDH > 0.85) %>%
#   select(NOME_MUN, IDH)

#-----------------------------------------------------------------
# Mutate (Atribuição de variaveis)

# Padrão R ( Variavel Consumo1 no objeto agua)
# agua1$CONSUMO1 <- agua1$AG020 * 1000 / agua1$GE012
# agua1$CONSUMO2 <- agua1$AG020 * 1000 / agua1$AG001

#Tidyverse ( Variavel Consumo 1 e Consumo 2 no objeto agua2)
# agua2 <- agua1 %>%
#   mutate(CONSUMO1 = AG020 * 1000 / GE012,
#          CONSUMO2 = AG020 * 1000 / AG001)
#-----------------------------------------------------------------

# Join 
# (Similar ao Join em SQL + Teoria Conjuntos Matematica)

# E.G.

#left_join(x,y, by = "ID")

# left_join(x,y, by = "ID") 
#   Dados exclusivos de X e intersecção com Y
# right_join(x,y, by = "ID")
#   Dados exclusivos de Y e intersecção com X
# inner_join(x,y, by = "ID")
#   Dados de intersecção entre X e Y
# full_join(x,y, by = "ID")
#   Todos os dados de X e Y

#-----------------------------------------------------------------

# Principios de Analise de Dados em R

# 1º - Importar Dados (Neste caso, pela web )

agua1 <- read.csv2("https://raw.githubusercontent.com/luisfelipebr/mti/master/dados/agua1.csv", 
                   encoding="UTF-8") 
rede1 <- read.csv2("https://raw.githubusercontent.com/luisfelipebr/mti/master/dados/rede1.csv", 
                   encoding="UTF-8")

# 2º - Limpar e Arrumar Dados
agua1 %>%
  filter(UF == "SP" & IDH > 0.85) %>%
  select(NOME_MUN, IDH)

agua2 <- agua1 %>%
  mutate(CONSUMO1 = AG020 * 1000 / GE012,
         CONSUMO2 = AG020 * 1000 / AG001)

agua_rede1 <- rede1 %>%
  mutate(PROPREDE = REDE/DOMICIL) %>%
  select(-c(UF, REGIAO)) %>% 
  full_join(agua2, by = "ID_IBGE") 

# 3º - Ciclo de Exploração (Transformar/Modelar/Visualizar)

# Transformação e Modelação
tabela_PROPREDE <- agua_rede1 %>%
  drop_na(PROPREDE) %>%
  group_by(REGIAO) %>%
  summarize(n_obs = n(),
            media = mean(PROPREDE),
            desvio_padrao = sd(PROPREDE)) %>%
  mutate(erro = 1.96*desvio_padrao/sqrt(n_obs), # IC de 95% (1,96)
         limite_superior = media + erro,
         limite_inferior = media - erro)

# Visualização (Graficos)
#install.packages("ggplot2")
library(ggplot2)
tabela_PROPREDE

# Histograma
ggplot(data = agua_rede1, aes(x = PROPREDE, fill = REGIAO)) +
  geom_histogram() +
  facet_wrap(~REGIAO) +
  ggtitle("Histograma de PROPREDE por região") +
  xlab("") +
  ylab("") +
  theme_bw() +
  theme(legend.position = "none")

# Box-plot
ggplot(data = agua_rede1, aes(y = PROPREDE, fill = REGIAO)) +
  geom_boxplot() +
  facet_wrap(~REGIAO) +
  ggtitle("Box-plot de PROPREDE por região") +
  xlab("") +
  ylab("") +
  theme_bw() +
  theme(legend.position = "none")

# Coluna (Média e IC por região)
ggplot(data = tabela_PROPREDE, aes(x = REGIAO, y = media, fill=REGIAO)) +
  geom_col() +
  geom_errorbar(aes(ymin = limite_inferior, ymax = limite_superior)) +
  ggtitle("Média e intervalo de confiança de PROPREDE por região") +
  xlab("") +
  ylab("") +
  theme_bw() +
  theme(legend.position = "none")


#names(agua1)
#names(rede1)

# 4º - Exportar Dados
write.csv2(agua_rede1, "~/Analisedados/Aulas/Aula03/Dados/agua_rede1.csv", row.names = FALSE)


