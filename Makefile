report.html: report.Rmd code/02_render_report.R diabetes_output
	Rscript code/02_render_report.R

diabetes_output:
	Rscript code/01_make_output.R output/diabetes_output.rds 


.PHONY: clean
clean:
	rm -f output/*.rds && rm -f report.html
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"
	
# Docker Associated Rule
PROJECTFILES = report.Rmd code/01_make_output.R code/02_render_report.R Makefile
RENVFILES = renv.lock renv.activate.R renv/settings.dcf

#rule to build image
uzochukka/project_image: Dockerfile $(PROJECTFILES) $(RENVFILES)
	docker build -t uzochukka/project_image .
	touch $@

#rule to run container
final_report/report.html:
	docker run -v "/$$(pwd)/final_report":/final_project_organization/final_report uzochukka/project_image
or 
	docker run -it -v "//c/Users/uzchu/Downloads/final_project_organization/final_report":/final_project_organization/final_report project_image