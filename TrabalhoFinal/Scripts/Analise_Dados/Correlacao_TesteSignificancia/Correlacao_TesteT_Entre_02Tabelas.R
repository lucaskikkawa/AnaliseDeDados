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
caminho_graficos <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/Exportados/Graficos"
caminho_significancia <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/Exportados/Teste_Significancia"

# Importar dados CSV
# T_16 <- read.csv(file.path(caminho_para_csv, "ZOrigem/Percentual_T_16.csv"), stringsAsFactors = FALSE, check.names = FALSE)
# T_05 <- read.csv(file.path(caminho_para_csv, "ZResidencia/Percentual_T_05.csv"), stringsAsFactors = FALSE, check.names = FALSE)
# T_08 <- read.csv(file.path(caminho_para_csv, "ZResidencia/Percentual_T_08.csv"), stringsAsFactors = FALSE, check.names = FALSE)


#Criar lista de dataframes
# dataframes <- list("T_16" = T_16, "T_08" = T_08)

# Função para calcular matriz de correlação e teste de significância T
corr_signif_matrix <- function(df1, df2, df1_name, df2_name) {
  # Verificar e remover coluna "Zona" se existir
  if ("Zona" %in% colnames(df1)) {
    df1 <- df1 %>% select(-Zona)
  }
  
  if ("Zona" %in% colnames(df2)) {
    df2 <- df2 %>% select(-Zona)
  }
  
  # Verificar e remover coluna "Total" se existir
  if ("Total" %in% colnames(df1)) {
    df1 <- df1 %>% select(-Total)
  }
  
  if ("Total" %in% colnames(df2)) {
    df2 <- df2 %>% select(-Total)
  }
  
  # Selecione apenas as colunas numéricas dos dataframes
  df1_numeric <- df1[,sapply(df1, is.numeric)]
  df2_numeric <- df2[,sapply(df2, is.numeric)]
  
  # Calcular matriz de correlação e teste de significância
  for(i in colnames(df1_numeric)) {
    for(j in colnames(df2_numeric)) {
      corr_test <- cor.test(df1_numeric[[i]], df2_numeric[[j]], method = "pearson")
      
      # Decidir se a hipótese nula foi rejeitada
      decision <- ifelse(corr_test$p.value < 0.05, "Hipótese nula rejeitada", "Hipótese nula não rejeitada")
      
      # Calcular graus de liberdade corretos
      df_corrected <- nrow(df1_numeric) - 2
      
      # Salvar o resultado do teste de significância
      cat(paste(df1_name, ":", i, "and", df2_name, ":", j, "\n", 
                "t = ", round(corr_test$statistic, 2), "\n",
                "df (corrected) = ", df_corrected, "\n",
                "p-value = ", round(corr_test$p.value, 2), "\n",
                "95 percent confidence interval: ", round(corr_test$conf.int[1], 2), "to", round(corr_test$conf.int[2], 2), "\n",
                "cor = ", round(corr_test$estimate["cor"], 2), "\n",
                "Decision: ", decision, "\n\n"), 
          file = file.path(caminho_significancia, paste("Significance_", df1_name, "_vs_", df2_name, ".txt")), append = TRUE)
    }
  }
  
  # Calcular matriz de correlação para plot
  corr <- cor(df1_numeric, df2_numeric, use = "complete.obs")
  
  # Criar e salvar o gráfico
  png(file = file.path(caminho_graficos, paste0("Matriz_Correlacao_", df1_name, "_vs_", df2_name, ".png")))
  corrplot(corr, method = "circle")
  dev.off()
}



# Aplicar a função a cada combinação de dataframe
for(i in 1:(length(dataframes)-1)) {
  for(j in (i+1):length(dataframes)) {
    corr_signif_matrix(dataframes[[i]], dataframes[[j]], names(dataframes[i]), names(dataframes[j]))
  }
}
