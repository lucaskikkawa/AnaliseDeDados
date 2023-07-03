# Matriz_Correlacao_Positivas_Negativas.R

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

# Função para calcular matriz de correlação e criar gráficos de correlação forte positiva e negativa
corr_matrix <- function(df, df_name) {
  # Remover coluna "Zona"
  df <- df %>% select(-Zona)
  
  # Calcular matriz de correlação
  corr <- df %>%
    select_if(is.numeric) %>%
    cor(method = "pearson", use = "complete.obs") %>%
    round(digits=2)
  
  # Identificar correlações fortes positivas e negativas
  corr_pos <- corr
  corr_neg <- corr
  corr_pos[corr_pos < 0.6 | row(corr_pos) == col(corr_pos)] <- NA
  corr_neg[corr_neg > -0.6 | row(corr_neg) == col(corr_neg)] <- NA
  
  # Removendo colunas e linhas completamente NA para criar matrizes com variáveis fortemente correlacionadas
  corr_pos <- corr_pos[ , colSums(is.na(corr_pos)) != nrow(corr_pos)]
  corr_pos <- corr_pos[rowSums(is.na(corr_pos)) != ncol(corr_pos), ]
  
  corr_neg <- corr_neg[ , colSums(is.na(corr_neg)) != nrow(corr_neg)]
  corr_neg <- corr_neg[rowSums(is.na(corr_neg)) != ncol(corr_neg), ]
  
  # Verificar se as matrizes de correlação positiva e negativa são vazias
  if (!is.null(ncol(corr_pos))) {
    # Criar e salvar os gráficos de correlação forte positiva
    png(file = file.path(caminho_para_csv, paste0("Correlacao_Positiva_", df_name, ".png")))
    corrplot(corr_pos, method = "number")
    dev.off()
  }
  
  if (!is.null(ncol(corr_neg))) {
    # Criar e salvar os gráficos de correlação forte negativa
    png(file = file.path(caminho_para_csv, paste0("Correlacao_Negativa_", df_name, ".png")))
    corrplot(corr_neg, method = "number")
    dev.off()
  }
}

# Aplicar a função a todos os dataframes
lapply(names(dataframes), function(df_name) {
  corr_matrix(dataframes[[df_name]], df_name)
})
