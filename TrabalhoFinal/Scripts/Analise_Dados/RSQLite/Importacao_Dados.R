# Importacao_Dados.R

# Instalação Pacotes
if (!require(RSQLite)) {
  install.packages("RSQLite")
}
if (!require(haven)) {
  install.packages("haven")
}
if (!require(readxl)) {
  install.packages("readxl")
}

library(RSQLite)
library(haven)
library(readxl)

# Define o caminho onde os bancos de dados estão armazenados
caminho_para_db <- "~/AnaliseDeDados/TrabalhoFinal/Database/"
caminho_para_dados <- "~/AnaliseDeDados/TrabalhoFinal/Dados/"

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

# Pede ao usuário para escolher o tipo de arquivo que deseja importar
cat("Extensões disponíveis:\n1 = CSV\n2 = XLSX\n3 = SAV\n")
tipo_arquivo <- as.integer(readline(prompt="Por favor, digite o número da extensão que deseja utilizar: "))
if(tipo_arquivo == 1){
  tipo_arquivo <- "csv"
}else if(tipo_arquivo == 2){
  tipo_arquivo <- "xlsx"
}else if(tipo_arquivo == 3){
  tipo_arquivo <- "sav"
}

# Verifica quais arquivos do tipo escolhido existem
arquivos <- list.files(caminho_para_dados, pattern=paste0("\\.", tipo_arquivo, "$"))
if(length(arquivos) == 0){
  cat(sprintf("Não existem arquivos do tipo %s. Por favor, escolha outro tipo.\n", tipo_arquivo))
  quit()
}

# Pede ao usuário para escolher um arquivo para importar
cat("Arquivos disponíveis:\n")
for(i in 1:length(arquivos)){
  cat(sprintf("%d = %s\n", i, arquivos[i]))
}
escolha_arquivo <- as.integer(readline(prompt="Escolha um número correspondente ao arquivo que deseja importar: "))
nome_arquivo <- arquivos[escolha_arquivo]

# Define o nome da tabela como o nome do arquivo sem a extensão
nome_tabela <- sub(paste0("\\.", tipo_arquivo, "$"), "", nome_arquivo)

# Cria a conexão com o banco de dados escolhido
con <- dbConnect(SQLite(), caminho_completo_db)

# Lê os dados do arquivo escolhido e importa para o banco de dados
if(tipo_arquivo == "csv"){
  # Lê os dados do arquivo .csv
  dados <- read.csv2(file.path(caminho_para_dados, nome_arquivo))
}else if(tipo_arquivo == "sav"){
  # Lê os dados do arquivo .sav
  dados <- haven::read_spss(file.path(caminho_para_dados, nome_arquivo))
}else if(tipo_arquivo == "xlsx"){
  # Lê os dados do arquivo .xlsx
  dados <- readxl::read_excel(file.path(caminho_para_dados, nome_arquivo))
}

# Escreve os dados no banco de dados
dbWriteTable(con, name=nome_tabela, value=dados, row.names=FALSE, overwrite=TRUE)

# Informa ao usuário que a importação foi bem-sucedida
cat(sprintf("Os dados foram importados com sucesso para a tabela \"%s\".\n", nome_tabela))

# Fecha a conexão com o banco de dados
dbDisconnect(con)
