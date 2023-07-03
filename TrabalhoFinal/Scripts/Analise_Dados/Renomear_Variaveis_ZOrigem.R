# Renomear_Variaveis_ZOrigem.R

# Instalação Pacotes
if (!require(dplyr)) {
  # Se não está instalado, instala o pacote
  install.packages("dplyr")
}

# Carregando o pacote dplyr
library(dplyr)

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

# Diretório
caminho_para_csv <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/csv/ZOrigem/"

# Lendo os arquivos .csv
T_16 <- read.csv(file.path(caminho_para_csv, "T_16.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_17 <- read.csv(file.path(caminho_para_csv, "T_17.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_18 <- read.csv(file.path(caminho_para_csv, "T_18.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_20 <- read.csv(file.path(caminho_para_csv, "T_20.csv"), stringsAsFactors = FALSE, check.names = FALSE)

# Rename columns
T_16 <- rename_cols(T_16)
T_17 <- rename_cols(T_17)
T_18 <- rename_cols(T_18)
T_20 <- rename_cols(T_20)

# Lista de dataframes
dfs <- list(T_16 = T_16, T_17 = T_17, T_18 = T_18, T_20 = T_20)

# Renomear as colunas e sobrescrever os arquivos .csv
for(i in names(dfs)){
  write.csv(dfs[[i]], file = file.path(caminho_para_csv, paste0(i, ".csv")), row.names = FALSE, quote = FALSE)
}
