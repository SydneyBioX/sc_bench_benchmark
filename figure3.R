

library(UpSetR)
library(venn)
library(ggplot2)
library(readxl)
theme_set(theme_classic())

 

###################
# panel a
###################




data_pmid <- read_csv("data.csv")
 
data <-  read_excel("review of benchmarking - ranking of methods.xlsx", 
                    sheet = "clustering")
data <- as.data.frame(data)

pmid <- data_pmid[ match( colnames(data), data_pmid$`Paper.title`), ]$PMID
year <- data_pmid[ match( colnames(data), data_pmid$`Paper.title`), ]$year
pmid[4] <-  "35135612"
year[4] <- "2022"
pmid <- paste0(pmid, " (", year, ")")
x <- list()
for ( i in c(1:ncol(data))){
  x[[pmid[i]]]  <-  na.omit( as.character(data[, i]))
}


thistopic <- "clustering"
 
col <- "darkblue" 
upset(fromList(x), order.by = "freq" , 
      main.bar.color = col , 
      sets.bar.color = col,
      show.numbers = FALSE,
      text.scale = 2,
      nsets = 100)

venn::venn(x, ilab=TRUE,opacity = 0.1,  zcolor = "style",  box = F)
 


 

 

for (thistopic in c( "deconvolution"  , "celltype annotation" ,    "GRN"  )){
  
  data <-  read_excel("review of benchmarking - ranking of methods.xlsx", 
                      sheet =thistopic )
  data <- as.data.frame(data)
  
  pmid <- data_pmid[ match( colnames(data), data_pmid$`Paper.title`), ]$PMID
  year <- data_pmid[ match( colnames(data), data_pmid$`Paper.title`), ]$year
  
  pmid <- paste0(pmid, " (", year, ")")
  x <- list()
  for ( i in c(1:ncol(data))){
    x[[pmid[i]]]  <-  na.omit( as.character(data[, i]))
  }
  
  
 
  col <- "darkblue" 
  
  print( upset(fromList(x), order.by = "freq" , 
               main.bar.color = col , 
               sets.bar.color = col,
               show.numbers = FALSE,
               text.scale = 2,
               nsets = 100)  )
   
  venn::venn(x, ilab=TRUE,opacity = 0.1,  zcolor = "style",  box = F  )
 
  
}






###################
# panel b & c
###################

 
data <- read_excel("review of benchmarking - dataset specificity of common benchmarking papers.xlsx")


 
data$`Mentioned about dataset specific performance?` <- factor(data$`Mentioned about dataset specific performance?` , 
                                                               levels =  c("Yes", "No"))

data$`Mentioned about critiera specific performance?` <- factor( data$`Mentioned about critiera specific performance?`, 
                                                                 levels = c("Yes" , "No"))
 
a <- ggplot(data, aes(x = `Mentioned about dataset specific performance?`,
                      fill =  `Mentioned about dataset specific performance?`)) +
  geom_bar()+
  facet_wrap(~Topic ,  ncol=4) +  
  scale_fill_manual(values  = c("darkblue" , "#E41A1C" ))




b <- ggplot(data, aes(x =`Mentioned about critiera specific performance?` ,
                     fill = `Mentioned about critiera specific performance?` )) +
  geom_bar()+
  facet_wrap(~Topic ,  ncol=4) +  
  scale_fill_manual(values  = c("darkblue" , "#E41A1C" ))


 
ggarrange(plotlist = list(a , b ) , align = "v")
 













