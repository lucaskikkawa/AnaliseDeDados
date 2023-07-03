# Remoção de Banco de Dados em RSQLite

# Instalação Pacotes

# Verifica se o pacote RSQLite está instalado
if (!require(RSQLite)) {
  # Se não está instalado, instala o pacote
  install.packages("RSQLite")
}
# Importação Pacotes
library(RSQLite)

#----------------------------------------------------------------------

# Define o caminho onde os bancos de dados estão armazenados
caminho_para_db <- "~/AnaliseDeDados/TrabalhoFinal/Database/"


# Lista todos os bancos de dados existentes
bancos_de_dados <- list.files(caminho_para_db, pattern="\\.sqlite$")

# Enumera e imprime todos os bancos de dados existentes
cat("Bancos de Dados Existentes:\n")
for(i in 1:length(bancos_de_dados)){
  cat(sprintf("%d = %s\n", i, bancos_de_dados[i]))
}
cat("\n")


# Pergunta se o usuario deseja remover um banco de dados
inicio <- readline(prompt="Deseja remover um banco de dados? S = Sim, N = Não: ")


# Verifica se o usuario deseja remover um banco de dados
if(tolower(inicio) == "s"){
  cat("\n")
  
  # Loop infinito até que o usuário decida sair
  while (TRUE) {

    # Solicita ao usuário o número do banco de dados a ser removido
    numero_db <- as.integer(readline(prompt="Digite o número do banco de dados a remover: "))
    
    # Checa se o número fornecido é válido
    if(numero_db < 1 || numero_db > length(bancos_de_dados)) {
      cat("Número inválido. Por favor, tente novamente.\n")
      next
    }
    
    # Constrói o caminho completo para o banco de dados a ser removido
    caminho_completo_db <- file.path(caminho_para_db, bancos_de_dados[numero_db])
    
    # Remove o banco de dados SQLite
    file.remove(caminho_completo_db)
    cat(sprintf("Banco de dados \"%s\" removido com sucesso.\n", toupper(bancos_de_dados[numero_db])))
    
    # Pergunta ao usuário se ele deseja continuar
    continuar <- readline(prompt="Deseja remover outro banco de dados? S = Sim, N = Não: ")
    
    # Sai do loop se o usuário digitou 'n'
    if (tolower(continuar) == 'n') {
      break
    }
    
    # Lista todos os bancos de dados existentes
    bancos_de_dados <- list.files(caminho_para_db, pattern="\\.sqlite$")
    
    # Enumera e imprime todos os bancos de dados existentes
    cat("\nBancos de Dados Existentes:\n")
    for(i in 1:length(bancos_de_dados)){
      cat(sprintf("%d = %s\n", i, bancos_de_dados[i]))
    }
    cat("\n")
    
  }
}

