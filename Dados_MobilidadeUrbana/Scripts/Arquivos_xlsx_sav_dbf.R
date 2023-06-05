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

dado_xlsx = read_excel("C:/Users/lucas/OneDrive/Documentos/UFABC/AnaliseDeDados_2023.02/Dados_MobilidadeUrbana/OD-2017/Banco de Dados-OD2017/LAYOUT OD2017_v1.xlsx")
dado_dbf = read.dbf("C:/Users/lucas/OneDrive/Documentos/UFABC/AnaliseDeDados_2023.02/Dados_MobilidadeUrbana/OD-2017/Banco de Dados-OD2017/OD_2017_v1.dbf")
dado_sav = read_spss("C:/Users/lucas/OneDrive/Documentos/UFABC/AnaliseDeDados_2023.02/Dados_MobilidadeUrbana/OD-2017/Banco de Dados-OD2017/OD_2017_v1.sav")