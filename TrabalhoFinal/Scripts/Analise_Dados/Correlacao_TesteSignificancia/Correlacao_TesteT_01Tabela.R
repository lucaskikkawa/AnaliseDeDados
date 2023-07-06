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
caminho_para_csv <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/csv"
caminho_graficos <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/Exportados/Graficos"
caminho_significancia <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/Exportados/Teste_Significancia"

# Importar dados CSV
nome_arquivo <- "T_01.csv"
df <- read.csv(file.path(caminho_para_csv, nome_arquivo), stringsAsFactors = FALSE, check.names = FALSE)

# Função para calcular matriz de correlação e teste de significância T
corr_signif_matrix <- function(df, df_name) {
  # Verificar e remover coluna "Zona" se existir
  if ("Zona" %in% colnames(df)) {
    df <- df %>% select(-Zona)
  }
  
  # Verificar e remover coluna "Total" se existir
  if ("Total" %in% colnames(df)) {
    df <- df %>% select(-Total)
  }
  
  # Selecione apenas as colunas numéricas dos dataframes
  df_numeric <- df[,sapply(df, is.numeric)]
  
  # Calcular matriz de correlação e teste de significância
  for(i in colnames(df_numeric)) {
    for(j in colnames(df_numeric)) {
      if (i != j) {  # Evitar correlação de uma variável com ela mesma
        corr_test <- cor.test(df_numeric[[i]], df_numeric[[j]], method = "pearson")
        
        # Decidir se a hipótese nula foi rejeitada
        decision <- ifelse(corr_test$p.value < 0.05, "Hipótese nula rejeitada", "Hipótese nula não rejeitada")
        
        # Calcular graus de liberdade corretos
        df_corrected <- nrow(df_numeric) - 2
        
        # Salvar o resultado do teste de significância
        cat(paste(df_name, ":", i, "and", df_name, ":", j, "\n", 
                  "t = ", round(corr_test$statistic, 2), "\n",
                  "df (corrected) = ", df_corrected, "\n",
                  "p-value = ", round(corr_test$p.value, 2), "\n",
                  "95 percent confidence interval: ", round(corr_test$conf.int[1], 2), "to", round(corr_test$conf.int[2], 2), "\n",
                  "cor = ", round(corr_test$estimate["cor"], 2), "\n",
                  "Decision: ", decision, "\n\n"), 
        file = file.path(caminho_significancia, paste("Significance_", df_name, ".txt")), append = TRUE)
      }
    }
  }
  
  # Calcular matriz de correlação para plot
  corr <- cor(df_numeric, use = "complete.obs")
  
  # Criar e salvar o gráfico
  png(file = file.path(caminho_graficos, paste0("Matriz_Correlacao_", df_name, ".png")))
  corrplot(corr, method = "circle")
  dev.off()
}

# Aplicar a função ao dataframe
corr_signif_matrix(df, "T_01")
