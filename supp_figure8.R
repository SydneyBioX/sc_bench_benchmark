


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






data <- read_excel("review of benchmarking - dataset specificity of common benchmarking papers.xlsx")


data <- split(  data$Critiera , data$Topic )
criteria  <- unlist ( strsplit(data$`Batch correction` , ";"))
criteria <- trimws(criteria)
p_batch <- barplot_ggplot(criteria , "Batch correction"  , "Criteria")


criteria  <- unlist( strsplit ( data$`Celltype annotation` ,";"))
criteria <- trimws(criteria)
p_celltype <- barplot_ggplot(criteria  , "Celltype/state identification"  , "Criteria")


criteria <- unlist( strsplit ( data$Clustering ,";"))
criteria <- trimws(criteria)
p_clustering <- barplot_ggplot(criteria, "Clustering"  , "Criteria")


criteria  <- unlist(strsplit( data$DE , ";"))
criteria <- trimws(criteria)
p_DE <- barplot_ggplot(criteria , "Differential expression"  , "Criteria")



criteria <- unlist(strsplit( data$Deconvolution , ";"))
criteria <- trimws(criteria)
p_deconv <- barplot_ggplot(criteria , "Deconvolution"  , "Criteria" )



criteria  <- unlist(strsplit( data$`Dimension reduction`, ";")) 
criteria <- trimws(criteria)
p_dimension <- barplot_ggplot( criteria , "Dimension reduction"  , "Criteria" )


criteria <- unlist(strsplit( data$GRN, ";")) 
criteria <- trimws(criteria )
p_grn <- barplot_ggplot( criteria, "Gene regulatory network" , "Criteria" )


criteria <- unlist(strsplit( data$Imputation, ";")) 
criteria <- trimws(criteria )
p_imputation <- barplot_ggplot(criteria , "Imputation" , "Criteria" )



ggarrange( plotlist = list(p_batch , p_celltype , p_clustering , p_DE  , 
                           p_deconv, p_dimension ,  p_grn , p_imputation ) , 
           ncol = 2,  nrow = 4, 
           align = "h")












