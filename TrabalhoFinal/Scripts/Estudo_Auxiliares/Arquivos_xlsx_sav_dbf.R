# Executar arquivos
# .xlsx
# .dbf
# .sav

# Instalação pacotes
# Utilizar estes comandos para instalar os pacotes, caso já não estejam
# instalados localmente.

#install.packages("foreign")
#install.packages("haven")
#install.packages("readxl")

# Import Packages
library(foreign)
library(haven)
library(readxl)

# Notebook Dell
#dado_xlsx = read_excel("C:/Users/lucas/OneDrive/Documentos/UFABC/AnaliseDeDados_2023.02/Dados_MobilidadeUrbana/OD-2017/Banco de Dados-OD2017/LAYOUT OD2017_v1.xlsx")
#dado_dbf = read.dbf("C:/Users/lucas/OneDrive/Documentos/UFABC/AnaliseDeDados_2023.02/Dados_MobilidadeUrbana/OD-2017/Banco de Dados-OD2017/OD_2017_v1.dbf")
#dado_sav = read_spss("C:/Users/lucas/OneDrive/Documentos/UFABC/AnaliseDeDados_2023.02/Dados_MobilidadeUrbana/OD-2017/Banco de Dados-OD2017/OD_2017_v1.sav")

# PC Casa
#dado_xlsx = read_excel("S:/UFABC/Disciplinas/PlanejamentoTerritorial/AnaliseDeDados/TrabalhoFinal/Dados/Pesquisa_OrigemDestino_2017/Banco de Dados-OD2017/LAYOUT OD2017_v1.xlsx")
#dado_dbf = read.dbf("S:/UFABC/Disciplinas/PlanejamentoTerritorial/AnaliseDeDados/TrabalhoFinal/Dados/Pesquisa_OrigemDestino_2017/Banco de Dados-OD2017/OD_2017_v1.dbf")
dado_sav = read_spss("S:/UFABC/Disciplinas/PlanejamentoTerritorial/AnaliseDeDados/TrabalhoFinal/Dados/Pesquisa_OrigemDestino_2017/Banco de Dados-OD2017/OD_2017_v1.sav")

#Ele não salvou o label como string e sim como double
dados_gerados_sav = read_spss("S:/UFABC/Disciplinas/PlanejamentoTerritorial/AnaliseDeDados/TrabalhoFinal/Dados/Gerados/RendaMedia_TipoTransporte.sav")

# Diferença entre sav gerado pelo script e do sav original
dados_gerados_sav[1:6,c("modoprin","renda_fa")]
dado_sav[1:6,c("modoprin","renda_fa")]


# View(dado_xlsx)
# names(dado_xlsx)
# head(dado_xlsx)
# tail(dado_xlsx)
# str(dado_xlsx)
# summary(dado_xlsx)

# View(dado_dbf)
# names(dado_dbf)
# head(dado_dbf)
# tail(dado_dbf)
# str(dado_dbf)
# summary(dado_dbf)

# View(dado_sav)
# names(dado_sav)
# head(dado_sav)
# tail(dado_sav)
# str(dado_sav)
# summary(dado_sav)

# Selecionar um subconjunto de uma base de dados

# Maneira mais simples
dados_gerados <- dado_sav[c("modoprin","zona","renda_fa","tipvg")]
# Maneira mais explicita
# subset(dado_sav, select = c("modoprin", "zona", "renda_fa", "tipvg"))

# Função para filtrar variáveis que possuem a palavra "Renda" nos metadados
#filtro_palavra_renda <- function(x) any(grepl("Renda", attributes(x)$label))

# Filtrar as variáveis que possuem a palavra "Renda" nos metadados
# variaveis_com_renda <- Filter(filtro_palavra_renda, dado_sav)
# nomes_variaveis_com_renda <- names(variaveis_com_renda)
# print(nomes_variaveis_com_renda)

# Escrever os dados no arquivo CSV
#write.csv2(dados_gerados, "S:/UFABC/Disciplinas/PlanejamentoTerritorial/AnaliseDeDados/TrabalhoFinal/Dados/Gerados/RendaMedia_TipoTransporte.csv", row.names = FALSE)

# Escrever os dados no arquivo SAV 
#write_sav(dados_gerados, "S:/UFABC/Disciplinas/PlanejamentoTerritorial/AnaliseDeDados/TrabalhoFinal/Dados/Gerados/RendaMedia_TipoTransporte.sav")

#-------------------------------------------------------

# Retornar Propriedades de um objeto
# attributes(dado_sav)

# Retornar Variaveis e Metadados de um objeto
# lapply(dado_sav, function(x) attributes(x)$label)


