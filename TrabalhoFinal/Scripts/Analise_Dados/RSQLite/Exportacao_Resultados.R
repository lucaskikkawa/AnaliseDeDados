# Exportacao_Resultados.R

# Instalação Pacotes
if (!require(DBI)) {
  install.packages("DBI")
}

if (!require(RSQLite)) {
  install.packages("RSQLite")
}

if (!require(writexl)) {
  install.packages("writexl")
}

if (!require(haven)) {
  install.packages("haven")
}

library(DBI)
library(RSQLite)
library(writexl)
library(haven)

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

# Pede ao usuário para escolher uma tabela para exportar ou informar uma consulta SQL
cat("Você deseja exportar uma tabela inteira ou uma consulta SQL?\n")
cat("1 = Exportar tabela inteira\n")
cat("2 = Exportar consulta SQL\n")
escolha <- as.integer(readline(prompt="Escolha um número correspondente à opção desejada: "))

# Pede ao usuário para escolher uma tabela ou informar uma consulta SQL baseado na escolha anterior
if(escolha == 1){
  # Lista as tabelas existentes no banco de dados escolhido
  tabelas <- dbListTables(con)
  if(length(tabelas) == 0){
    cat(sprintf("Não existem tabelas no banco de dados \"%s\". Por favor, importe dados primeiro.\n", nome_db))
    quit()
  } else {
    cat("Tabelas disponíveis no banco de dados:\n")
    for(i in 1:length(tabelas)){
      cat(sprintf("%d = %s\n", i, tabelas[i]))
    }
  }
  # Pede ao usuário para escolher uma tabela para exportar
  escolha_tabela <- as.integer(readline(prompt="Escolha um número correspondente à tabela que deseja exportar: "))
  nome_tabela <- tabelas[escolha_tabela]
  
  # Faz a leitura dos dados da tabela escolhida
  dados <- dbReadTable(con, nome_tabela)
  
}else if(escolha == 2){
  # Pede ao usuário para digitar uma consulta SQL
  consulta_sql <- readline(prompt="Digite sua consulta SQL: ")
  
  # Executa a consulta SQL
  resultado <- dbSendQuery(con, consulta_sql)
  
  # Busca todos os resultados
  dados <- dbFetch(resultado)
  dbClearResult(resultado)
}

# Pede ao usuário para fornecer um nome de arquivo para exportar
nome_arquivo <- readline(prompt="Digite o nome do arquivo para exportar (sem a extensão): ")

# Escolha a extensão do arquivo
cat("Escolha a extensão do arquivo:\n")
cat("1 = .csv\n")
cat("2 = .xlsx\n")
cat("3 = .sav\n")
escolha_extensao <- as.integer(readline(prompt="Escolha um número correspondente à extensão desejada: "))

# Caminho do arquivo de saída
caminho_para_saida <- "~/AnaliseDeDados/TrabalhoFinal/Dados/Exportados/"

# Exporta o resultado para um arquivo baseado na escolha da extensão
if (escolha_extensao == 1) {
  write.csv(dados, file = paste0(caminho_para_saida, nome_arquivo, ".csv"), row.names = FALSE)
} else if (escolha_extensao == 2) {
  write_xlsx(dados, path = paste0(caminho_para_saida, nome_arquivo, ".xlsx"))
} else if (escolha_extensao == 3) {
  write_sav(dados, path = paste0(caminho_para_saida, nome_arquivo, ".sav"))
} else {
  cat("Escolha da extensão do arquivo inválida.\n")
  quit()
}

cat("Exportação de dados concluída com sucesso!\n")

# Fecha a conexão com o banco de dados
dbDisconnect(con)
