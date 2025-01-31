


library(ggplot2)
library(scales)
library(dplyr)
library(ggrepel)


theme_set(theme_bw() +
            theme(panel.grid.major = element_blank(), 
                  panel.grid.minor = element_blank(),
                  panel.background = element_rect(colour = "black", size = 1),
                  axis.text.x = element_text(color = "black", angle = 45, hjust = 1),
                  axis.text.y = element_text(color = "black")))

 
data <- read_csv("data.csv")


# these are meta data of each paper
meta <- data[, c( "PMID" , "Paper.title",  "finer_topic" ,  "broader_topic" ,  "Paper.category" ) ]


# selected criteria 
categorical_columns <- c( 
  "Methods.compared", 
  "Selection.criteria", 
  "Memory.measured", 
  "Max.number.of.cells",
  "Sensitivity.analysis", 
  "Tuning" ,
  "Discovery." ,
  "Wet.lab.validation", 
  "Website", 
  "Data.availability", 
  "Code.availability", 
  "Prior.knowledge"  ,
  "Types.of.data"   , 
  "Number.of.experimental.datasets", 
  "Number.of.synthetic.datasets", 
  "Diversity.of.experimental.data", 
  "Recommendation", 
  "Applicability", 
  "Trade.offs", 
  "Future.directions" ,
  "Diversity.of.synthetic.datasets", 
  "Speed.measured.", 
  "Overall.comparison",
  "Variability.of.score", 
  "Downstream.analysis" ,
  "PMID"
)


data_heatmap <- data[ ,   categorical_columns ]
data_heatmap  <- data.frame(data_heatmap )


data_heatmap[ data_heatmap  == "No"] <- 0 
data_heatmap[ data_heatmap  == "Yes"] <- 1

data_heatmap[ data_heatmap  == "Default setting"] <- 0
data_heatmap[ data_heatmap  == "Parameter tuning"] <- 1

data_heatmap[ data_heatmap  == "Not sure"]  <- 0.5

data_heatmap[ data_heatmap  == "Synthetic data"]  <- 0.5
data_heatmap[ data_heatmap  == "Experimental data"]  <- 0.5
data_heatmap[ data_heatmap  == "Both"]  <- 1

data_heatmap$Use.both.synthetic.and.experimental <- data_heatmap$Types.of.data
data_heatmap$Use.both.synthetic.and.experimental[data_heatmap$Use.both.synthetic.and.experimental == 0.5 ] <- 0


data_heatmap$Number.of.experimental.datasets <-  rescale( log10(data_heatmap$Number.of.experimental.datasets + 1) ) 
data_heatmap$Number.of.synthetic.datasets <-  rescale( log10(data_heatmap$Number.of.synthetic.datasets + 1) )
data_heatmap$Max.number.of.cells <-  rescale( log10(data_heatmap$Max.number.of.cells + 1) ) 


data_heatmap$Methods.compared <- rescale( data_heatmap$Methods.compared )


data_heatmap <- data_heatmap %>%
  dplyr::mutate(across(-PMID, as.numeric))



# Because each paper has 2 or 3 readers
# to score each paper, take the mean of the readers 
data_heatmap <- data_heatmap %>%
  dplyr::group_by(PMID) %>%
  dplyr::summarise(across(everything(), ~ mean(., na.rm = TRUE)))


meta <- meta[ match(data_heatmap$PMID, meta$PMID), ]


# remove pmid
data_heatmap <- data_heatmap[, -1]

# recommendation is not applicable for method development papers
data_heatmap[  meta$`Paper.category` == "New method development paper", ]$Recommendation <- 0

# downstream is not applicable for paper that benchmarked downstream analysis methods 
data_heatmap[ meta$broader_topic  == "Downstream analysis", ]$Downstream.analysis <- NaN



col <- c( "Data" = "#df3826" , 
          "Method" = "#ee7c22", 
          "Accuracy" = "#fec20e", 
          "Scalability" = "#90bd3e" , 
          "Stability" = "#28b34b" , 
          "Downstream" = "#0095ac" , 
          "Context specific discovery"  = "#1f65ad", 
          "Communication" = "#42449b", 
          "Software" = "#903795" )


score_plot <- list()
score_scatter <- NULL
this_type <- unique(meta$`Paper.category`)[1]

for (this_type in unique(meta$`Paper.category`)){
  index <- which(meta$`Paper.category`== this_type)
  
  # note, because we have set na.rm to be true
  # this means, columns like downstream is only calculated for the subset of papers not in the downstream broader topic
  # and that, diversity of synthetic dataset only calculated for the subset of papers that looked at synthetic dataset 
  temp <- colMeans(data_heatmap[index, ], na.rm = T )
  temp <- data.frame(temp)
  temp$type_paper <- this_type
  temp$criteria <- rownames(temp)
  
  
  temp$category[temp$criteria %in% c("Diversity.of.experimental.data" , 
                                     "Diversity.of.synthetic.datasets" , 
                                     "Types.of.data" ,
                                     "Use.both.synthetic.and.experimental")] <- "Data"
  temp$category[temp$criteria %in% c("Methods.compared" , "Selection.criteria")] <-"Method"
  temp$category[temp$criteria %in% c("Overall.comparison" , "Variability.of.score")] <- "Accuracy"
  temp$category[temp$criteria %in% c("Memory.measured" , "Speed.measured.")] <- "Scalability"
  temp$category[temp$criteria %in% c("Tuning" , "Sensitivity.analysis")] <- "Stability"
  temp$category[temp$criteria %in% c("Downstream.analysis")] <- "Downstream"
  temp$category[temp$criteria %in% c("Wet.lab.validation" ,"Discovery." , "Prior.knowledge")] <- "Context specific discovery"  
  temp$category[temp$criteria %in% c("Trade.offs" , "Applicability" , "Future.directions" , "Recommendation" )] <- "Communication"
  temp$category[temp$criteria %in% c("Code.availability" , 
                                     "Data.availability" , 
                                     "Website" )] <- "Software"
  
  temp$criteria <- gsub("\\." , " ", temp$criteria)
  temp <- temp[ order(temp$temp, decreasing = T), ]
  temp$criteria <- factor(temp$criteria, levels = rev( temp$criteria) )
  
  temp <- temp[ -c( which( temp$criteria %in% c("Number of experimental datasets" , 
                                                "Max number of cells", 
                                                "Number of synthetic datasets" , 
                                                "Methods compared", 
                                                "Types of data"))) , ]
  
  
  if ( is.null(score_scatter)){
    score_scatter <- temp
  }else{
    score_scatter <- merge(score_scatter, temp, 
                           by.x = "criteria" , by.y = "criteria")
  }
  
  p <- ggplot(temp , aes(x = temp , y = criteria, fill = category)) + 
    geom_col( alpha = 0.5 , width = 0.6)  + scale_fill_manual( values = col) + 
    ggtitle(this_type) + xlab("Percentage") + ylab("Criteria") + 
    geom_vline(xintercept=0.25, linetype="dashed", size= 0.5) + 
    geom_vline(xintercept=0.5, linetype="dashed", size= 0.5) + 
    geom_vline(xintercept=0.75, linetype="dashed", size= 0.5)
  
  score_plot[[this_type]] <- p
  
}

panel_b <- ggarrange(plotlist = score_plot, common.legend = T)



panel_a <- ggplot(score_scatter, aes(x = temp.x ,  y = temp.y, 
                                     size = temp.x, label = criteria  )) +
  geom_point(alpha = 0.4 , aes(colour = category.x) ) + 
  scale_colour_manual( values = col ) + 
  geom_vline(xintercept=0.25, linetype="dashed", size= 0.2) + 
  geom_vline(xintercept=0.5, linetype="dashed", size= 0.2) + 
  geom_vline(xintercept=0.75, linetype="dashed", size= 0.2) +
  geom_hline(yintercept=0.25, linetype="dashed", size= 0.2) +
  geom_hline(yintercept=0.5, linetype="dashed", size= 0.2) + 
  geom_hline(yintercept=0.75, linetype="dashed", size= 0.2) + 
  ggrepel::geom_label_repel(size = 3, show.legend = FALSE, 
                            aes(colour = category.x)) +
  ylab("Percentage in new method development paper") + 
  xlab("Percentage in pure benchmarking paper")


panel_a

panel_b

 
