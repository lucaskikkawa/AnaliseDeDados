# Instalação Pacotes

if (!require(tidyverse)) {
  # Se não está instalado, instala o pacote
  install.packages("tidyverse")
}

if (!require(corrplot)) {
  # Se não está instalado, instala o pacote
  install.packages("corrplot")
}

if (!require(Hmisc)) {
  # Se não está instalado, instala o pacote
  install.packages("Hmisc")
}

# Importação bibliotecas
library(tidyverse)
library(corrplot)
library(Hmisc)

#----------------------------------------

# Importação Dados
agua_rede1 <- read.csv2("https://raw.githubusercontent.com/luisfelipebr/mti/master/dados/agua_rede1.csv", 
                        encoding="UTF-8")

#----------------------------------------

# Diagrama de Dispersão - base R
plot(x = agua_rede1$RENDAPITA, 
     y = agua_rede1$CONSUMO1,
     xlab = "Renda per capita",
     ylab = "Consumo de água per capita")

# Diagrama de Dispersão - ggplot2
ggplot(data = agua_rede1, aes(x = RENDAPITA, y = CONSUMO1)) +
  geom_point() +
  theme_bw() +
  xlab("Renda per capita") +
  ylab("Consumo de água per capita (m³/ano)")

#----------------------------------------

# Calculo Coeficiente de Correlação de Pearson (r)
cor(x = agua_rede1$RENDAPITA, 
    y = agua_rede1$CONSUMO1,
    method = "pearson",
    use = "complete.obs")

# Teste Significancia (Estatistica T)
teste <- cor.test(x = agua_rede1$RENDAPITA, 
   y = agua_rede1$CONSUMO1,
   method = "pearson",
   alternative = "two.sided",
   conf.level = 0.95)

#----------------------------------------

# Matriz de Correlação
agua_rede1 %>%
  select(RENDAPITA, CONSUMO1, CONSUMO2, PIB, IDH, GINI, REDE, PROPREDE) %>%
  cor(method = "pearson",
      use = "complete.obs") %>%
  round(digits=2)

# Grafico Matriz de Correlação

#   Default
agua_rede1 %>%
  select(RENDAPITA, CONSUMO1, CONSUMO2, PIB, IDH, GINI, REDE, PROPREDE) %>%
  cor(method = "pearson",
      use = "complete.obs") %>%
  corrplot()

#   Metodo Color
agua_rede1 %>%
  select(RENDAPITA, CONSUMO1, CONSUMO2, PIB, IDH, GINI, REDE, PROPREDE) %>%
  cor(method = "pearson",
      use = "complete.obs") %>%
  corrplot(method = "color")

#   Metodo Number
agua_rede1 %>%
  select(RENDAPITA, CONSUMO1, CONSUMO2, PIB, IDH, GINI, REDE, PROPREDE) %>%
  cor(method = "pearson",
      use = "complete.obs") %>%
  corrplot(method = "number")

#----------------------------------------
# Matriz de Correlação + Coeficiente de Correlação
# + p-value 

agua_rede1 %>%
  select(RENDAPITA, CONSUMO1, CONSUMO2, PIB, IDH, GINI, REDE, PROPREDE) %>%
  as.matrix() %>%
  rcorr(type = "pearson")