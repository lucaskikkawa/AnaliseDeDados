# Matriz_Conversao_Percentual.R

# Instalação de pacotes
if (!require(dplyr)) {
  # Se não está instalado, instala o pacote
  install.packages("dplyr")
}

if (!require(readr)) {
  # Se não está instalado, instala o pacote
  install.packages("readr")
}

# Carregar pacotes
library(dplyr)
library(readr)

# Caminho para os dados CSV
caminho_para_csv <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/csv/"
caminho_para_exportar <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/Exportados/ZOrigem"

# Importar dados CSV
df <- read.csv(file.path(caminho_para_csv, "ZOrigem/T_20.csv"), stringsAsFactors = FALSE, check.names = FALSE)

# Converter todas as colunas, exceto a primeira e a última, para valores percentuais em relação à coluna 'Total'
df <- df %>%
  mutate_at(vars(-Zona, -Total), ~ ceiling(. / df$Total * 100 * 100) / 100)

# Arredondar todas as colunas, exceto a primeira e a última, para duas casas decimais
df <- df %>%
  mutate_at(vars(-Zona, -Total), round, 2)

# Sobrescrever o arquivo csv original, mas com um novo nome e em um novo diretório, sem aspas
write.csv(df, file.path(caminho_para_exportar, "Percentual_T_20.csv"), row.names = FALSE, quote = FALSE)
