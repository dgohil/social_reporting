# load packages
library(knitr)
library(markdown)
library(rmarkdown)


# for each conservancy in the data create a report
# these reports are saved in output_dir with the name specified by output_file
# below code is for html file
for (ccy in unique(survey$ccy)) {
  #rmarkdown::render("~/Documents/NRT/scomms/Github/social_reporting/social_comms_reports.Rmd",  # file 2
                    #output_file =  paste("report_", car, '_', Sys.Date(), ".html", sep=''), 
                    #output_dir = "~/Documents/NRT/scomms/Github/social_reporting")
  
#for pdf reports  
   rmarkdown::render(input = "~/Documents/NRT/scomms/Github/social_reporting/social_comms_reports.Rmd", 
           output_format = "pdf_document",
           output_file = paste("scomms", ccy, Sys.Date(), ".pdf", sep=''),
           output_dir = "~/Documents/NRT/scomms/Github/social_reporting/reports")
  
}


