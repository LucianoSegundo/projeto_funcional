library(rvest)
 # Como usar, pegue o link de um capitulo qualquer do manga desejado
 # https://unionleitor.top/leitor/3_Gatsu_no_Lion/01
 # retire o número do final
 #https://unionleitor.top/leitor/3_Gatsu_no_Lion/
 #adicione o link ao link base.
  
link_base <- "https://unionleitor.top/leitor/3_Gatsu_no_Lion/"
{
link_coleta <- paste0(link_base,'01')

html_coletado <- link_coleta%>% read_html()

html_coletado2<-  html_coletado %>%html_elements("select")

numero_bruto <-html_coletado2[1] %>%html_elements("option")%>% html_text2()

lista <- paste0(link_base, numero_bruto)

titulo_daobra <- html_coletado %>% html_elements(" a")%>%html_text2()
}
{

    
dir.create("/cloud/project/mangas/")
  
destino_base <- '/cloud/project/mangas/' 

pasta_destino <- paste0(destino_base,titulo_daobra[4], '/')

}
{ teste5 <- 0 ; teste6 <- 0 ; teste1 <- file.exists(pasta_destino)
  
if(teste1 == FALSE){
  dir.create(pasta_destino)
}

imagem <- 1:300 ;nome <- "pagina" ;extersao <- ".png"
nome_pagina <- paste0(nome, imagem, extersao)
cat("\014")
}
tamanho_lista <- lista %>% length()
for(i in 1:tamanho_lista){ 

lista_capitulos<- read_html(lista[i])
  
titulo_capitulo <- lista_capitulos %>% html_elements(" h1")%>%html_text2()


paginas_mangas <- lista_capitulos %>% html_elements(" img ") %>%  html_attrs()
pasta_capiulo <- paste0(pasta_destino, titulo_capitulo,'/')
tamanho_capitulo <-paginas_mangas%>% length()

 Sys.sleep(2) ;
 
 print(paste0("Baixando ", titulo_capitulo))

for(j in 1:tamanho_capitulo){
  teste2 <- file.exists(pasta_capiulo)
  if(teste2 == FALSE){
    dir.create(pasta_capiulo)
}
 
link <- paginas_mangas[j][[1]][1]

nome_destino <- paste0(pasta_capiulo, nome_pagina[j])

setwd(pasta_capiulo)

teste3 <- file.exists(nome_pagina[j])
if(teste3 == FALSE){
download.file(link, nome_destino)
Sys.sleep(0.6)
teste6 = teste6 +1
if(teste6 == tamanho_capitulo){
  cat("\014")
  Sys.sleep(0.2)
  print(paste0("O capitulo ", titulo_capitulo, " foi baixado"))
 
}
} 
else{teste5 <- teste5 +1}
if(teste5 == tamanho_capitulo){
  Sys.sleep(0.2)
  print(paste0("O capitulo ", titulo_capitulo, " já foi baixado"))
}
}
 teste5 <- 0 ; teste6 <- 0
 
     
}
print(paste0("Todos os capitulo de ", titulo_daobra , " foram baixado"))