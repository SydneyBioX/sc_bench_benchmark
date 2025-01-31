

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


 
data_pmid <- read_csv("data.csv")

 
data <-  read_excel("review of benchmarking - ranking of methods.xlsx", 
                    sheet = "clustering")
data <- as.data.frame(data)

pmid <- data_pmid[ match( colnames(data), data_pmid$`Paper.title`), ]$PMID
year <- data_pmid[ match( colnames(data), data_pmid$`Paper.title`), ]$year
pmid[is.na(pmid)] <-  "35135612"
year[is.na(year)] <- "2022"
pmid <- paste0(pmid, " (", year, ")")
x <- list()
for ( i in c(1:ncol(data))){
  
  # remove whitespace, change to lower case 
  x[[pmid[i]]]  <-  gsub("\\s+", "", tolower( na.omit( as.character(data[, i])) )) 
}


thistopic <- "clustering"

 
 
col <- "darkblue" 
upset(fromList(x), order.by = "freq" , 
      main.bar.color = col , 
      sets.bar.color = col,
      show.numbers = FALSE,
      text.scale = 2,
      nsets = 100)  
 
 
venn::venn(x, ilabels = "counts", opacity = 0.1,  zcolor = "style",  box = F)
 






for (thistopic in c( "deconvolution"  , "celltype annotation" ,    "GRN"  )){
  
   
  data <-  read_excel("review of benchmarking - ranking of methods.xlsx", 
                      sheet =thistopic )
  
  data <- as.data.frame(data)
  
  pmid <- data_pmid[ match( colnames(data), data_pmid$`Paper.title`), ]$PMID
  year <- data_pmid[ match( colnames(data), data_pmid$`Paper.title`), ]$year
  
  pmid <- paste0(pmid, " (", year, ")")
  
  x <- list()
  i <- 1
  for ( i in c(1:ncol(data))){
    
    # remove whitespace, change to lower case 
    x[[pmid[i]]]  <-  gsub("\\s+", "", tolower( na.omit( as.character(data[, i])) )) 
  }
  
 
  
  
 
  col <- "darkblue" 
  print( upset(fromList(x), order.by = "freq" , 
               main.bar.color = col , 
               sets.bar.color = col,
               show.numbers = FALSE,
               text.scale = 2,
               nsets = 100)  )
 
  
  
  
 
  venn::venn(x, ilabels = "counts", opacity = 0.1,  zcolor = "style",  box = F)
  
 
  
  
}






###################
# panel b & c
###################


 data <- read_excel("review of benchmarking - dataset specificity of common benchmarking papers.xlsx")



data$`Mentioned about dataset specific performance?` <- factor(data$`Mentioned about dataset specific performance?` , 
                                                               levels =  c("Yes", "No"))

data$`Mentioned about critiera specific performance?` <- factor( data$`Mentioned about critiera specific performance?`, 
                                                                 levels = c("Yes" , "No"))


prop.table(table( data$`Mentioned about dataset specific performance?`) )
prop.table(table( data$`Mentioned about critiera specific performance?`) )



a <- ggplot(data, aes(x = `Mentioned about dataset specific performance?`,
                      fill =  `Mentioned about dataset specific performance?`)) +
  geom_bar()+
  facet_wrap(~Topic ,  ncol=4) + 
  scale_y_continuous(breaks = function(x) unique(floor(pretty(seq(min(x), (max(x) + 1) * 1.1))))) + 
  scale_fill_manual(values  = c("darkblue" , "#E41A1C" ))




b <- ggplot(data, aes(x =`Mentioned about critiera specific performance?` ,
                      fill = `Mentioned about critiera specific performance?` )) +
  geom_bar()+
  facet_wrap(~Topic ,  ncol=4) + 
  scale_y_continuous(breaks = function(x) unique(floor(pretty(seq(min(x), (max(x) + 1) * 1.1))))) + 
  scale_fill_manual(values  = c("darkblue" , "#E41A1C" ))



 ggarrange(plotlist = list(a , b ) , align = "v")

 












