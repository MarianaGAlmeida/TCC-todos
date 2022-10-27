rm(list=ls())
library(writexl)

# Pasta de trabalho
setwd(dirname(rstudioapi::getSourceEditorContext()$path)) 
## Vc também pode indicar a pasta contendo o arquivo k-means_Distrib.csv ##
## setwd("C:\\exemplo")

## ENTRADA DE DADOS (de acordo como o código em R do modelo DEA disponibilizado pela ANEEL) ##
dados<-read.table("k-means_Distrib.csv",header=T,sep=";",na.strings="ND",stringsAsFactors = F)
for (i in 5:ncol(dados))
{
  dados[,i]<-as.numeric(dados[,i])
}
remove(i)
## Data frame - Custos Operacionais - valor total e 4 componentes ##
CO <- data.frame(dados[,c("EMPRESA", "X18.1.Custos_Operacionais", "X18.2.Pessoal",
                          "X18.3.Materiais", "X18.4.Serv_Terceiros", "X18.7.Outros")])
## Adição de Colunas com a participação percentual das 4 componentes ##
CO["Part_Perc_P"]<-CO$X18.2.Pessoal/ CO$X18.1.Custos_Operacionais
CO["Part_Perc_M"]<-CO$X18.3.Materiais / CO$X18.1.Custos_Operacionais
CO["Part_Perc_ST"]<-CO$X18.4.Serv_Terceiros / CO$X18.1.Custos_Operacionais
CO["Part_Perc_O"]<-CO$X18.7.Outros / CO$X18.1.Custos_Operacionais
## K-means - dados percentuais ##
CO <-na.omit(CO)
dados_kmeans <-data.frame(CO[,"Part_Perc_P"])
cl <- kmeans(dados_kmeans,3, iter.max = 100)
cl
CO["cluster"]<- cl$cluster
CLUSTER_1 <- CO[CO$cluster==1, ]
CLUSTER_2 <- CO[CO$cluster==2, ]
CLUSTER_3 <- CO[CO$cluster==3, ]
## Exporta resultado para .xlsx ##
write_xlsx(CLUSTER_1,"Cluster1.xlsx")
write_xlsx(CLUSTER_2,"Cluster2.xlsx")
write_xlsx(CLUSTER_3,"Cluster3.xlsx")