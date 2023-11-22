

library(ggplot2)
library(ggthemes)
library(viridis)
library(readr)

theme_set(theme_classic())

 
data <- read_csv("data.csv")

data$Paper.category <- factor( data$Paper.category , levels = c( "Pure benchmarking paper" ,
                                                                 "New method development paper"))


data <- data[ !duplicated(data$PMID), ]



options(scipen = 9999)
library(scales)


df_numeric <- data

 
df_numeric$Paper.category <- recode(df_numeric$Paper.category  ,
                                    `Pure benchmarking paper` = "Benchmark only",
                                    `New method development paper` = "Method development"
)



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



# for the categorical ones, plot barplot 

plot_barplot <- function( variable  = "Diversity.of.experimental.data" , title ="Diverisity of experimental data" ){
  
  
  df_count <- df_numeric %>% 
    dplyr::group_by(Paper.category,  norm_year2 ) %>% 
    dplyr::count( !!sym(variable) )  %>% 
    dplyr::mutate(freq = n / sum(n)  )
  
  
  df_count <- df_count[ df_count[[variable]]== 1, ]
  df_count <- df_count[ !is.na(df_count[[variable]]), ]
  
  
  p <- df_count  %>% 
    ggplot() +
    aes(x = as.factor( norm_year2), y = freq , fill = norm_year2) +
    geom_col(alpha = 0.3) +
    labs(x = "Adjusted Year", y = "Proportion of papers",
         title =  title , color = "Adjusted Year") +
    facet_wrap(~Paper.category, scales = "free", ncol = 2) +
    scale_fill_viridis(discrete = T, option = "C", begin = 0.2, end = 0.7) + 
    theme_classic() +  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
  
  return(p)
}



p_experimental_diverisity <- plot_barplot("Diversity.of.experimental.data"  , "Diverisity of experimental data")

p_synthetic_diversity <- plot_barplot( "Diversity.of.synthetic.datasets" , "Diversity of synthetic data")


p_selection  <- plot_barplot("Selection.criteria" , "Selection criteria" )



p_variability_score <- plot_barplot( "Variability.of.score" , "Variability of score")

p_overall_comparison <- plot_barplot( "Overall.comparison" , "Overall comparison")




p_sensitivity  <- plot_barplot("Sensitivity.analysis" , "Sensitivity analysis" )

p_tuning  <- plot_barplot("Tuning" , "Parameter tuning" )


p_memory <- plot_barplot("Memory.measured" , "Memory measured")

p_speed <- plot_barplot("Speed.measured." , "Speed measured" )


p_downstream <- plot_barplot( "Downstream.analysis"  , "Downstream analysis")


p_knowledge <- plot_barplot( "Prior.knowledge"  , "Prior knowledge")

p_discovery  <- plot_barplot("Discovery." , "Discovery" )

p_wet_lab  <- plot_barplot("Wet.lab.validation" , "Wet lab validation" )



p_recommendation <- plot_barplot( "Recommendation"  ,  "Recommendation" )

p_applicability <- plot_barplot("Applicability" , "Applicability" )

p_trade_off <- plot_barplot( "Trade.offs" , "Trade off")

p_future_direction <- plot_barplot("Future.directions"  , "Future direction")



p_data_available <-   plot_barplot("Data.availability" , "Data availability" )

p_package_available <- plot_barplot("Package.availability" , "Package availability")

p_website  <- plot_barplot( "Website"  , "Website" )



p_synthetic <- df_numeric %>% 
  ggplot() +
  aes(x = as.factor( norm_year2) , y = Number.of.synthetic.datasets, color = norm_year2) +
  geom_boxplot() +
  labs(x = "Adjusted Year", y = "Number (log10 scale)",
       title = "Number of synthetic datasets", color = "Adjusted Year") +
  facet_wrap(~Paper.category, scales = "free", ncol = 2) +
  scale_y_log10() +
  scale_color_viridis(discrete = T, option = "C", begin = 0.2, end = 0.7) +
  theme_classic() +  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))


p_num_cell <- df_numeric %>% 
  ggplot() +
  aes(x = as.factor( norm_year2), y = Max.number.of.cells, color = norm_year2) +
  geom_boxplot() +
  labs(x = "Adjusted Year", y = "Number (log10 scale)",
       title = "Max number of cells", color = "Adjusted Year") +
  facet_wrap(~Paper.category, scales = "free", ncol = 2) +
  scale_y_log10() +
  scale_color_viridis(discrete = T,  option = "C", begin = 0.2, end = 0.7) +
  theme_classic() +  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))


ggarrange(plotlist =  list( p_synthetic ,
                            
                            p_experimental_diverisity , p_synthetic_diversity,
                            
                            p_selection , 
                            
                            p_variability_score , p_overall_comparison, 
                            
                            p_sensitivity  , p_tuning  , 
                            
                            p_memory  , p_speed ,  p_num_cell, 
                            
                            p_downstream  , 
                            
                            p_knowledge, p_discovery , p_wet_lab , 
                            
                            p_recommendation , p_applicability , p_trade_off , p_future_direction , 
                            
                            p_data_available ,   p_package_available ,   p_website  ),
          ncol = 4, nrow  = 6,  common.legend = T)


 
