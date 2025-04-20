
library(readr)
library(ggplot2)


theme_set(theme_bw() +
            theme(panel.grid.major = element_blank(), 
                  panel.grid.minor = element_blank(),
                  panel.background = element_rect(colour = "black", size = 1),
                  axis.text.x = element_text(color = "black", angle = 45, hjust = 1),
                  axis.text.y = element_text(color = "black")))



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
  
# created another excel on whether the paper reported dataset specific findings
data <- read_excel("review of benchmarking - dataset specificity of common benchmarking papers_Dec2024.xlsx")


data  <- split(  data$datasets , data$Topic )
dataset <- unlist ( strsplit( data$`Batch correction` , ";"))
dataset <- gsub("\\s+", "", dataset )

temp <-  data.frame( table(table(dataset)))
temp$Var1 <- as.numeric(temp$Var1)
temp$topic <- "Batch correction"
df <- rbind(df,  temp) 

 



dataset <- unlist( strsplit ( data$`Celltype annotation` ,";"))
dataset  <- gsub( "EMTAB-5061" , "E-MTAB-5061" , dataset  )
dataset <- gsub("\\s+", "", dataset )
mean( table(dataset) > 1 ) 

temp <-  data.frame( table(table(dataset)))
temp$Var1 <- as.numeric(temp$Var1)
temp$topic <- "Celltype annotation"
df <- rbind(df,  temp) 

 


dataset <- unlist( strsplit ( data$Clustering ,";"))
dataset <- gsub("\\s+", "", dataset )
mean( table(dataset) > 1 ) 

temp <-  data.frame( table(table(dataset)))
temp$Var1 <- as.numeric(temp$Var1)
temp$topic <- "Clustering"
df <- rbind(df,  temp) 

 



dataset <- unlist(strsplit( data$DE , ";"))
dataset <- gsub("\\s+", "", dataset )
mean( table(dataset) > 1 ) 

temp <-  data.frame( table(table(dataset)))
temp$Var1 <- as.numeric(temp$Var1)
temp$topic <- "Differential expression"
df <- rbind(df,  temp) 


 


dataset <- unlist(strsplit( data$Deconvolution , ";"))
dataset  <- gsub("AaronM.Newman:Swindell_Skin_Signatures" ,
                 "AaronM.Newman;Swindell_Skin_Signatures" , dataset  )
dataset <- unlist(strsplit( dataset , ";"))
dataset <- gsub("\\s+", "", dataset )
mean( table(dataset) > 1 ) 

temp <-  data.frame( table(table(dataset)))
temp$Var1 <- as.numeric(temp$Var1)
temp$topic <- "Deconvolution"
df <- rbind(df,  temp) 

 


dataset <- unlist(strsplit( data$`Dimension reduction`, ";")) 
dataset  <- gsub( ":",   ";" , dataset  )
dataset <- unlist(strsplit( dataset , ";"))
dataset <- gsub("\\s+", "", dataset )

temp <-  data.frame( table(table(dataset)))
temp$Var1 <- as.numeric(temp$Var1)
temp$topic <- "Dimension reduction"
df <- rbind(df,  temp) 


 mension <- barplot_ggplot(dataset , "Dimension reduction"  )


dataset <- unlist(strsplit( data$GRN, ";")) 
dataset <- gsub("\\s+", "", dataset )
 
temp <-  data.frame( table(table(dataset)))
temp$Var1 <- as.numeric(temp$Var1)
temp$topic <-  "Gene regulatory network"
df <- rbind(df,  temp) 

 

dataset <- unlist(strsplit( data$Imputation, ";")) 
dataset <- gsub("\\s+", "", dataset )
mean( table(dataset) > 1 ) 

temp <-  data.frame( table(table(dataset)))
temp$Var1 <- as.numeric(temp$Var1)
temp$topic <-  "Imputation"
df <- rbind(df,  temp) 
 

# ggarrange( plotlist = list(p_batch , p_celltype , p_clustering , p_DE  , 
#                            p_deconv, p_dimension ,  p_grn , p_imputation ) , 
#            ncol = 2,  nrow = 4, 
#            align = "h")
# 
#  


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

 


