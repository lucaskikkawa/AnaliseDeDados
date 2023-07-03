# Renomear_Variaveis_ZDestino.R

# Instalação Pacotes
if (!require(dplyr)) {
  # Se não está instalado, instala o pacote
  install.packages("dplyr")
}

# Carregando o pacote dplyr
library(dplyr)

# Diretório
caminho_para_csv <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/csv/ZDestino/"

# Lendo os arquivos .csv
T_21 <- read.csv(file.path(caminho_para_csv, "T_21.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_22 <- read.csv(file.path(caminho_para_csv, "T_22.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_23 <- read.csv(file.path(caminho_para_csv, "T_23.csv"), stringsAsFactors = FALSE, check.names = FALSE)

# Função para renomear colunas
rename_cols <- function(df) {
  names(df)[1] <- "Zona"
  names(df)[ncol(df)] <- "Total"
  
  # Remove 'X' prefix from column names
  names(df)[-c(1, ncol(df))] <- gsub("^X", "", names(df)[-c(1, ncol(df))])
  # Move prefix to end
  names(df)[-c(1, ncol(df))] <- sub("^([0-9]+)_(.*)$", "\\2_\\1", names(df)[-c(1, ncol(df))])
  return(df)
}

# Rename columns
T_21 <- rename_cols(T_21)
T_22 <- rename_cols(T_22)
T_23 <- rename_cols(T_23)

# Lista de dataframes
dfs <- list(T_21 = T_21, T_22 = T_22, T_23 = T_23)

# Renomear as colunas e sobrescrever os arquivos .csv
for(i in names(dfs)){
  write.csv(dfs[[i]], file = file.path(caminho_para_csv, paste0(i, ".csv")), row.names = FALSE, quote = FALSE)
}
