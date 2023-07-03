# Join_Dados_ZEmprego.R

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
caminho_para_csv <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/csv/ZEmprego/"

# Importar dados CSV
T_12 <- read.csv(file.path(caminho_para_csv, "T_12.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_14 <- read.csv(file.path(caminho_para_csv, "T_14.csv"), stringsAsFactors = FALSE, check.names = FALSE)

# Função para converter valores em proporções e arredondar para duas casas decimais
prop_vals <- function(df) {
  df[-c(1, ncol(df))] <- round((df[-c(1, ncol(df))] / df$Total * 100), 2)
  return(df)
}

T_12 <- prop_vals(T_12)
T_14 <- prop_vals(T_14)

# Realizar merge dos dataframes baseado na coluna "Zona"
ZEmprego <- full_join(T_12[,-ncol(T_12)], T_14[,-ncol(T_14)], by = "Zona")

# Exportar o dataframe "ZEmprego" como CSV
write.csv(ZEmprego, file = "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/Exportados/ZEmprego.csv", row.names = FALSE, quote = FALSE)
