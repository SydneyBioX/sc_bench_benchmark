
# read in human response 

data <- read_csv("data.csv")

data <- data[!duplicated(data$PMID),]
 
# read in LLM response
LLM_answer <- read_csv("Benchmark LLM answer.csv")

# use PMID to match the rows in LLM and in human 
LLM_answer <- LLM_answer[ match(data$PMID, LLM_answer$PMID), ] 
remove_na <- which(is.na( LLM_answer$Paper ) )

# since we randomly selected 100 papers 
data <- data[-remove_na,]
LLM_answer <- LLM_answer[-remove_na,]


 
# correlation on number of methods 


method <- data.frame( 
  "PMID" = data$PMID,
  "Human" = data$Methods.compared,
  "LLM" = LLM_answer$`Number of methods compared`, 
  "type" = data$Paper.category
)


ggplot(method, aes(x = Human, y= LLM, colour = 1)) + geom_point( alpha=0.6, size = 2) + stat_cor() + facet_wrap(~type, scales = "free")




# correlation on number of experimental data used 


exp_data  <- data.frame( 
  "PMID" = data$PMID,
  "Human" = data$Number.of.experimental.datasets,
  "LLM" =  as.numeric( LLM_answer$`Number of experimental data`), 
  "type" = data$Paper.category
)


ggplot(exp_data, aes(x = Human, y= LLM, colour = 1)) + geom_point(alpha=0.6, size = 2) + stat_cor() + facet_wrap(~type)



# correlation on number of synthetic data used 


syn_data  <- data.frame( 
  "PMID" = data$PMID,
  "Human" = data$Number.of.synthetic.datasets,
  "LLM" =  as.numeric( LLM_answer$`Number of synthetic data`), 
  "type" = data$Paper.category
)


syn_data[ syn_data$LLM  ==0 | is.na(syn_data$LLM  ==0) ,  ]$LLM <- NA
syn_data[ syn_data$Human  ==0 | is.na(syn_data$Human  ==0) ,  ]$Human <- NA

ggplot( syn_data, aes(x = log10(Human), y= log10(LLM), colour = 1)) + geom_point(alpha=0.6, size = 2 ) + stat_cor() + facet_wrap(~type)





draw_confusion_matrix <- function( cm ){
  
  plt <- as.data.frame(cm$table)
  plt$Prediction <- factor(plt$Prediction, levels=rev(levels(plt$Prediction)))
  
  p <-  ggplot(plt, aes(Prediction,Reference, fill= Freq)) +
    geom_tile() + geom_text(aes(label=Freq)) +
    scale_fill_gradient(low="white", high="steelblue")+
    labs(x = "LLM",y = "Human") 
  
  return (p)
  
}



# whether speed is measured 

speed  <- data.frame( 
  "PMID" = data$PMID,
  "Human" = data$Speed.measured.,
  "LLM" =    LLM_answer$`Speed measured`, 
  "type" = data$Paper.category
)

speed_this <- speed[ speed$type == "Pure benchmarking paper", ]

cm <- confusionMatrix( data =  factor( speed_this$LLM  ), 
                       reference =   factor( speed_this$Human)   )


a <- draw_confusion_matrix(cm) 


speed_this <- speed[ speed$type == "New method development paper", ]

cm <- confusionMatrix( data =  factor( speed_this$LLM  ), 
                       reference =   factor( speed_this$Human)   )

b <- draw_confusion_matrix(cm) 

ggarrange(plotlist = list(a, b), ncol = 2, nrow = 1, common.legend = TRUE )





# whether memory is measured 


memory  <- data.frame( 
  "PMID" = data$PMID,
  "Human" = data$Memory.measured ,
  "LLM" =    LLM_answer$`Memory measured`, 
  "type" = data$Paper.category
)

memory_this <- memory[ memory$type == "Pure benchmarking paper", ]

cm <- confusionMatrix( data =  factor( memory_this$LLM  ), 
                       reference =   factor( memory_this$Human)   )


a <- draw_confusion_matrix(cm) 




memory_this <- memory[ memory$type == "New method development paper", ]

cm <- confusionMatrix( data =  factor( memory_this$LLM  ), 
                       reference =   factor( memory_this$Human)   )

b <- draw_confusion_matrix(cm) 



# correlation on max number of cells 


num_cell  <- data.frame( 
  "PMID" = data$PMID,
  "Human" = data$Max.number.of.cells ,
  "LLM" =  as.numeric( LLM_answer$`Max number of cells`), 
  "type" = data$Paper.category
)


num_cell[ num_cell$Human  ==0 | is.na( num_cell$Human  ==0) ,  ]$Human <- NA

ggplot( num_cell, aes(x = log10(Human), y= log10(LLM), colour = 1)) + 
  geom_point(alpha=0.6, size = 2) + stat_cor() + facet_wrap(~type, scales = "free")




# type of data used 


LLM_answer$`Data type`[LLM_answer$`Data type` == "Experimental" ] <- "Experimental data"

type_data  <- data.frame( 
  "PMID" = data$PMID,
  "Human" = data$Types.of.data ,
  "LLM" =    LLM_answer$`Data type`, 
  "type" = data$Paper.category
)

type_data_this <- type_data[ type_data$type == "Pure benchmarking paper", ]


type_data_this$Human  <- factor( type_data_this$Human )
type_data_this$LLM <- factor(type_data_this$LLM, levels = levels(type_data_this$Human))



cm <- confusionMatrix( data =  type_data_this$LLM  , 
                       reference =   factor( type_data_this$Human)   )


a <- draw_confusion_matrix(cm) +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) 




type_data_this <- type_data[ type_data$type == "New method development paper", ]


type_data_this$Human  <- factor( type_data_this$Human )
type_data_this$LLM <- factor(type_data_this$LLM, levels = levels(type_data_this$Human))



cm <- confusionMatrix( data =   type_data_this$LLM  , 
                       reference =    type_data_this$Human)   

b <- draw_confusion_matrix(cm) +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) 


ggarrange(plotlist = list(a, b), ncol = 2, nrow = 1, common.legend = TRUE )



