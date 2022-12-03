FROM rocker/r-ubuntu 

RUN Rscript -e "install.packages('here')"
RUN Rscript -e "install.packages('rmarkdown')"

RUN apt-get update && apt-get install -y pandoc 

RuN mkdir /final_project_organization
WORKDIR /final_project_organization


RUN mkdir code 
RUN mkdir output 
COPY code code 
COPY Makefile . 
COPY report.Rmd .

COPY .Rprofile . 
COPY renv.lock . 
RUN mkdir renv
COPY renv/activate.R renv
COPY renv/settings.dcf renv



RUN Rscript -e "renv::restore(prompt = FALSE)"

RUN mkdir final_report

CMD make &&mv report.html final_report