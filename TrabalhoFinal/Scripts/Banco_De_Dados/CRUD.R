# CRUD_Operations.R

# Instalação Pacotes
if (!require(RSQLite)) {
  install.packages("RSQLite")
}

library(RSQLite)

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

# Pede ao usuário para digitar uma consulta SQL
consulta_sql <- readline(prompt="Digite sua consulta SQL: ")

# Bloco tryCatch para lidar com possíveis erros SQL
tryCatch({
  # Executa a consulta SQL
  resultado <- dbSendQuery(con, consulta_sql)
  
  # Busca os dados
  dados <- dbFetch(resultado)
  
  # Imprime os dados obtidos
  print(dados)
}, error = function(e) {
  print(paste("Erro: ", e))
})

# Fecha a conexão com o banco de dados
dbDisconnect(con)
