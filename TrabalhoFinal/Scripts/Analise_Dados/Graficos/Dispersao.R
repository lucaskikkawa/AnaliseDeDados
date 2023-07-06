# Instalação de pacotes
if (!require(dplyr)) {
  # Se não está instalado, instala o pacote
  install.packages("dplyr")
}

if (!require(ggplot2)) {
  # Se não está instalado, instala o pacote
  install.packages("ggplot2")
}

# Carregar pacotes
library(dplyr)
library(ggplot2)

# Caminho para os dados CSV
caminho_para_csv <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/csv/"
caminho_graficos <- "~/AnaliseDeDados/TrabalhoFinal/Dados/OD/Exportados/Graficos"

# Importar dados CSV
# Insira os nomes dos arquivos CSV e as variáveis que deseja analisar
#nome_arquivo1 <- "ZOrigem/Percentual_T_16.csv"
nome_arquivo1 <- "ZOrigem/T_16.csv"
#nome_arquivo2 <- "ZResidencia/Percentual_T_05.csv"
nome_arquivo2 <- "ZResidencia/T_05.csv"
variavel1 <- "APé_16"
variavel2 <- "RF1_05"

# Importar os arquivos CSV
df1 <- read.csv(file.path(caminho_para_csv, nome_arquivo1), stringsAsFactors = FALSE, check.names = FALSE)
df2 <- read.csv(file.path(caminho_para_csv, nome_arquivo2), stringsAsFactors = FALSE, check.names = FALSE)

# Verifique se as variáveis existem nos dataframes
if (!(variavel1 %in% colnames(df1))) {
  stop(paste("A variável", variavel1, "não foi encontrada no dataframe df1."))
}

if (!(variavel2 %in% colnames(df2))) {
  stop(paste("A variável", variavel2, "não foi encontrada no dataframe df2."))
}

# Combine os dataframes em um único dataframe
df <- data.frame(var1 = df1[[variavel1]], var2 = df2[[variavel2]])

# Crie o gráfico de dispersão
plot <- ggplot(df, aes(x=var1, y=var2)) +
  geom_point(size = 1) +  # ajuste o tamanho do ponto aqui
  geom_smooth(method = lm, color = "red") +  # adicione uma linha de tendência
  labs(x = variavel1, y = variavel2, title = paste("Gráfico de dispersão de", variavel1, "vs", variavel2)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # ajuste a posição e o ângulo do título do eixo x

# Exibe o gráfico
print(plot)

# Salva o gráfico como um arquivo .png com dimensões maiores para melhor qualidade
ggsave(filename = file.path(caminho_graficos, paste0("ScatterPlot_", variavel1, "_vs_", variavel2, ".png")), plot, dpi = 108, width = 1920/108, height = 1080/108)
