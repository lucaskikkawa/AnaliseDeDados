# Limpeza_Dados.R

# Instalação Pacotes
if (!require(RSQLite)) {
  install.packages("RSQLite")
}

if (!require(dplyr)) {
  install.packages("dplyr")
}

if (!require(tidyverse)) {
  install.packages("tidyverse")
}

library(tidyverse)
library(RSQLite)
library(dplyr)

# Define o caminho onde os bancos de dados estão armazenados
caminho_para_db <- "~/AnaliseDeDados/TrabalhoFinal/Database/"

# Verifica se existem bancos de dados
bancos_de_dados <- list.files(caminho_para_db, pattern="\\.sqlite$")
if(length(bancos_de_dados) == 0){
  cat("Não existem bancos de dados. Por favor, adicione bancos de dados.\n")
  quit()
}

# Pede ao usuário para escolher um banco de dados
cat("Bancos de dados disponíveis:\n")
for(i in 1:length(bancos_de_dados)){
  cat(sprintf("%d = %s\n", i, bancos_de_dados[i]))
}
escolha_db <- as.integer(readline(prompt="Escolha um número correspondente ao banco de dados: "))
nome_db <- bancos_de_dados[escolha_db]
caminho_completo_db <- file.path(caminho_para_db, nome_db)

# Cria a conexão com o banco de dados escolhido
con <- dbConnect(SQLite(), caminho_completo_db)

# Lista as tabelas existentes no banco de dados escolhido
tabelas <- dbListTables(con)
if(length(tabelas) == 0){
  cat(sprintf("Não existem tabelas no banco de dados \"%s\". Por favor, importe dados primeiro.\n", nome_db))
  quit()
}

# Pede ao usuário para escolher uma tabela para limpar
cat("Tabelas disponíveis no banco de dados:\n")
for(i in 1:length(tabelas)){
  cat(sprintf("%d = %s\n", i, tabelas[i]))
}
escolha_tabela <- as.integer(readline(prompt="Escolha um número correspondente à tabela: "))
nome_tabela <- tabelas[escolha_tabela]

# Lê os dados da tabela escolhida
dados <- dbReadTable(con, nome_tabela)

# Remove linhas duplicadas e linhas onde todas as colunas são NA
dados <- dados %>%
  distinct() %>%
  filter(!is.na(rowSums(is.na(.))))

# Limita todos os valores decimais para apenas 3 casas decimais
dados <- dados %>%
  mutate(across(where(is.double), ~round(., 3)))

# Sobrescreve a tabela original com os dados limpos
dbWriteTable(con, name=nome_tabela, value=dados, row.names=FALSE, overwrite=TRUE)

# Informa ao usuário que a limpeza foi bem-sucedida
cat(sprintf("Os dados da tabela \"%s\" foram limpos com sucesso.\n", nome_tabela))

# Fecha a conexão com o banco de dados
dbDisconnect(con)
