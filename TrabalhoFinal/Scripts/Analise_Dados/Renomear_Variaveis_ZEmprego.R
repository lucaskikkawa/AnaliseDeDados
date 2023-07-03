# Renomear_Variaveis_ZEmprego.R

# Instalação Pacotes
# Verifica se o pacote dplyr está instalado
if (!require(dplyr)) {
  # Se não está instalado, instala o pacote
  install.packages("dplyr")
}

# Carregando o pacote dplyr
library(dplyr)

# Diretório
caminho_para_csv <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/csv/ZEmprego/"

# Lendo os arquivos .csv
T_12 <- read.csv(file.path(caminho_para_csv, "T_12.csv"), stringsAsFactors = FALSE, check.names = FALSE)
T_14 <- read.csv(file.path(caminho_para_csv, "T_14.csv"), stringsAsFactors = FALSE, check.names = FALSE)

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

T_12 <- rename_cols(T_12)
T_14 <- rename_cols(T_14)

# Lista de dataframes
dfs <- list(T_12 = T_12, T_14 = T_14)

# Renomear as colunas e sobrescrever os arquivos .csv
for(i in names(dfs)){
  write.csv(dfs[[i]], file = file.path(caminho_para_csv, paste0(i, ".csv")), row.names = FALSE, quote = FALSE)
}
