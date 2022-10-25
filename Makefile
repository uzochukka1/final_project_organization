report.html: report.Rmd code/02_render_report.R 
	Rscript code/02_render_report.R



.PHONY: clean
clean:
	rm -f output/*.rds && rm -f report.html