#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Estimações
@author: Neylson Crepalde
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import statsmodels.formula.api as sm
import os

os.chdir('C:/Users/x6905399/Documents/Econometria1/AULAS 2017')

dados = pd.read_stata('wages_935.dta', preserve_dtypes=False) #Funcionando

dados.columns

dados['lsal'] = np.log(dados['salario'])
dados['exper2'] = dados['exper']**2
dados['constante'] = 1
#dados.dropna(axis=0, how='any')

reg_loglin = sm.ols(formula='lsal ~ educ + exper + exper2 + qi + perm \
                    + casado + negro + sul + urban', data=dados).fit()
print(reg_loglin.summary())


reg_linlin = sm.ols(formula='salario ~ educ + exper + exper2 + qi + perm \
                    + casado + negro + sul + urban', data=dados).fit()
reg_linlin.summary()

print("Exponenciais dos parâmetros:\n")
print(np.exp(reg_loglin.params))

#Definindo Y
Y = np.array(dados['lsal'])
Y.shape

#Definindo X
X = np.array(dados[['constante','educ','exper','exper2','qi','perm','casado', 'negro', 'sul','urban']])
X.shape


b = np.linalg.inv(X.T @ X) @ X.T @ Y
print(b)
print(reg_loglin.params) #OK

e = Y - X @ b
print(e)
print(reg_loglin.resid) #OK

# Continua...






