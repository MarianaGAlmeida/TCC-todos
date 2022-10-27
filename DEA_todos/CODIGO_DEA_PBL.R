rm(list=ls())

#install.packages("Benchmarking")
#install.packages("writexl")
# Pasta de trabalho
#setwd(dirname(rstudioapi::getSourceEditorContext()$path)) 

library(Benchmarking)
library(writexl)

##### ENTRADA DE DADOS ########################################################

dados<-read.table("BASE_DEA_PBL.csv",header=T,sep=";",na.strings="ND",stringsAsFactors = F)
for (i in 5:ncol(dados))
{
  dados[,i]<-as.numeric(dados[,i])
}
remove(i)
summary(dados)

#####  DEA  ##################################################################

  # Insumos e produtos
  nx<-"X18.1.5.OPEX_CTRAB_DESAT_CCEE_QUAL"
  ny<-c("X37.Rede","X48.MVA_Total","X43.Trafos_Distribuicao","X10.1.Mercado_Ponderado","X6.UC_Total")
  
  # Dados que serao utilizados
  dadost<-na.omit(data.frame(dados[,c(1:4)],dados[,c(nx,ny)]))
  
  X=as.matrix(dadost[,nx])
  rownames(X)<-dadost[,"ANO.COD"]
  colnames(X)<-insumos
  Y=as.matrix(dadost[,ny])
  rownames(Y)<-dadost[,"ANO.COD"]
  
  # Programacao linear
  
  # Entrada:
  orgKr <- dim(X)
  m = dim(X)[2]   # Insumos
  n = dim(Y)[2]   # Produtos
  K = dim(X)[1]   # DMUs
  okr <- orgKr[1]
  Kd <- 0
  
  # Saida 
  u <- matrix(NA, K, m)     # Peso Insumo
  v <- matrix(NA, K, n)	    # Peso Produto
  v_p <- matrix(NA, K, n)   # Peso composto do produto
  objval <- rep(NA, K)	    # Vetor da FO 
  gamma <- matrix(NA, K, 1) # Peso escala

  # Implementacao
  lps <- make.lp(1 + K , m + n + 1) 
  rownames(lps)[1]=paste(rownames(lps)[1],c("DMU")) 
  rownames(lps)[1:K+1]=paste(rownames(lps)[2:K+1],rownames(X)) 
  colnames(lps)=c(nx,ny,"scale")
  
  set.column(lps, m, c(0, -X[, 1]))                   # Custos
  for (h in 1:n) set.column(lps, m + h, c(0, Y[, h])) # Produtos
  set.column(lps, m + n + 1, c(0, rep(1, K)))         # Escala
  
  { lp.control(lps, sense = "max");set.rhs(lps, 1, 1)}
  
  # Restricoes de pesos
  res.p<-matrix(0,10,6)
  #           |     1     |     2      |      3       |     4     |       5     |      6     |       7     |      8     |       9     |      10    | 
  #           |    Max    |    Min     |      Max     |    Min    |      Max    |     Min    |     Max     |    Min     |     Max     |     Min    |
  res.p[,1]<-c(-2.00123467, 0.810981305, -29.855999930, 1.40067156, -1.200486346, 0.268258373, -0.062923457, 0.018111401, -0.152701137, 0.037994484) # Custos Operacionais
  res.p[,2]<-c(          1,          -1,             0,          0,            0,           0,            0,           0,            0,           0) # X37.Rede
  res.p[,3]<-c(          0,           0,             1,         -1,            0,           0,            0,           0,            0,           0) # X6.UC_Total
  res.p[,4]<-c(          0,           0,             0,          0,            1,          -1,            0,           0,            0,           0) # X43.Trafos_Distribuicao
  res.p[,5]<-c(          0,           0,             0,          0,            0,           0,            1,          -1,            0,           0) # X10.1.Mercado_Ponderado
  res.p[,6]<-c(          0,           0,             0,          0,            0,           0,            0,           0,            1,          -1) # X6.UC_Total
  
  for(k in 1:dim(res.p)[1])
  {
    add.constraint(lps, c(res.p[k,],0), "<=", 0)
    
  }  

  teste=rep(NA,K)
  
  # Laco para todas as empresas
  for (k in 1:K)
  {
    set.row(lps, 1, c(X[k, ]), 1:m)
    objrow <- c(rep(0, m), Y[k, ], 1)
    set.objfn(lps, objrow)
    status <- solve(lps)
    teste[k]=status
    objval[k] <- get.objective(lps)
    pesos <- get.variables(lps)
    u[k, ] <- pesos[1:m]              # Peso insumo
    v[k, ] <- pesos[(m + 1):(m + n)]  # Peso produto
    gamma[k, ] <- pesos[(m + n + 1)]  # Peso escala
  }
  
  # Teste
  if (sum(teste)>0)
  {
    paste("########## ATENCAO! OCORREU ALGUM ERRO NA OTIMIZACAO DA DMU DE NUMERO:", which(teste>0),"##########") 
  }
 
  # Relatorio de saida
  for (z in 1:ncol(Y))
  {
    v_p[,z]<- v[,z]*Y[,z] # Pesos ponderados pela variavel
  }       
  colnames(v_p)=paste("Y.",ny,sep="")
  colnames(v)=paste("Vs_Y.",ny,sep="")
  colnames(X)=nx
  p.sombra<-matrix(0,nrow=nrow(Y),ncol=ncol(Y))
  for (z in 1:nrow(Y))
  {
    p.sombra[z,]<- v[z,]/u[z]
  }
  colnames(p.sombra)<-paste("v.",colnames(Y),"/u",sep="")
  resultado<-data.frame(dadost[,1:4],Eficiencia=objval,Y,X,p.sombra)
  resultado<-resultado[order(resultado$Eficiencia,decreasing = TRUE),]
  
  # Exporta resultado para .xlsx
  write_xlsx(resultado,"resultado.xlsx")
  