
library(ggplot2)
library(ggpubr)
library(readr)
library(plyr)
library(caret)

theme_set(theme_bw() +
            theme(panel.grid.major = element_blank(), 
                  panel.grid.minor = element_blank(),
                  panel.background = element_rect(colour = "black", size = 1),
                  axis.text.x = element_text(color = "black", angle = 45, hjust = 1),
                  axis.text.y = element_text(color = "black")))

data <- read_csv("data.csv")



data_no_dup <- data
data_no_dup <- data[!duplicated(data$`Paper.title`), ]

table( data_no_dup$Paper.category  )

data_no_dup$Paper.category [ data_no_dup$Paper.category == "Pure benchmarking paper"] <- "Benchmark only"
data_no_dup$Paper.category [ data_no_dup$Paper.category == "New method development paper"] <- "Method development"
data_no_dup$Paper.category <- factor(data_no_dup$Paper.category)


plot_barplot <- function( column ){
  column <- sym(column)
  
  p <- data_no_dup %>% 
    drop_na(!!column) %>% ggplot(  
      aes(x = !!column  , fill = !!column )) + 
    geom_bar(position = "dodge" )    +
    facet_wrap(~`Paper.category`)+ 
    ylab("Number of papers")+
    scale_fill_manual(values =  c("steelblue" , "#E41A1C" , "lightgrey" ))
  
  return( p )
  
}




plot_density <- function( mu,  column ){
  
  column <- sym(column)
  
  p <- ggplot(data_no_dup, aes(x = !!column )) + 
    geom_density( aes(fill = `Paper.category` , colour =`Paper.category` ),  alpha = 0.1)  + 
    scale_x_log10() + ylab("Distribution density") +
    scale_fill_manual(values =  c(   "darkblue"  ,  "#E41A1C" ))+
    scale_colour_manual(values =  c(   "darkblue"  ,  "#E41A1C" ))+
    geom_vline(data=mu, aes(xintercept=grp.mean, color=Paper.category), linetype="dashed")
  
  
  return( p )
  
}

###################
# Data 
###################


data_type <- plot_barplot( "Types.of.data")


mu <- ddply(data_no_dup, "Paper.category", summarise, grp.mean=median(Number.of.experimental.datasets, na.rm=T))
num_exp <- plot_density(mu, "Number.of.experimental.datasets") 


mu <- ddply(data_no_dup, "Paper.category", summarise, grp.mean=median(Number.of.synthetic.datasets, na.rm=T))
num_syn <- plot_density(mu, "Number.of.synthetic.datasets") 



data <- ggarrange(plotlist = list(  data_type,  num_exp, num_syn ), ncol = 3)





###################
# Method  
###################


data_no_dup$Selection.criteria <- factor(data_no_dup$Selection.criteria , levels = c("Yes", "No" , "Not sure"))
selection <- plot_barplot( "Selection.criteria")



mu <- ddply(data_no_dup, "Paper.category", summarise, grp.mean=median(Methods.compared, na.rm=T))
method_com <- plot_density(mu, "Methods.compared") 

method <- ggarrange(plotlist = list( selection, method_com), ncol = 2)







###################
# Accuracy criteria
###################

data_no_dup$Variability.of.score <- factor( data_no_dup$Variability.of.score, 
                                            levels = c("Yes", "No" , "Not sure"))
variability <- plot_barplot( "Variability.of.score")

data_no_dup$Overall.comparison <- factor( data_no_dup$Overall.comparison, 
                                          levels = c("Yes", "No" , "Not sure"))
overall <- plot_barplot( "Overall.comparison")


accuracy <- ggarrange(plotlist = list( variability  ,overall  ), ncol = 2)




###################
# Stability 
###################


data_no_dup$Sensitivity.analysis <- factor( data_no_dup$Sensitivity.analysis,  
                                            levels = c("Yes", "No"))
sensitivity <- plot_barplot( "Sensitivity.analysis")



data_no_dup$Tuning <- factor(data_no_dup$Tuning,   levels = c("Parameter tuning", "Default setting"))
tuning <- plot_barplot( "Tuning")

stability  <- ggarrange(plotlist = list( sensitivity , tuning  ), ncol = 2)




###################
# Scalability
###################


data_no_dup$Speed.measured. <- factor(data_no_dup$Speed.measured.,  levels = c("Yes", "No")) 
speed <- plot_barplot( "Speed.measured.")


data_no_dup$Memory.measured <- factor(data_no_dup$Memory.measured,  levels = c("Yes", "No")) 
memory <- plot_barplot( "Memory.measured")



mu <- ddply(data_no_dup, "Paper.category", summarise, grp.mean=median(as.numeric( Max.number.of.cells ), na.rm=T))
max_num_cell <- plot_density(mu, "Max.number.of.cells") 




pred <- data_no_dup$Speed.measured.
truth <- data_no_dup$Memory.measured


table <- data.frame(confusionMatrix(as.factor(pred), as.factor(truth))$table)

plotTable <- table %>%
  mutate(goodbad = ifelse(table$Prediction == table$Reference, "good", "bad")) %>%
  group_by(Reference) %>%
  mutate(prop = Freq/sum(Freq))

colnames(plotTable) <- c("Speed", "Memory" , "Freq", "goodbad" , "prop")
plotTable$Speed <- factor(plotTable$Speed, levels = c( "Yes" , "No" ))
plotTable$Memory <- factor(plotTable$Memory, levels = c("No" , "Yes"))

confusion <- ggplot(data = plotTable, mapping = aes(x = Speed, y = Memory, fill = goodbad, alpha = prop)) +
  geom_tile() +
  geom_text(aes(label = Freq), vjust = .5, fontface  = "bold", alpha = 1) +
  scale_fill_manual(values = c(good = "blue", bad = "red")) +
  theme_bw() +
  xlim(rev(levels(table$Reference))) + ylab("Measured memory") + xlab("Measured speed")


scalability  <- ggarrange(plotlist = list( speed, memory, max_num_cell, confusion ), ncol = 4)




###################
# Downstream 
###################

# downstream is not applicable for paper that benchmarked downstream analysis methods 
data_no_dup[ data_no_dup$broader_topic  == "Downstream analysis", ]$Downstream.analysis <- NA

data_no_dup$Downstream.analysis <- factor(data_no_dup$Downstream.analysis , levels= c("Yes" , "No" , "Not sure"))
downstream <- plot_barplot( "Downstream.analysis")



###################
# Context specific discovery 
###################


data_no_dup$Prior.knowledge <-  factor(data_no_dup$Prior.knowledge, 
                                       levels = c("Yes" , "No" , "Not sure")    )
prior <- plot_barplot( "Prior.knowledge")


data_no_dup$Discovery. <-  factor(data_no_dup$Discovery. , 
                                  levels = c("Yes" , "No" , "Not sure")    ) 

discovery <- plot_barplot( "Discovery.")

data_no_dup$Wet.lab.validation <-  factor(data_no_dup$Wet.lab.validation , 
                                          levels = c("Yes" , "No" , "Not sure")    ) 
weblab <- plot_barplot( "Wet.lab.validation")

context <- ggarrange(plotlist = list(prior,discovery , weblab), ncol = 3)




###################
# Communication
###################

data_no_dup$Recommendation <- factor(data_no_dup$Recommendation, 
                                     levels = c("Yes" , "No" , "Not sure")    )
rec <- plot_barplot( "Recommendation")



data_no_dup$Applicability <- factor(data_no_dup$Applicability, 
                                    levels = c("Yes" , "No" , "Not sure")    )
applica <- plot_barplot( "Applicability")


data_no_dup$Trade.offs <- factor(data_no_dup$Trade.offs, 
                                 levels = c("Yes" , "No" , "Not sure")    )
tradeoff <- plot_barplot( "Trade.offs")


data_no_dup$Future.directions <- factor(data_no_dup$Future.directions, 
                                        levels = c("Yes" , "No" , "Not sure")    )

future <- plot_barplot( "Future.directions")



communication <- ggarrange(plotlist = list( rec, applica, tradeoff, future), ncol = 4 )



###################
# Software
###################

data_no_dup$Website <- factor(data_no_dup$Website , levels = c("Yes" , "No"))
website <- plot_barplot( "Website")

data_no_dup$Package.availability <- factor(data_no_dup$Package.availability , levels = c("Yes" , "No"))
package_avail <- plot_barplot( "Package.availability")

data_no_dup$`Data.availability` <- factor(data_no_dup$`Data.availability` , levels = c("Yes" , "No"))
data_avail <- plot_barplot( "Data.availability")


software <- ggarrange(plotlist = list( website, package_avail , data_avail), ncol =3 )

