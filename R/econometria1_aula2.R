# Aula de Econometria 1
# Profa. Sueli Moro
# Neylson Crepalde
#########################

# Aula 2 - 14/03/2017
#####################

setwd('~/Documentos/Neylson Crepalde/Doutorado/Econometria1/AULAS 2017')

library(foreign)
dados = read.dta('wages_935.dta') #Funcionando

dados$lsal = log(dados$salario) # Gerando log de salario
dados$exper2 = dados$exper**2   # Gerando exeriencia ao quadrado

reg_loglin = lm(lsal ~ educ + exper + I(exper**2) + qi + perm + casado +
           negro + sul + urban, data=dados)
reg_linlin = lm(salario ~ educ + exper + I(exper**2) + qi + perm + casado +
                  negro + sul + urban, data=dados)

summary(reg_loglin) #Interpretacao percentual do salario
summary(reg_linlin) #Interpretacao em variacao na unidade (dolares)

# Termo quadrático a gente interpreta sempre levando em conta os dois termos
# Tira a derivada do salario em relacao a experiencia
# dsalario/dexper

experiencia = 20.27 - 2*0.27

# Verificando coeficientes beta (padronizado em escala de desvios-padrao)

sd(dados$qi)
mean(dados$qi)

# Rodando a regressao com desvio padrao de qi



