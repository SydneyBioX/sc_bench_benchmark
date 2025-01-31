
library(readr)
library(ggplot2)
library(readxl)


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



data <- read_excel("review of benchmarking - dataset specificity of common benchmarking papers.xlsx")


data  <- split(  data$datasets , data$Topic )
dataset <- unlist ( strsplit( data$`Batch correction` , ";"))
dataset <- gsub("\\s+", "", dataset )
p_batch <- barplot_ggplot(dataset , "Batch correction" )


dataset <- unlist( strsplit ( data$`Celltype annotation` ,";"))
dataset  <- gsub( "EMTAB-5061" , "E-MTAB-5061" , dataset  )
dataset <- gsub("\\s+", "", dataset )

p_celltype <- barplot_ggplot(dataset , "Celltype/state identification" )



dataset <- unlist( strsplit ( data$Clustering ,";"))
dataset <- gsub("\\s+", "", dataset )

p_clustering <- barplot_ggplot(dataset, "Clustering" )




dataset <- unlist(strsplit( data$DE , ";"))
dataset <- gsub("\\s+", "", dataset )

p_DE <- barplot_ggplot(dataset , "Differential expression" )




dataset <- unlist(strsplit( data$Deconvolution , ";"))
dataset  <- gsub("AaronM.Newman:Swindell_Skin_Signatures" ,
                 "AaronM.Newman;Swindell_Skin_Signatures" , dataset  )
dataset <- unlist(strsplit( dataset , ";"))
dataset <- gsub("\\s+", "", dataset )

p_deconv <- barplot_ggplot(dataset , "Deconvolution"  )



dataset <- unlist(strsplit( data$`Dimension reduction`, ";")) 
dataset  <- gsub( ":",   ";" , dataset  )
dataset <- unlist(strsplit( dataset , ";"))
dataset <- gsub("\\s+", "", dataset )
p_dimension <- barplot_ggplot(dataset , "Dimension reduction"  )


dataset <- unlist(strsplit( data$GRN, ";")) 
dataset <- gsub("\\s+", "", dataset )
p_grn <- barplot_ggplot(dataset , "Gene regulatory network" )


dataset <- unlist(strsplit( data$Imputation, ";")) 
dataset <- gsub("\\s+", "", dataset )
p_imputation <- barplot_ggplot(dataset , "Imputation" )



ggarrange( plotlist = list(p_batch , p_celltype , p_clustering , p_DE  , 
                           p_deconv, p_dimension ,  p_grn , p_imputation ) , 
           ncol = 2,  nrow = 4, 
           align = "h")



