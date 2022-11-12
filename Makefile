report.html: report.Rmd code/02_render_report.R diabetes_output
	Rscript code/02_render_report.R

diabetes_output:
	Rscript code/01_make_output.R
<<<<<<< HEAD

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f report.html

=======

>>>>>>> 7f1601679da13ddc30f213376c3f5530b7947860
Make Install rule 

renv::restore()   #This restores the packages in the lockfile

<<<<<<< HEAD
renv::activate()   #This loads all necessary packages needed for the project
=======
renv::activate()   #This loads all necessary packages needed for the project

>>>>>>> 7f1601679da13ddc30f213376c3f5530b7947860
