# Join_Dados_ZResidencia.R

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
caminho_para_csv <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/csv/ZResidencia/"

# Importar dados CSV
T_04 <- read.csv(file.path(caminho_para_csv, "T_04.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_05 <- read.csv(file.path(caminho_para_csv, "T_05.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_08 <- read.csv(file.path(caminho_para_csv, "T_08.csv"), stringsAsFactors = FALSE, check.names = FALSE)

# Função para converter valores em proporções e arredondar para duas casas decimais
prop_vals <- function(df) {
  df[-c(1, ncol(df))] <- round((df[-c(1, ncol(df))] / df$Total * 100), 2)
  return(df)
}

T_04 <- prop_vals(T_04)
T_05 <- prop_vals(T_05)
T_08 <- prop_vals(T_08)

# Realizar merge dos dataframes baseado na coluna "Zona"
ZResidencia <- full_join(T_04[,-ncol(T_04)], T_05[,-ncol(T_05)], by = "Zona") %>%
  full_join(., T_08[,-ncol(T_08)], by = "Zona")

# Exportar o dataframe "ZResidencia" como CSV
write.csv(ZResidencia, file = "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/Exportados/ZResidencia.csv", row.names = FALSE, quote = FALSE)
