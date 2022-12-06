FROM rocker/r-ubuntu 

RUN apt-get update && apt-get install -y pandoc libcurl4-openssl-dev libssl-dev libxml2-dev

RUN Rscript -e "install.packages('here')"
RUN Rscript -e "install.packages('rmarkdown')"
RUN Rscript -e "install.packages('knitr')"
RUN Rscript -e "install.packages('ggplot2')"
RUN Rscript -e "install.packages('readr')"
RUN Rscript -e "install.packages('tidyverse')"

RuN mkdir /final_project_organization
WORKDIR /final_project_organization

RUN mkdir code 
RUN mkdir output 
COPY code code 
COPY Makefile . 
COPY report.Rmd .
COPY diabetes_012_health_indicators_BRFSS2015

RUN mkdir final_report

CMD make && mv report.html final_report
