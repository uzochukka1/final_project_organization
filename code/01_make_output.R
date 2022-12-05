pacman::p_load(
  rio,          # File import
  here,         # File locator
  tidyverse,    # data management + ggplot2 graphics, 
  stringr,      # manipulate text strings 
  purrr,        # loop over objects in a tidy way
  gtsummary,    # summary statistics and tests 
  broom,        # tidy up results from regressions
  lmtest,       # likelihood-ratio tests
  parameters,   # alternative to tidy up results from regressions
  see,          # alternative to visualize forest plots
  ggplot2,
  ggplot,
  tidyquant,
  lubridate,
  slider,
  RColorBrewer
)

#load packages
library(tidyverse)
library(slider)
library(tidyquant)
library(lubridate)

pacman::p_load(
  rio,           # import/export
  here,          # filepaths
  lubridate,     # working with dates
  forcats,       # factors
  aweek,         # create epiweeks with automatic factor levels
  janitor,       # tables
  tidyverse      # data mgmt and viz
)

#Import dataset (you'll have to upload), clean names
library(readr)
diabetes <- read_csv("C:/Users/uzchu/Downloads/diabetes_012_health_indicators_BRFSS2015.csv/diabetes_012_health_indicators_BRFSS2015.csv")

###rename

diabetes <- diabetes %>% 
  mutate(Diabetes_012 = recode(Diabetes_012,
                                  # for reference: OLD = NEW
                                  "0"  = "No diabetes",
                                  "2"  = "Diabetic",
  ))

diabetes <- diabetes %>% 
  mutate(BMI_cat = case_when(
    # criteria                                   # new value if TRUE
    BMI < 20                        ~ "low",
    BMI >= 20 & BMI < 30 ~ "medium",
    BMI >= 30                       ~ "high",
    is.na(BMI)                     ~ NA_character_,
    TRUE                                       ~ "Check me"))  

############



####
options(scipen= 1000)

figure <- ggplot(diabetes) +  
  geom_col(
    mapping = aes(
      x = BMI_cat,                 # show pre-calculated proportion values
      y = PhysHlth,          # reverse level order so missing/other at bottom
      fill = Diabetes_012),                # stacked diabetic status
    width = 0.5)+                    # thinner bars (out of 1)
  theme_minimal() +                  # Minimal theme 
  theme(legend.position = "bottom")+
  labs(subtitle = "Diabetic status, by physical health and BMI",
       fill = "Presence of Diabetis",             # legend title
       y = "Days of Physical activity",                  # y axis title
       x = "BMI status")+ # x axis title
  scale_fill_manual(                 # adding colors manually
    values = c("Diabetic"= "#3B1c8C",
               "No diabetes" = "#21908D" )) 

# use saveRDS to save figure object
saveRDS(object, file = "figure.rds")

# Analysis here to create a table or figure 

pacman::p_load(
  rio,            # import/export
  here,           # file pathways
  flextable,      # make HTML tables
  officer,        # helper functions for tables
  tidyverse)     # data management, summary, and visualization

library(dbplyr)
library(gt)
library(tidyverse)
library(glue)
library(gtsummary)

# Get summary values per diabetic status by age, physical health, and BMI
topicSummary <- diabetes %>%
  group_by(Age) %>%
  summarise(
    PhysHlth = n(),                                               
    Mean_BMI = round(mean(BMI, na.rm=T), 2))

knitr::kable(topicSummary)

# add code to save topicSummary saveRDS
saveRDS(object, file = "topicSummary.rds")



