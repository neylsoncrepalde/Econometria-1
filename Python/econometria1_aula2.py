#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Econometria 1
Profa. Sueli Moro

@author: Neylson Crepalde
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import statsmodels.formula.api as sm
import os

os.chdir('/home/neylson/Documentos/Neylson Crepalde/Doutorado/Econometria1/AULAS 2017')

dados = pd.read_stata('wages_935.dta') #Funcionando

dados.columns

dados['lsal'] = np.log(dados['salario'])
dados['exper2'] = dados['exper']**2
#dados.dropna(axis=0, how='any')

reg_loglin = sm.ols(formula='lsal ~ educ + exper + exper2 + qi + perm \
                    + casado + negro + sul + urban', data=dados).fit()
reg_loglin.summary()


reg_linlin = sm.ols(formula='salario ~ educ + exper + exper2 + qi + perm \
                    + casado + negro + sul + urban', data=dados).fit()
reg_linlin.summary()
