# Aula de Econometria 1
# Profa. Sueli Moro
# Neylson Crepalde
#########################

# Aula 2 - 14/03/2017
#####################

setwd('~/Documentos/Neylson Crepalde/Doutorado/Econometria1/AULAS 2017')

library(foreign)
library(magrittr)
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
dados$qi_sd = dados$qi/sd(dados$qi)

reg_loglinsd = lm(lsal ~ educ + exper + I(exper**2) + qi_sd + perm + casado +
                    negro + sul + urban, data=dados)
summary(reg_loglinsd)

################################
# regressao com salario/1000

reg_linlin_pormil = lm(I(salario/1000) ~ educ + exper + I(exper**2) + qi + perm + casado +
                  negro + sul + urban, data=dados)
summary(reg_linlin_pormil)


###################################
library(MASS)
mat = model.matrix(salario ~ . -salario, data=dados)
View(mat)
X = mat[,1:17]
Y = mat[,18]
b = solve(t(X) %*% X) %*% t(X)%*%Y


#######################################
#Calculando Soma dos quadrados dos residuos
e = Y - X%*%b
sigma2 = (t(e)%*%e) / 925

invertida = solve(t(X) %*% X)

vcb = numeric(sigma2) * invertida # deu ruim

sum(residuals(reg_loglin)^2) # Achei o SQR

##Continuar ######################
espuria = read.dta('espuria.dta')
names(espuria)

reg_espuria = lm(emprestimos ~ roubos, data=espuria)
summary(reg_espuria)

mat = model.matrix(espuria$emprestimos ~ espuria$roubos)
View(mat)
X = cbind(1,espuria$roubos)
Y = espuria$emprestimos

b = solve(t(X) %*% X) %*% t(X)%*%Y

e = Y-X%*%b

xe = t(X)%*%e
sigma2 = t(e)%*%e/70

vcov(reg_espuria)

vcb <- as.numeric(sigma2) * solve(t(X)%*%X)


# curiosidade: a media do vetor é igual à media do y chapeu - algebra
mean(espuria$emprestimos)
yhat = predict(lm(emprestimos ~ roubos, data=espuria)); mean(yhat)
