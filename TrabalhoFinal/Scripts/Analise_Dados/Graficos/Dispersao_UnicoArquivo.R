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
# Insira o nome do arquivo CSV e as variáveis que deseja analisar
nome_arquivo <- "T_01.csv"
variavel1 <- "Famlias_01"
variavel2 <- "Emp_01"
variavel_original1 <- "Famílias"
variavel_original2 <- "Empregos"


# Importar o arquivo CSV
df <- read.csv(file.path(caminho_para_csv, nome_arquivo), stringsAsFactors = FALSE, check.names = FALSE)

# Verifique se as variáveis existem no dataframe
if (!(variavel1 %in% colnames(df))) {
  stop(paste("A variável", variavel1, "não foi encontrada no dataframe df."))
}

if (!(variavel2 %in% colnames(df))) {
  stop(paste("A variável", variavel2, "não foi encontrada no dataframe df."))
}

# Crie o gráfico de dispersão
plot <- ggplot(df, aes_string(x=variavel1, y=variavel2)) +
  geom_point(size = 1) +  # ajuste o tamanho do ponto aqui
  geom_smooth(method = lm, color = "red") +  # adicione uma linha de tendência
  labs(x = variavel_original1, y = variavel_original2, title = paste("Gráfico de dispersão de", variavel_original1, "vs", variavel_original2)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # ajuste a posição e o ângulo do título do eixo x

# Exibe o gráfico
print(plot)

# Salva o gráfico como um arquivo .png com dimensões maiores para melhor qualidade
ggsave(filename = file.path(caminho_graficos, paste0("ScatterPlot_", variavel1, "_vs_", variavel2, ".png")), plot, dpi = 108, width = 1920/108, height = 1080/108)
