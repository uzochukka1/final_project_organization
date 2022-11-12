report.html: report.Rmd code/02_render_report.R diabetes_output
	Rscript code/02_render_report.R

diabetes_output:
	Rscript code/01_make_output.R

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f report.html

Make Install rule 

renv::restore()   #This restores the packages in the lockfile

renv::activate()   #This loads all necessary packages needed for the project

