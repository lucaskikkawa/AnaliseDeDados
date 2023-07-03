# Join_Dados_ZOrigem.R

# Instalação Pacotes
if (!require(dplyr)) {
  # Se não está instalado, instala o pacote
  install.packages("dplyr")
}

if (!require(tidyverse)) {
  # Se não está instalado, instala o pacote
  install.packages("tidyverse")
}

# Carregar pacotes
library(dplyr)
library(tidyverse)

# Caminho para os dados CSV
caminho_para_csv <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/csv/ZOrigem/"

# Importar dados CSV
T_16 <- read.csv(file.path(caminho_para_csv, "T_16.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_17 <- read.csv(file.path(caminho_para_csv, "T_17.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_18 <- read.csv(file.path(caminho_para_csv, "T_18.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_20 <- read.csv(file.path(caminho_para_csv, "T_20.csv"), stringsAsFactors = FALSE, check.names = FALSE)

# Função para converter valores em proporções e arredondar para duas casas decimais
prop_vals <- function(df) {
  df[-c(1, ncol(df))] <- round((df[-c(1, ncol(df))] / df$Total * 100), 2)
  return(df)
}

T_16 <- prop_vals(T_16)
T_17 <- prop_vals(T_17)
T_18 <- prop_vals(T_18)
T_20 <- prop_vals(T_20)

# Realizar merge dos dataframes baseado na coluna "Zona"
ZOrigem <- full_join(T_16[,-ncol(T_16)], T_17[,-ncol(T_17)], by = "Zona") %>%
  full_join(., T_18[,-ncol(T_18)], by = "Zona") %>%
  full_join(., T_20[,-ncol(T_20)], by = "Zona")

# Exportar o dataframe "ZOrigem" como CSV
write.csv(ZOrigem, file = "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/Exportados/ZOrigem.csv", row.names = FALSE, quote = FALSE)
