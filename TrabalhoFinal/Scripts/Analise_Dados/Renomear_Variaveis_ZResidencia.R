# Renomear_Variaveis_ZResidencia.R

# Instalação Pacotes
# Verifica se o pacote dplyr está instalado
if (!require(dplyr)) {
  # Se não está instalado, instala o pacote
  install.packages("dplyr")
}

# Carregando o pacote dplyr
library(dplyr)

# Diretório
caminho_para_csv <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/csv/ZResidencia/"

# Lendo os arquivos .csv
T_04 <- read.csv(file.path(caminho_para_csv, "T_04.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_05 <- read.csv(file.path(caminho_para_csv, "T_05.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_08 <- read.csv(file.path(caminho_para_csv, "T_08.csv"), stringsAsFactors = FALSE, check.names = FALSE)

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

T_04 <- rename_cols(T_04)
T_05 <- rename_cols(T_05)
T_08 <- rename_cols(T_08)

# Lista de dataframes
dfs <- list(T_04 = T_04, T_05 = T_05, T_08 = T_08)

# Renomear as colunas e sobrescrever os arquivos .csv
for(i in names(dfs)){
  write.csv(dfs[[i]], file = file.path(caminho_para_csv, paste0(i, ".csv")), row.names = FALSE, quote = FALSE)
}
