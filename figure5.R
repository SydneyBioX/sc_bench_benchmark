

library(ggplot2)
library(ggthemes)
library(viridis)
library(readr)
library(scales)

theme_set(theme_bw() +
            theme(panel.grid.major = element_blank(), 
                  panel.grid.minor = element_blank(),
                  panel.background = element_rect(colour = "black", size = 1),
                  axis.text.x = element_text(color = "black", angle = 45, hjust = 1),
                  axis.text.y = element_text(color = "black")))


data <- read_csv("data.csv")



data$Paper.category[data$Paper.category == "New method development paper" ] <- "Method development" 
data$Paper.category[data$Paper.category == "Pure benchmarking paper"] <- "Benchmark only" 

data$Paper.category <- factor( data$Paper.category , levels = c( "Benchmark only" ,
                                                                 "Method development"))


data <- data[ !duplicated(data$PMID), ]


################
# Panel a
##############

data$category_year <- as.character( data$year )
data[ data$category_year  <= 2018 , ]$category_year <- "<2018"
data[ data$category_year  %in% c( 2019, 2020) , ]$category_year <- "2019-2020"
data[ data$category_year  %in% c( 2021, 2022) , ]$category_year <- "2021-2022"
data[ data$category_year  %in% c( 2023, 2024) , ]$category_year <- "2023-2024"


ggplot(data ,   aes(x = norm_year2, fill=as.numeric(as.factor(norm_year2) ))) +
  geom_bar( ) + 
  labs(x = "Adjusted Year", y = "Number",
       title = "Number of papers by adjusted year") + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+
  facet_wrap( ~Paper.category+ category_year, ncol = 4)+ 
  scale_fill_viridis(option = "C", begin = 0.2, end = 0.7)



################
# Panel b
##############




column_of_interest <- c( 
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
  "Package.availability", 
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
  
  "Downstream.analysis"  
  
)



df_numeric <- data
df_numeric <- df_numeric[ , -c( which( colnames( df_numeric) == "Timestamp")) ]
df_numeric <- as.data.frame(df_numeric)

df_numeric[ df_numeric  == "No"] <- 0 
df_numeric[ df_numeric  == "Yes"] <- 1

df_numeric[ df_numeric == "Default setting"] <- 0
df_numeric[ df_numeric == "Parameter tuning"] <- 1

df_numeric[ df_numeric  == "Not sure"]  <- 0.5

df_numeric[ df_numeric == "Synthetic data"]  <- 0.5
df_numeric[ df_numeric  == "Experimental data"]  <- 0.5
df_numeric[ df_numeric  == "Both"]  <- 1



data_heatmap <- df_numeric[, c( column_of_interest  ,"PMID" ) ]
data_heatmap  <- as.data.frame(data_heatmap )
data_heatmap[is.na(data_heatmap)] <- 0 

data_heatmap$Number.of.experimental.datasets <-  rescale( log10(data_heatmap$Number.of.experimental.datasets + 1) ) 
data_heatmap$Number.of.synthetic.datasets <-  rescale( log10(data_heatmap$Number.of.synthetic.datasets + 1) )
data_heatmap$Max.number.of.cells <-  rescale( log10(data_heatmap$Max.number.of.cells + 1) ) 
data_heatmap$Methods.compared <- rescale( data_heatmap$Methods.compared )

data_heatmap <- data_heatmap %>%
  dplyr::mutate(across(-PMID, as.numeric))

str(data_heatmap)


data_heatmap <- data_heatmap %>%
  dplyr::group_by(PMID) %>%
  dplyr::summarise(across(everything(), ~ mean(., na.rm = TRUE)))

pmid <- as.vector( data_heatmap[, 1] )
pmid  <- pmid$PMID
data_heatmap <- data_heatmap[, -1]



data_heatmap <- sapply(data_heatmap, as.numeric)
sum_score <- rowSums(  data_heatmap )

meta <- data[ match(pmid, data$PMID), ]
meta <- meta[, c("norm_year2", "Paper.category")]
sum_score <- data.frame( year = meta$norm_year2, score =  sum_score )
sum_score$paper_type <- meta$Paper.category
sum_score$year <- as.numeric(as.factor(sum_score$year)) # need to convert to numeric to fit the regression line 

ggplot(sum_score, aes( y = score  ,  x =  year ,  
                       colour = year))  +
  geom_jitter( alpha = 0.5 , size = 3)   +  geom_smooth( colour = "grey" , alpha = 0.1) + 
  scale_color_viridis(  option = "C", begin = 0.2, end = 0.7 ) + 
  facet_wrap(~paper_type)+  
  scale_x_continuous(breaks= pretty_breaks()) + 
  labs(x = "Adjusted Year", y = "Number",
       title = "Overall score")  




################
# Panel c
##############


df_numeric <- data
# df_numeric_rm_outlier <- df_numeric[ which( df_numeric$Methods.compared < 25), ]
df_numeric    %>% 
  ggplot() +
  aes(x = as.factor(norm_year2) , y = log10(Methods.compared), color = norm_year2) +
  geom_boxplot() +
  labs(x = "Adjusted Year", y = "Number",
       title = "Number of methods", color = "Adjusted Year") +
  facet_wrap(~Paper.category, scales = "free" )+ 
  scale_colour_viridis(discrete = T, option = "C", begin = 0.2, end = 0.7)+ 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) 




################
# Panel d
##############



df_numeric     %>% 
  ggplot() +
  aes(x = as.factor(norm_year2) , y = Number.of.experimental.datasets , color = norm_year2) +
  geom_boxplot() +
  labs(x = "Adjusted Year", y = "Number",
       title = "Number of experimental datasets", color = "Adjusted Year") +
  facet_wrap(~Paper.category, scales = "free" )+ 
  scale_colour_viridis(discrete = T, option = "C", begin = 0.2, end = 0.7) + scale_y_log10() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))




################
# Panel e
##############


num_more_method <-  data$Methods.compared -  data$biorxiv_number_method 

num_more_method <- data.frame(num_more_method = num_more_method, 
                              num_in_biorxiv = data$biorxiv_number_method , 
                              num_in_published = data$Methods.compared , 
                              paper_category = data$Paper.category,
                              year = as.numeric(as.factor(data$norm_year2)))

num_more_method <- num_more_method[ !is.na( num_more_method$num_in_biorxiv) ,  ]

# num_more_method <- num_more_method[ num_more_method$num_in_published < 25, ]

ggplot( num_more_method , aes(x =    log(num_in_biorxiv+1) , y =     log(num_in_published +1) ) ) +
  geom_point(aes(colour =  log(num_in_published+1)) , width = 0, height = 0.2,
             size = 3 , 
             alpha = 0.3) + 
  facet_wrap( ~paper_category, scales = "free") + 
  labs(x = "Number of biorxiv", y = "Number in published" )  + 
  geom_abline(intercept = 0, slope = 1, size = 0.5) + scale_colour_continuous( high = "red" , low = "blue") +
  ylim(0, 5 ) + xlim(0, 5)






#calculate proportion of paper that's more

library(tidyr)
result <- num_more_method %>%
  dplyr::group_by(paper_category) %>%
  dplyr::summarize(percentage_increase = mean(num_in_published > num_in_biorxiv, na.rm = TRUE),
                   percentage_same = mean(num_in_published <= num_in_biorxiv, na.rm = TRUE) )

# result 
# 
# paper_category     percentage_increase percentage_same
# <fct>                            <dbl>           <dbl>
# 1 Benchmark only                   0.391           0.609
# 2 Method development               0.494           0.506

