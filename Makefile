report.html: report.Rmd code/02_render_report.R diabetes_output
	Rscript code/02_render_report.R

diabetes_output:
	Rscript code/01_make_output.R


.PHONY: clean
clean:
	rm -f output/*.rds && rm -f report.html
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"