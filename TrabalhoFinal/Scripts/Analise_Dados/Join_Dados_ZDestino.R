# Join_Dados_ZDestino.R

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
caminho_para_csv <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/csv/ZDestino/"

# Importar dados CSV
T_21 <- read.csv(file.path(caminho_para_csv, "T_21.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_22 <- read.csv(file.path(caminho_para_csv, "T_22.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_23 <- read.csv(file.path(caminho_para_csv, "T_23.csv"), stringsAsFactors = FALSE, check.names = FALSE)

# Função para converter valores em proporções e arredondar para duas casas decimais
prop_vals <- function(df) {
  df[-c(1, ncol(df))] <- round((df[-c(1, ncol(df))] / df$Total * 100), 2)
  return(df)
}

T_21 <- prop_vals(T_21)
T_22 <- prop_vals(T_22)
T_23 <- prop_vals(T_23)

# Realizar merge dos dataframes baseado na coluna "Zona"
ZDestino <- full_join(T_21[,-ncol(T_21)], T_22[,-ncol(T_22)], by = "Zona") %>%
  full_join(., T_23[,-ncol(T_23)], by = "Zona")

# Exportar o dataframe "ZDestino" como CSV
write.csv(ZDestino, file = "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/Exportados/ZDestino.csv", row.names = FALSE, quote = FALSE)
