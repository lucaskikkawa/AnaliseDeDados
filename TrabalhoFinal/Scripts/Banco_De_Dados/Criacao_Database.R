# Criação de Banco de Dados em RSQLite

# Instalação Pacotes

# Verifica se o pacote RSQLite está instalado
if (!require(RSQLite)) {
  # Se não está instalado, instala o pacote
  install.packages("RSQLite")
}

# Importação Pacotes
library(RSQLite)

#----------------------------------------------------------------------

# Define o caminho onde os bancos de dados serão armazenados
caminho_para_db <- "~/AnaliseDeDados/TrabalhoFinal/Database/"


# Lista todos os bancos de dados existentes
bancos_de_dados <- list.files(caminho_para_db, pattern="\\.sqlite$")


# Enumera e imprime todos os bancos de dados existentes
cat("\nBancos de Dados Existentes:\n")
for(i in 1:length(bancos_de_dados)){
  cat(sprintf("%d = %s\n", i, bancos_de_dados[i]))
}
cat("\n")


# Pergunta se o usuario deseja criar um banco de dados
inicio <- readline(prompt="Deseja criar um banco de dados? S = Sim, N = Não: ")


# Verifica se o usuario deseja criar um banco de dados
if(tolower(inicio) == "s"){
  cat("\n")
  
  # Loop infinito até que o usuário decida sair
  while (TRUE) {
    
    # Solicita ao usuário o nome do banco de dados
    nome_db <- readline(prompt="Digite o nome do banco de dados a criar: ")
    
    # Constrói o caminho completo para o banco de dados
    caminho_completo_db <- file.path(caminho_para_db, paste0(nome_db, ".sqlite"))
    
    # Verifica se o banco de dados já existe
    if (file.exists(caminho_completo_db)) {
      cat(sprintf("O banco de dados \"%s\" já existe.\n", toupper(nome_db)))
      cat("\n")
    } else {
      # Cria o banco de dados SQLite
      con <- dbConnect(SQLite(), dbname=caminho_completo_db)
      dbDisconnect(con)
      cat(sprintf("Banco de dados \"%s\" criado com sucesso.\n", toupper(nome_db)))
      cat("\n")
    }
    
    # Pergunta ao usuário se ele deseja continuar
    continuar <- readline(prompt="Deseja criar outro banco de dados? S = Sim, N = Não: ")
    
    # Sai do loop se o usuário digitou 'n'
    if (tolower(continuar) == 'n') {
      break
    }
    
    # Lista todos os bancos de dados existentes
    bancos_de_dados <- list.files(caminho_para_db, pattern="\\.sqlite$")
    
    # Enumera e imprime todos os bancos de dados existentes
    cat("Bancos de Dados Existentes:\n")
    for(i in 1:length(bancos_de_dados)){
      cat(sprintf("%d = %s\n", i, bancos_de_dados[i]))
    }
    cat("\n")
  }
}
