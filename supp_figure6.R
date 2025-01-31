

library(UpSetR)
library(venn)
library(ggplot2)
library(readxl)



theme_set(theme_bw() +
            theme(panel.grid.major = element_blank(), 
                  panel.grid.minor = element_blank(),
                  panel.background = element_rect(colour = "black", size = 1),
                  axis.text.x = element_text(color = "black", angle = 45, hjust = 1),
                  axis.text.y = element_text(color = "black")))



###################
# panel a
###################




# get the PMID and year of publication for each paper 


data_pmid <- read_csv("data.csv")


for (thistopic in c("batch correction",  "DE" ,  "dimension reduction" , "imputation"  )){
  
  
  data <-  read_excel("review of benchmarking - ranking of methods.xlsx",
                      sheet =  thistopic)
  
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
               nsets = 100)   ) 
  
  # note that venn can only be generated for less than 7 sets 
 
  venn::venn(x, ilabels = "counts", opacity = 0.1,  zcolor = "style",  box = F)
 
  
  
}










###################
# panel b & c
###################


data <-  read_excel("review of benchmarking - dataset specificity of common benchmarking papers.xlsx")

data$`Overall method ranking?` <- factor(data$`Overall method ranking?` , 
                                         levels = c("Yes", "No"))


data$`Modelling of impact of data characteristic on method performance` <-
  factor( data$`Modelling of impact of data characteristic on method performance`,
          levels = c("Yes" , "No"   ))


a <- ggplot(data, aes(x = `Overall method ranking?`, fill =  `Overall method ranking?`)) +
  geom_bar()+
  facet_wrap(~Topic, ncol=4) +  
  scale_fill_manual(values  = c("darkblue" , "#E41A1C" ))




data_filter <- data[! is.na ( data$`Modelling of impact of data characteristic on method performance`),  ]

b <- ggplot(data_filter, aes( x = `Modelling of impact of data characteristic on method performance` ,
                              fill = `Modelling of impact of data characteristic on method performance`))+
  geom_bar( )+
  facet_wrap(~Topic ,  ncol=4) +  
  scale_fill_manual(values  = c("darkblue" , "#E41A1C"  ) )


ggarrange(plotlist = list(a , b ) , align = "v")

 

