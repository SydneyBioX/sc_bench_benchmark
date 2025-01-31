

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)
library(scales)

col <-  hue_pal()(13)
# Define the color mappings
color_mapping <- c("Single-cell ChIP-seq"  =   "#F8766D" , 
                   "Single-cell ATAC-seq" =  "#E18A00" ,
                   "Single-cell genomics" = "#BE9C00" ,
                   "Single-cell Hi-C" =  "#8CAB00",
                   "Single-cell mass cytometry" =  "#24B700",
                   "Single-cell multiomics" = "#00BE70" ,
                   "Single-cell proteomics" =  "#00C1AB" ,
                   "Single-cell sequencing" = "#00BBDA"  ,
                   "Single-cell RNA-seq" ="#00ACFC"  ,
                   "Single-cell DNA methylation" = "#8B93FF" , 
                   "Single-cell DNA-seq"  = "#D575FE" , 
                   "Spatial imaging"  = "#F962DD" ,
                   "Spatial transcriptomics" =   "#FF65AC"
)


theme_set(theme_bw() +
            theme(panel.grid.major = element_blank(), 
                  panel.grid.minor = element_blank(),
                  panel.background = element_rect(colour = "black", size = 1),
                  axis.text.x = element_text(color = "black", angle = 45, hjust = 1),
                  axis.text.y = element_text(color = "black")))


data <- read_csv("data.csv")





data <- as.data.frame(data)
data <- data[ ! duplicated(data$PMID), ]

data$`Paper.category` <- factor(data$`Paper.category` ,
                                levels = c("Pure benchmarking paper" , 
                                           "New method development paper"))


broader_level <- c("Analysis pipelines" , "Data", "Initial analysis" , 
                   "Intermediate analysis" , "Downstream analysis" )

column = "data_type"
paper_category <- "New method development paper"
count_number <- function(data, column , paper_category){
  
  thisdata <- data[ data$`Paper.category` == paper_category, ]
  entries <- unlist( strsplit(as.character( thisdata[, column]) , ", ") )
  entries <- data.frame(table(entries))
  entries$paper_type <- paper_category
  
  return(entries)
}



draw_barplot <- function(data_count, column_name  , title ){
  # Reorder finer_category by frequency within each broad_category
  data_count$entries <- reorder(data_count$entries,
                                data_count$Freq, FUN = function(x) -sum(x))
  
  g <- ggplot(data_count, aes(x = entries, y = Freq, 
                              fill = entries )) +
    geom_bar(stat = "identity" , alpha = 0.6,
             position=position_dodge2(   preserve = "single")  ) + 
    scale_y_continuous() + 
    scale_y_continuous(labels = function(x) format(round(x), nsmall = 0))  +
    ylab("Total number of papers included") + 
    xlab(column_name  ) + ggtitle( title )
  
  
  return(g)
  
}

data_count <- count_number(data,  "broader_topic"  ,"Pure benchmarking paper")
a <- draw_barplot(data_count , "Broader topic" , "Benchmark only paper")

data_count <- count_number(data,  "broader_topic"  ,"New method development paper" )
b <- draw_barplot(data_count , "Broader topic" , "Method development paper")



ggarrange(plotlist = list(a, b))




count_number_finer_topic <- function(data ){
  
  thisdata <- data %>%
    separate_rows(finer_topic, sep = ", ")
  
  thisdata <- thisdata %>% 
    dplyr::group_by( `Paper.category` , data_type, broader_topic, finer_topic) %>% 
    dplyr::summarise( total = n())
  
  
  return( thisdata)
}

data_count <- count_number_finer_topic(data  )
data_count_method <- data_count[ data_count$`Paper.category` ==  "New method development paper", ]
data_count_benchmark <- data_count[ data_count$`Paper.category` ==  "Pure benchmarking paper", ]



data_count <- data_count_method 

draw_barplot_finer_topic <- function(data_count  , title){
  # Reorder finer_category by frequency within each broad_category
  data_count <- data_count %>% 
    dplyr::group_by(finer_topic) %>% 
    dplyr::mutate( overall_total = n())
  
  data_count$finer_topic <- factor(data_count$finer_topic, levels  = c(sort( unique( data_count$finer_topic ))) )
  
  data_count$broader_topic <- factor(data_count$broader_topic, levels = broader_level )
  
  g <- ggplot(data_count, aes(x = finer_topic , y = total , 
                              fill = data_type   )) +
    geom_bar(stat = "identity" , alpha = 0.6,
             position=position_dodge2(   preserve = "single")  ) +
    facet_grid(~ broader_topic , scales = "free" , space = "free")  + 
    theme_classic() + theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))   +
    scale_y_continuous(breaks = seq(0, ceiling(max(data_count$total)), by = 1)) + 
    ylab("Total number of papers included") + 
    xlab("Finer category") + ggtitle(title) + scale_fill_manual(values = color_mapping )
  
  
  return(g)
  
}

a <- draw_barplot_finer_topic(data_count_benchmark ,   "Benchmark only paper")

b <- draw_barplot_finer_topic(data_count_method  ,  "Method development paper")


ggarrange(plotlist = list(a, b))








