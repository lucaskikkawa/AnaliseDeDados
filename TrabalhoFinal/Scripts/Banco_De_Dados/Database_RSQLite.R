# Instalação Pacotes
#install.packages("RSQLite")
#install.packages("haven")


# Importação Bibliotecas
library(RSQLite)
library(haven)

# Importação dados
dado_od <- read_spss("AnaliseDeDados/TrabalhoFinal/Dados/Pesquisa_OrigemDestino_2017/Banco de Dados-OD2017/OD_2017_v1.sav")


# Iniciar Conexão com o Banco de Dados (Caso o Banco de Dados não exista, ele será criado)
con <- dbConnect(RSQLite::SQLite(), dbname="~/AnaliseDeDados/TrabalhoFinal/Database/Database_Trabalho_Final.sqlite")
# -----------------------------------------------------------------
# CRUD - Create, Read, Update, Delete

# CREATE - Criar uma tabela
dbWriteTable(con, "DADOS_OD", dado_od, overwrite=TRUE)

# -----------------------------------------------------------------

# READ
# Exemplo de uma query - Obter dados da coluna zona da tabela DADOS_OD
resultado <- dbGetQuery(con, "SELECT ZONA FROM DADOS_OD")

View(resultado)

# UPDATE
#dbExecute(con, "UPDATE DADOS_OD SET zona = 26 WHERE zona renda_fa = 0" )

# DELETE
dbExecute(con, "DELETE FROM DADOS_OD WHERE zona = 2")


#Fechar conexão com o Banco de Dados (Sempre fechar a conexão)
dbDisconnect(con)

