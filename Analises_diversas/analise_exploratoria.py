import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import plotly.express as px


## Exploração inicial 
## dados: período 2000-2018
dados2000_2018 = pd.read_csv ('BASE_CONSOLIDADA_PBL.csv', sep=';', na_values='ND')

dados2000_2018.describe()
dados2000_2018.head()
dados2000_2018.tail()


##
## Explorando o INSUMO (input) "custos operacioanis reais" - CO  
## Exemplo para a distribuidora ANAZONAS
Distrib_X = dados2000_2018.loc[dados2000_2018['EMPRESA'] == 'AMAZONAS']
CO = Distrib_X[['ANO', '18.1.Custos_Operacionais', '18.2.Pessoal', '18.3.Materiais', '18.4.Serv_Terceiros', '18.7.Outros']]
CO = CO.dropna()
plt.plot( 'ANO', '18.2.Pessoal', data=CO, color='blue', linewidth=2, label="Pessoal")
plt.plot( 'ANO', '18.3.Materiais', data=CO, color='purple', linewidth=2, label="Materiais")
plt.plot( 'ANO', '18.4.Serv_Terceiros', data=CO, color='red', linewidth=2, label="Serv_Terceiros")
plt.plot( 'ANO', '18.7.Outros', data=CO, color='green', linewidth=2, label="Outros")
plt.xticks(CO['ANO'], rotation='vertical')
plt.legend()
plt.show()

##
## EXPLORAÇÃO DOS PRODUTOS UTILIZADOS NO MODELO DA ANEEL
## Matriz de correlação dos produtos
df_produtos = dados2000_2018[["37.Rede","48.MVA_Total","43.Trafos_Distribuicao","10.Mercado_Total","6.UC_Total"]]
df_produtos = df_produtos.dropna()
corr = df_produtos.corr()

## Plotando a matriz de correlação com tons de azul
plt.figure(figsize=(5, 5))
plt.imshow(corr, cmap='Blues', interpolation='none', aspect='auto')
plt.colorbar() 
plt.xticks(range(len(corr)), corr.columns, rotation='vertical')
plt.yticks(range(len(corr)), corr.columns);
plt.suptitle('Correlação', fontsize=15, fontweight='bold')
plt.grid(False)
plt.show()
print(corr)
