# 1. Definindo o diretório de trabalho
setwd("~/AnaliseDeDados_2023.02")
getwd()

# 2. Importando a base de dados
agua1 <- read.csv2("Aula02/Dados/agua1.csv", encoding="UTF-8")

# 3. Explorando os dados
# PS: Podem ser utilizadas em qualquer tipo de extensão
# Seja em .csv, .xlsx, etc
View(agua1) # Tabela parecida com .xlsx
names(agua1) # variaveis da base de dados
head(agua1) # N primeiras linhas. Default n = 6
tail(agua1) # N ultimas linhas . Default n = 6
str(agua1) # Estrutura de uma base de dados em objetos
summary(agua1) # Sumario de estatisticas descritivas para todas as variaveis NÚMERICAS

# 4. Criando um subconjunto (filtrar observações e selecionar variáveis)
agua1[1:6,] # Primeira 6 Observações
agua1[1:6,9] # Primeiras 6 observações - Coluna 9 (IDH)
agua1[1:6,"IDH"] # Primeiras 6 observações - Coluna (IDH)
agua1[1:6,]$IDH # Primeiras 6 Observações acessando a variavel $IDH da base de dados
agua1[1:6,c("NOME_MUN", "IDH")]
agua1[which(agua1$UF == "SP" & agua1$IDH > 0.85),c("NOME_MUN", "IDH")] # Similar a uma Query em SQL

# 5. Criando tabelas de contingência
table(agua1$IDH_CLASS) # Frequencia da variavel IDH_Class no banco de dados.
table(agua1$REGIAO, agua1$IDH_CLASS) # Frequencia de duas variaveis (REGIAO e IDH_CLASS) em uma tabela 2x2

# 6. Definindo uma nova variável
agua1$CONSUMO1 <- agua1$AG020 * 1000 / agua1$GE012 # Criação e atribuição de variaveis na base de dados
agua1$CONSUMO2 = agua1$AG020 * 1000 / agua1$AG001
head(agua1)

# 7. Calculando estatísticas básicas (média, mediana, variância, desvio padrão)
mean(agua1$CONSUMO1, na.rm = TRUE) # mean = Média, na.rm = N/A
median(agua1$CONSUMO1, na.rm = TRUE)# median = Mediana
var(agua1$CONSUMO1, na.rm = TRUE)# var = Variancia
sd(agua1$CONSUMO1, na.rm = TRUE)# sd = Desvio padrão (standard deviation)

# 8. Gráficos

boxplot(agua1$CONSUMO1) # Grafico Box-plot
hist(agua1$CONSUMO1) # Gráfico Histograma
qqnorm(agua1$CONSUMO1) # Gráfico QQ Plot Normal
qqline(agua1$CONSUMO1, col = "red") # Curva Normal  - Quantos mais proximos desta linha, mais proximos estão da Curva Normal destas observações 

# 9. Exportando um gráfico

# Box-plot
png("Aula02/graficos/boxplot_CONSUMO1.png") # Caminho para salvar o gráfico em png
boxplot(agua1$CONSUMO1)
dev.off() # Salva o ultimo gráfico plotado

# Histograma
png("Aula02/graficos/histograma_CONSUMO1.png")
hist(agua1$CONSUMO1)
dev.off()
# Qqplot
png("Aula02/graficos/qqplot_CONSUMO1.png")
qqnorm(agua1$CONSUMO1)
qqline(agua1$CONSUMO1, col = "blue")
dev.off()

# 10. Exportando a base de dados
write.csv2(agua1, "~/AnaliseDeDados_2023.02/Aula02/Dados/agua2.csv", row.names = FALSE) # row.names é similar a identificadores de um DB como SQL Server.
