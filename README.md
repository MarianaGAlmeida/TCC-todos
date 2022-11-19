# Data Envelopment Analysis e Regulação do Setor Elétrico

  Data Envelopment Analysis (DEA) é um método não-paramétrico que pode ser utilizado na mensuração da eficiência relativa de entidades comparáveis, isto é, que atuem em ambientes similares e que utilizem um mesmo conjunto de insumos (inputs) na obtenção de um determinado conjunto de produtos (outputs) (COOK, SEIFORD, 2009). No contexto do setor elétrico, modelos DEA são utilizados como mecanismos de incentivo regulatório por meio dos quais a Agência Nacional de Energia Elétrica (ANEEL) busca simular fatores e efeitos de mercados competitivos.

  Trabalhos nacionais acerca dos modelos delineados pela ANEEL para o segmento de distribuição costumam abordar a heterogeneidade dos ambientes de atuação das empresas reguladas (1). Poucos estudos buscam explorar as diferenças entre as distribuidoras no que diz respeito ao insumo utilizado no modelo, qual seja:os custos operacionais reais, que correspondem aos gastos com “Pessoal, Materiais, Serviços de Terceiros, Outros Custos Operacionais, Tributos e Seguros"(2).

  Segundo trabalho acadêmico de Farina (2017), aproximadamente 80% do total desses custos está concentrado em Pessoal e Serviços de Terceiros (3).

  Neste repositório buscamos reunir análises de dados referentes ao insumo CUSTOS OPERACIONAIS REAIS e às suas componentes PMSO. 

  Os dados utilizados estão disponibilizados no site da ANEEL (Agência Nacional de Energia Elétrica):

* [CP 062/2020](https://www.aneel.gov.br/consultas-publicas?p_auth=tpgjXTaM&p_p_id=participacaopublica_WAR_participacaopublicaportlet&p_p_lifecycle=1&p_p_state=normal&p_p_mode=view&p_p_col_id=column-2&p_p_col_pos=1&p_p_col_count=2&_participacaopublica_WAR_participacaopublicaportlet_ideParticipacaoPublica=3477&_participacaopublica_WAR_participacaopublicaportlet_javax.portlet.action=visualizarParticipacaoPublica) : Arquivos da Consulta Pública nº 062/2020.

//

# EXEMPLOS
Plots para análise do insumo para duas distribuidoras são exemplificados no arquivo Plots_distribuidoras.R . 

COELCE : Componentes PMSO
![image](https://user-images.githubusercontent.com/93783315/143915104-56073a5c-ccb9-43f9-a1bd-b09ce5e80d11.png)

ELEKTRO: Componentes PMSO
![image](https://user-images.githubusercontent.com/93783315/143915156-4b844a21-ac28-494b-b796-32e0233c2ffe.png)

//


# K-MEANS, SELF-ORGANIZING MAPS (SOM) e MINERAÇÃO DE TEXTOS

São utilizadas ferrametas de análise e mineração de dados que buscam sintetizar as diferenças entre as distribuidoras no que tange à composição (PMSO) do custos operacionais das distribuidoras:

1) imagen K-MEans
2)imagem SOM
3)imagem ANEEL processos trabalhistas

//


Posto que a correlação entre os produtos(outputs) é um assunto recorrente em artigos acerca da adequação de modelos DEA, também apresentamos breve análise sobre essa questão na pasta PASTA. 

![image](https://user-images.githubusercontent.com/93783315/143915435-01ca03c0-0aae-42c6-8553-18bd203e14a8.png)



## REFERÊNCIAS: 
1) DA SILVA, A. V. et al. A close look at second stage data envelopment analysis using compound error models and the Tobit model. Socio-Economic Planning Sciences, v. 65, p. 111- 126, 2019. Disponível em: https://doi.org/10.1016/j.seps.2018.04.001. Acesso em 28 de nov. de 2020.

2) AGÊNCIA NACIONAL DE ENERGIA ELÉTRICA (ANEEL). NOTA TÉCNICA N° 121/2020-SRM/ANEEL. Metodologia de Cálculo dos Custos Operacionais Regulatórios a ser aplicada às Distribuidoras de Energia Elétrica a partir de 2021. Brasília, DF, 2020a. Disponível em: : https://www.aneel.gov.br/consultas-publicas. Acesso em: 03 março 2021.

