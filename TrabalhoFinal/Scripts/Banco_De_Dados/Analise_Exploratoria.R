# Analise_Exploratoria.R

# Instalando e carregando pacotes necessários
if (!require(RSQLite)) install.packages("RSQLite")
if (!require(dplyr)) install.packages("dplyr")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(corrplot)) install.packages("corrplot")

library(RSQLite)
library(dplyr)
library(ggplot2)
library(corrplot)

# Definindo o caminho para o banco de dados
caminho_para_db <- "~/AnaliseDeDados/TrabalhoFinal/Database/"

# Verificando se existem bancos de dados
bancos_de_dados <- list.files(caminho_para_db, pattern="\\.sqlite$")
if(length(bancos_de_dados) == 0){
  cat("Não existem bancos de dados. Por favor, adicione bancos de dados.\n")
  quit()
}

# Pedindo ao usuário para escolher um banco de dados
cat("Bancos de dados disponíveis:\n")
for(i in 1:length(bancos_de_dados)){
  cat(sprintf("%d = %s\n", i, bancos_de_dados[i]))
}
escolha_db <- as.integer(readline(prompt="Escolha um número correspondente ao banco de dados: "))
nome_db <- bancos_de_dados[escolha_db]
caminho_completo_db <- file.path(caminho_para_db, nome_db)

# Conectando ao banco de dados escolhido
con <- dbConnect(SQLite(), caminho_completo_db)

# Listando as tabelas disponíveis no banco de dados
tabelas <- dbListTables(con)
if(length(tabelas) == 0){
  cat(sprintf("Não existem tabelas no banco de dados \"%s\". Por favor, importe dados primeiro.\n", nome_db))
  dbDisconnect(con)
  quit()
}

# Pedindo ao usuário para escolher uma tabela para análise
cat("Tabelas disponíveis:\n")
for(i in 1:length(tabelas)){
  cat(sprintf("%d = %s\n", i, tabelas[i]))
}
escolha_tabela <- as.integer(readline(prompt="Escolha um número correspondente à tabela: "))
nome_tabela <- tabelas[escolha_tabela]

# Buscando os dados da tabela escolhida
dados <- dbReadTable(con, nome_tabela)

# Fechando a conexão com o banco de dados
dbDisconnect(con)

# Resumindo os dados
cat(sprintf("A tabela '%s' tem %d observações e %d variáveis.\n", nome_tabela, nrow(dados), ncol(dados)))
