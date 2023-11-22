 
library(ggplot2)
library(ggpubr)
library(readr)
library(plyr)
library(caret)

theme_set(theme_classic() +
            theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
            theme(panel.border = element_rect(color = "black", fill = NA)))



data <- read_csv("data.csv")

data_no_dup <- data
data_no_dup <- data[!duplicated(data$`Paper.title`), ]



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
 
 
plot_barplot( "Types.of.data")


mu <- ddply(data_no_dup, "Paper.category", summarise, grp.mean=median(Number.of.experimental.datasets, na.rm=T))
plot_density(mu, "Number.of.experimental.datasets") 


mu <- ddply(data_no_dup, "Paper.category", summarise, grp.mean=median(Number.of.synthetic.datasets, na.rm=T))
plot_density(mu, "Number.of.synthetic.datasets") 
 


###################
# Method  
###################


data_no_dup$Selection.criteria <- factor(data_no_dup$Selection.criteria , levels = c("Yes", "No" , "Not sure"))
plot_barplot( "Selection.criteria")



mu <- ddply(data_no_dup, "Paper.category", summarise, grp.mean=median(Methods.compared, na.rm=T))
plot_density(mu, "Methods.compared") 





###################
# Accuracy criteria
###################

data_no_dup$Variability.of.score <- factor( data_no_dup$Variability.of.score, 
                                            levels = c("Yes", "No" , "Not sure"))
plot_barplot( "Variability.of.score")

data_no_dup$Overall.comparison <- factor( data_no_dup$Overall.comparison, 
                                          levels = c("Yes", "No" , "Not sure"))
plot_barplot( "Overall.comparison")


###################
# Stability 
###################


data_no_dup$Sensitivity.analysis <- factor( data_no_dup$Sensitivity.analysis,  
                                            levels = c("Yes", "No"))
plot_barplot( "Sensitivity.analysis")



data_no_dup$Tuning <- factor(data_no_dup$Tuning,   levels = c("Parameter tuning", "Default setting"))
plot_barplot( "Tuning")

 

###################
# Scalability
###################
 

data_no_dup$Speed.measured. <- factor(data_no_dup$Speed.measured.,  levels = c("Yes", "No")) 
plot_barplot( "Speed.measured.")

 
data_no_dup$Memory.measured <- factor(data_no_dup$Memory.measured,  levels = c("Yes", "No")) 
plot_barplot( "Memory.measured")

 

mu <- ddply(data_no_dup, "Paper.category", summarise, grp.mean=median(as.numeric( Max.number.of.cells ), na.rm=T))
plot_density(mu, "Max.number.of.cells") 




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

ggplot(data = plotTable, mapping = aes(x = Speed, y = Memory, fill = goodbad, alpha = prop)) +
  geom_tile() +
  geom_text(aes(label = Freq), vjust = .5, fontface  = "bold", alpha = 1) +
  scale_fill_manual(values = c(good = "blue", bad = "red")) +
  theme_bw() +
  xlim(rev(levels(table$Reference))) + ylab("Measured memory") + xlab("Measured speed")




###################
# Downstream 
###################

# downstream is not applicable for paper that benchmarked downstream analysis methods 
data_no_dup[ data_no_dup$broader_topic  == "Downstream analysis", ]$Downstream.analysis <- NA

data_no_dup$Downstream.analysis <- factor(data_no_dup$Downstream.analysis , levels= c("Yes" , "No" , "Not sure"))
plot_barplot( "Downstream.analysis")



###################
# Context specific discovery 
###################


data_no_dup$Prior.knowledge <-  factor(data_no_dup$Prior.knowledge, 
                                       levels = c("Yes" , "No" , "Not sure")    )
plot_barplot( "Prior.knowledge")


data_no_dup$Discovery. <-  factor(data_no_dup$Discovery. , 
                                  levels = c("Yes" , "No" , "Not sure")    ) 
 
plot_barplot( "Discovery.")

data_no_dup$Wet.lab.validation <-  factor(data_no_dup$Wet.lab.validation , 
                                          levels = c("Yes" , "No" , "Not sure")    ) 
plot_barplot( "Wet.lab.validation")


###################
# Communication
###################

data_no_dup$Recommendation <- factor(data_no_dup$Recommendation, 
                                     levels = c("Yes" , "No" , "Not sure")    )
plot_barplot( "Recommendation")



data_no_dup$Applicability <- factor(data_no_dup$Applicability, 
                                    levels = c("Yes" , "No" , "Not sure")    )
plot_barplot( "Applicability")


data_no_dup$Trade.offs <- factor(data_no_dup$Trade.offs, 
                                 levels = c("Yes" , "No" , "Not sure")    )
plot_barplot( "Trade.offs")

 
data_no_dup$Future.directions <- factor(data_no_dup$Future.directions, 
                                        levels = c("Yes" , "No" , "Not sure")    )
 
plot_barplot( "Future.directions")




###################
# Software
###################

data_no_dup$Website <- factor(data_no_dup$Website , levels = c("Yes" , "No"))
plot_barplot( "Website")

data_no_dup$Package.availability <- factor(data_no_dup$Package.availability , levels = c("Yes" , "No"))
plot_barplot( "Package.availability")

data_no_dup$`Data.availability` <- factor(data_no_dup$`Data.availability` , levels = c("Yes" , "No"))
plot_barplot( "Data.availability")




