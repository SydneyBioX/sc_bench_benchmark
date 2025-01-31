
library(ggplot2)
library(ggpubr)
library(readr)
library(plyr)


theme_set(theme_bw() +
            theme(panel.grid.major = element_blank(), 
                  panel.grid.minor = element_blank(),
                  panel.background = element_rect(colour = "black", size = 1),
                  axis.text.x = element_text(color = "black", angle = 45, hjust = 1),
                  axis.text.y = element_text(color = "black")))


data <- read_csv("data.csv")




data_no_dup <- data[!duplicated(data$PMID), ]


plot_density <- function( mu,  column ){
  
  column <- sym(column)
  
  p <- ggplot(data_no_dup, aes(x = !!column )) + 
    geom_density( aes(  colour =`Paper.category` ),  alpha = 0.1)  + 
    scale_x_log10() + ylab("Distribution density") +
    
    # scale_fill_manual(values =  c(   "darkblue"  ,  "#E41A1C" ))+
    scale_colour_manual(values =  c(   "darkblue"  ,  "#E41A1C" ))+
    geom_vline(data=mu, aes(xintercept=grp.mean, color=Paper.category), linetype="dashed")
  
  
  return( p )
  
}


###################
# Panel a
###################



mu <- ddply(data_no_dup, "Paper.category", summarise, grp.mean=median(Number.of.experimental.datasets, na.rm=T))
a <- plot_density(mu, "Number.of.experimental.datasets") 


mu <- ddply(data_no_dup, "Paper.category", summarise, grp.mean=median(Number.of.synthetic.datasets, na.rm=T))
b<- plot_density(mu, "Number.of.synthetic.datasets") 


ggarrange(plotlist = list(  a,b) , align =  "v")


 

###################
# Panel b
###################


# diversity of experimental and synthetic 
# yes and no 

data_no_dup_no_NA <- data_no_dup[!is.na(data_no_dup$`Diversity.of.experimental.data`), ]
data_no_dup_no_NA$`Diversity.of.experimental.data` <- factor(data_no_dup_no_NA$`Diversity.of.experimental.data`, 
                                                             levels =  c("Yes", "No", "Not sure"))
p_num_diversity_experimental  <- ggplot( data_no_dup_no_NA, 
                                         aes( x = `Paper.category` , 
                                              fill =`Diversity.of.experimental.data`)) +
  geom_bar(position="fill",  na.rm = TRUE)  + 
  scale_fill_manual(values =  c( "darkblue" , "#E41A1C" , "lightgrey" )) + 
  ylab("Proportion of papers") + theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))



data_no_dup_no_NA <- data_no_dup[!is.na(data_no_dup$`Diversity.of.synthetic.datasets`), ]
data_no_dup_no_NA$`Diversity.of.synthetic.datasets` <- factor(data_no_dup_no_NA$`Diversity.of.synthetic.datasets`, 
                                                              levels =  c("Yes", "No", "Not sure"))

p_num_diversity_synthetic <- ggplot( data_no_dup_no_NA, 
                                     aes(x = `Paper.category` , 
                                         fill =`Diversity.of.synthetic.datasets`)) +
  geom_bar(position = "fill", na.rm = TRUE)  + 
  scale_fill_manual(values = c( "darkblue" , "#E41A1C" , "lightgrey" ))+ 
  ylab("Proportion of papers") + theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

ggarrange(plotlist = list(  p_num_diversity_experimental  , p_num_diversity_synthetic))


 



###################
# Panel c
###################

experiment_diversity <- unlist( strsplit( data_no_dup$`Experimental.diversity` , "--"))

experiment_diversity <- experiment_diversity[ -c(which( is.na(experiment_diversity) ) ,
                                                 which( experiment_diversity == "NA") ) ]


experiment_diversity <- gsub("different sample types" , 
                             "different biological complexity" ,experiment_diversity)
experiment_diversity <- tolower(experiment_diversity)


experiment_diversity <- data.frame( table( trimws(experiment_diversity) )  )

experiment_diversity$prop <- experiment_diversity$Freq /nrow(data_no_dup)

experiment_diversity <- experiment_diversity[order(experiment_diversity$Freq,
                                                   decreasing = F), ]

experiment_diversity$Var1 <- factor(experiment_diversity$Var1, 
                                    experiment_diversity$Var1)

experiment_diversity  <- experiment_diversity [ -c(which ( experiment_diversity$Var1 == "others")), ]

a  <- ggplot(experiment_diversity, aes(y = Var1, x = prop,  fill = Var1)) +
  geom_bar(stat = "identity", position = "dodge", alpha = 0.5) + 
  ylab("Proportion of papers") + xlab("Diversity detail")+ scale_fill_discrete(guide="none")





synthetic_diversity <- unlist( strsplit( data_no_dup$`Synthetic.diversity` , "--"))
synthetic_diversity <- synthetic_diversity[ -c(which( is.na(synthetic_diversity) ) , which( synthetic_diversity == "NA") ) ]

synthetic_diversity <- tolower(synthetic_diversity)
synthetic_diversity <- synthetic_diversity[-c(which(synthetic_diversity == "others"))]
synthetic_diversity <- gsub("different degree of cluster separability" , 
                            "different degrees of cluster separability" , synthetic_diversity)
synthetic_diversity <- gsub("different degrees of rareness for individual types of cell" , 
                            "different degrees of rareness" ,synthetic_diversity)
synthetic_diversity <- gsub("different spread of ds genes" , 
                            "different spread of the genes" ,synthetic_diversity)

synthetic_diversity <- gsub("different long and short range interaction with different spatial distance.", 
                            "differential spatial distance"  ,synthetic_diversity)


synthetic_diversity <- gsub("different tissue types", 
                            "differential tissues"  ,synthetic_diversity)


synthetic_diversity <- gsub("different gene counts", 
                            "differential number of genes"  ,synthetic_diversity)



synthetic_diversity <- data.frame( table( trimws(synthetic_diversity) )  )

synthetic_diversity <- synthetic_diversity[order(synthetic_diversity$Freq , 
                                                 decreasing = F), ]
synthetic_diversity$prop <- synthetic_diversity$Freq /nrow(data_no_dup)

synthetic_diversity$Var1 <- factor(synthetic_diversity$Var1,
                                   synthetic_diversity$Var1)

b <- ggplot(synthetic_diversity, aes(y = Var1, x = prop, fill = Var1)) +
  geom_bar(stat = "identity", position = "dodge" , alpha = 0.5) + 
  ylab("Proportion of papers") + xlab("Diversity detail")+ scale_fill_discrete(guide="none")


ggarrange(plotlist = list(  a,b) , align =  "v")

 

