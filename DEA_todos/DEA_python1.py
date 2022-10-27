#!/usr/bin/env python
# coding: utf-8

# In[2]:


import pandas as pd
import numpy as np
import scipy 
from scipy.optimize import linprog


from tkinter import *
import tkinter.filedialog
from tkinter import messagebox


#############################
## MELHORAR descrição DEA ###
#############################


root= Tk()
arquivo = tkinter.filedialog.askopenfilename(title = "Selecione o Arquivo csv com Base de Dados - modelo similar ao da ANEEL")
root.destroy()


dados = pd.read_csv (arquivo, encoding = 'ISO-8859-1', sep=';', na_values='ND')

## Construiremos as matrizes A, b, e c do programa linear


# Matriz b

b = np.zeros(70)
b[0] = 1


# Matriz c (obs: c é alterada no último for abaixo)

c = np.zeros(7)
c[-1] = 1


# Matriz A (construída aos poucos / A5 é a matriz A final)

coef = dados[["X18.1.5.OPEX_CTRAB_DESAT_CCEE_QUAL","X37.Rede","X48.MVA_Total",
              "X43.Trafos_Distribuicao","X10.1.Mercado_Ponderado","X6.UC_Total"]] 
coef = coef.dropna()

A = np.array(coef)

cf_lambda = np.ones(52)

A2 = np.insert(A, 6, cf_lambda, axis=1)

A_L1 = np.zeros(7)

A3 = np.vstack([A_L1, A2])
A3[:,0] = -A3[:,0]


res_pesos = np.array([[0] * 6] * 10)
for i in np.arange(0, 5):
    res_pesos[2*i, i] = 1
    res_pesos[(2*i +1), i] = -1
                             
lim_pesos = np.array([-2.00123467, 0.810981305, -29.855999930, 1.40067156, -1.200486346, 0.268258373, -0.062923457,  0.018111401, -0.152701137, 0.037994484])
res_pesos_tudo = np.insert(res_pesos, 0, lim_pesos, axis=1)


A4 = np.vstack([A3, res_pesos_tudo])

positividade = np.array([[0] * 7] * 7)
for i in np.arange(0, 7):
    positividade[i, i] = -1
        
A5 = np.vstack([A4, positividade])



# Matrizes para os resultados finais

Obj = [0]*(A.shape[0])
Mens = [0]*(A.shape[0])

for i in np.arange(0, A.shape[0]):
    c[1:6] = A[i, 1:6]
    A5[0,0] = -A5[(i+1), 0]
    Cmin = -c
    res = linprog(Cmin, A_ub=A5, b_ub=b)
    X = res.x
    FUN = res.fun
    Obj[i] = res.fun
    Mens[i] = res.message
    
#print(Obj)
#print(Mens)

resultadosDEA = pd.DataFrame(Obj)

#Criando arquivo Excel com o resultado da função objetivo para cada distribuidora
resultadosDEA_nome = 'resultadosDEA.xlsx' 
resultadosDEA.to_excel(resultadosDEA_nome)
print('Confira o arquivo resultadosDEA na mesma pasta do programa/arquivo executável')


# In[ ]:




