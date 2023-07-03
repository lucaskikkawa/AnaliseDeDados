# Matriz_Correlacao_Zonas.R

# Instalação de pacotes
if (!require(dplyr)) {
  # Se não está instalado, instala o pacote
  install.packages("dplyr")
}

if (!require(corrplot)) {
  # Se não está instalado, instala o pacote
  install.packages("corrplot")
}

if (!require(tidyverse)) {
  # Se não está instalado, instala o pacote
  install.packages("tidyverse")
}

# Carregar pacotes
library(dplyr)
library(corrplot)
library(tidyverse)

# Caminho para os dados CSV
caminho_para_csv <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/Exportados/"

# Importar dados CSV
zorigem <- read.csv(file.path(caminho_para_csv, "ZOrigem.csv"), stringsAsFactors = FALSE, check.names = FALSE)
zdestino <- read.csv(file.path(caminho_para_csv, "ZDestino.csv"), stringsAsFactors = FALSE, check.names = FALSE)
zemprego <- read.csv(file.path(caminho_para_csv, "ZEmprego.csv"), stringsAsFactors = FALSE, check.names = FALSE)
zresidencia <- read.csv(file.path(caminho_para_csv, "ZResidencia.csv"), stringsAsFactors = FALSE, check.names = FALSE)

# Lista dos dataframes e seus nomes
dataframes <- list(zorigem = zorigem, zdestino = zdestino, zemprego = zemprego, zresidencia = zresidencia)

# Função para calcular matriz de correlação e salvar o gráfico
corr_matrix <- function(df, df_name) {
  # Remover coluna "Zona"
  df <- df %>% select(-Zona)
  
  # Calcular matriz de correlação
  corr <- df %>%
    select_if(is.numeric) %>%
    cor(method = "pearson", use = "complete.obs")
  
  # Criar e salvar o gráfico
  png(file = file.path(caminho_para_csv, paste0("Matriz_Correlacao_", df_name, ".png")))
  corrplot(corr, method = "circle")
  dev.off()
}

# Aplicar a função a cada dataframe
for(i in names(dataframes)){
  corr_matrix(dataframes[[i]], i)
}
