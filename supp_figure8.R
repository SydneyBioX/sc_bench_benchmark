


library(readr)
library(ggplot2)
theme_set(theme_classic())


barplot_ggplot <- function( dataset , title   , xlab = "Dataset"   ){ 
  
  
  dataset <- data.frame( table( dataset) ) 
  
  dataset <- dataset[ order(dataset$Freq , decreasing = T) , ]
  
  dataset$dataset <- factor(dataset$dataset , levels = c(dataset$dataset))
  
  integer_breaks <- function(n = 5, ...) {
    fxn <- function(x) {
      breaks <- floor(pretty(x, n, ...))
      names(breaks) <- attr(breaks, "labels")
      breaks
    }
    return(fxn)
  }
  p <- ggplot(dataset , aes( x = dataset , y = Freq )) + 
    geom_col( fill = "#184894") + 
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) + 
    ylab("Number of studies") + xlab("Dataset")  + ggtitle( title) + 
    scale_y_continuous(breaks= integer_breaks())
  
  return(p)
  
  
}



df <- data.frame()


# created another excel on whether the paper reported criteria specific findings
data <- read_excel("review of benchmarking - dataset specificity of common benchmarking papers_Dec2024.xlsx")


data <- split(  data$Critiera , data$Topic )
criteria  <- unlist ( strsplit(data$`Batch correction` , ";"))
criteria <-  tolower( trimws(criteria) )  

temp <-  data.frame( table(table(criteria)))
temp$Var1 <- as.numeric(as.character( temp$Var1) )
temp$topic <- "Batch correction"
df <- rbind(df,  temp) 

 


criteria  <- unlist( strsplit ( data$`Celltype annotation` ,";"))
criteria <-tolower( trimws(criteria) ) 
 
temp <-  data.frame( table(table(criteria)))
temp$Var1 <- as.numeric(as.character( temp$Var1) )
temp$topic <- "Celltype annotation"
df <- rbind(df,  temp) 
 



criteria <- unlist( strsplit ( data$Clustering ,";"))
criteria <-tolower( trimws(criteria) ) 
 
temp <-  data.frame( table(table(criteria)))
temp$Var1 <- as.numeric(as.character( temp$Var1) )
temp$topic <- "Clustering"
df <- rbind(df,  temp) 
 




criteria  <- unlist(strsplit( data$DE , ";"))
criteria <-tolower( trimws(criteria) ) 
 
temp <-  data.frame( table(table(criteria )))
temp$Var1 <- as.numeric(as.character( temp$Var1) )
temp$topic <- "Differential expression"
df <- rbind(df,  temp) 

 

criteria <- unlist(strsplit( data$Deconvolution , ";"))
criteria <-tolower( trimws(criteria) ) 
 
temp <-  data.frame( table(table(criteria )))
temp$Var1 <- as.numeric(as.character( temp$Var1) )
temp$topic <- "Deconvolution"
df <- rbind(df,  temp) 

 


criteria  <- unlist(strsplit( data$`Dimension reduction`, ";")) 
criteria <- tolower( trimws(criteria) ) 
 
temp <-  data.frame( table(table(criteria)))
temp$Var1 <- as.numeric(as.character( temp$Var1) )
temp$topic <- "Dimension reduction"
df <- rbind(df,  temp) 
 



criteria <- unlist(strsplit( data$GRN, ";")) 
criteria <- tolower(trimws(criteria ) ) 

temp <-  data.frame( table(table(criteria)))
temp$Var1 <- as.numeric(as.character( temp$Var1) )
temp$topic <-  "Gene regulatory network"
df <- rbind(df,  temp) 

 


criteria <- unlist(strsplit( data$Imputation, ";")) 
criteria <- tolower( trimws(criteria ) ) 
 
temp <-  data.frame( table(table(criteria)))
temp$Var1 <- as.numeric(as.character( temp$Var1) )
temp$topic <-  "Imputation"
df <- rbind(df,  temp) 

 
 


total <- df %>%  dplyr::group_by(topic) %>% 
  dplyr::summarise(total = sum( Freq))

total$type <- "total"

colnames( total ) <- c("topic",  "Number of papers", "Frequency")

total <- total[order(total$`Number of papers`, decreasing = F), ]

colnames(df)  <- c("Frequency" , "Number of papers", "topic")



df <- rbind(df, total)

df 


df$topic <- factor(df$topic, levels = c( total$topic ))

ggplot(df , aes(Frequency, topic)) +
  geom_tile(aes(fill = `Number of papers`)) +
  geom_text(aes(label = `Number of papers`)) +
  scale_fill_gradient(low = "white", high = "steelblue")
 





