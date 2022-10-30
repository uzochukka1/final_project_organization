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
  janitor::clean_names()
  
 ###rename

diabetes <- diabetes %>% 
  mutate(diabetes_binary = recode(diabetes_binary,
                           # for reference: OLD = NEW
                           "0"  = "No diabetes",
                           "1"  = "Diabetic",
                      ))

diabetes <- diabetes %>% 
  mutate(bmi_cat = case_when(
    # criteria                                   # new value if TRUE
    bmi < 20                        ~ "low",
    bmi >= 20 & bmi < 30 ~ "medium",
    bmi >= 30                       ~ "high",
    is.na(bmi)                     ~ NA_character_,
    TRUE                                       ~ "Check me"))  

############



####
options(scipen= 1000)

ggplot(diabetes) +  
  geom_col(
    mapping = aes(
      x = bmi_cat,                 # show pre-calculated proportion values
      y = phys_hlth,          # reverse level order so missing/other at bottom
      fill = diabetes_binary),                # stacked diabetic status
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
  
 




 
