# (PYTHON) - ANÁLISES DE DADOS DAS DISTRIBUIDORAS DE ENERGIA ELÉTRICA 

## Introdução

Neste repositório estão reunidos arquivos para análise exploratória de dados utilizados no modelo de benchmarking (DEA- Data Envelopment Analysis) delineado pela ANEEL para a regulação das distribuidoras de energia elétrica.



## Dados

Os dados utilizados estão disponibilizados no site da ANEEL (Agência Nacional de Energia Elétrica), no link abaixo:

* [CP 062/2020](https://www.aneel.gov.br/consultas-publicas?p_auth=tpgjXTaM&p_p_id=participacaopublica_WAR_participacaopublicaportlet&p_p_lifecycle=1&p_p_state=normal&p_p_mode=view&p_p_col_id=column-2&p_p_col_pos=1&p_p_col_count=2&_participacaopublica_WAR_participacaopublicaportlet_ideParticipacaoPublica=3477&_participacaopublica_WAR_participacaopublicaportlet_javax.portlet.action=visualizarParticipacaoPublica) : Arquivos da Consulta Pública nº 062/2020.





## Análise Exploratória (Python):

Exploração inicial do arquivo BASE_CONSOLIDADA_PBL.csv contendo dados das distribuidoras concernentes ao período 2000 - 2018: 
```py
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import plotly.express as px

dados2000_2018 = pd.read_csv ('BASE_CONSOLIDADA_PBL.csv', sep=';', na_values='ND')

dados2000_2018.describe()
dados2000_2018.head()
dados2000_2018.tail()

```

## Plots para análise do INSUMO (input) "custos operacionais reais" (CO) de uma distribuidora específica:
```py
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

```
Exemplo para a distribuidora AMAZONAS:

![image](https://user-images.githubusercontent.com/93783315/143912595-e8fe17c3-f563-4794-a77c-cbd052e4c0ca.png)


## 1ª análise dos PRODUTOS (outputs) utilizados no modelo DEA:
A correlação entre os "outputs" (ou produtos) utilizados em modelos DEA é discutida em muitos trabalhos. No modelo da ANEEL, os dados utilizados como produtos são: nº de Trafos de Distribuição; Mercado Total; UC Total (nº de unidades consumidoras); Rede (extensão) e MVA Total. 
```py
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

```

![image](https://user-images.githubusercontent.com/93783315/143915435-01ca03c0-0aae-42c6-8553-18bd203e14a8.png)



# (R) - ANÁLISES DE DADOS DAS DISTRIBUIDORAS DE ENERGIA ELÉTRICA 
Plots para análise do insumo para duas distribuidoras são exemplificados no arquivo Plots_distribuidoras.R . 

COELCE : Componentes PMSO
![image](https://user-images.githubusercontent.com/93783315/143915104-56073a5c-ccb9-43f9-a1bd-b09ce5e80d11.png)

ELEKTRO: Componentes PMSO
![image](https://user-images.githubusercontent.com/93783315/143915156-4b844a21-ac28-494b-b796-32e0233c2ffe.png)



