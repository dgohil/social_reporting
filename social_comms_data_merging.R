###merging data all social comms data
## deepali 
## 8 october 2015

library(XLConnect)
library(ggplot2)
library(vcdExtra)
library(plyr)
#library(extrafont)
#loadfonts(device="postscript")
#postscriptFonts()

#set working directory
#all relevant excel files are saved under folder data in social reporting
setwd("~/Documents/NRT/scomms/Github/social_reporting") 

##merging data

### importing namunyak file
nm <- loadWorkbook("data/social_comms_data_namunyak_2015.xlsx")

nm_survey <- readWorksheet(nm,sheet="survey_brief")
### adding a colummn to the sheet survey_brief indicating this is baseline data
nm_survey$survey_type <- c("baseline")
  
nm_hhld <- readWorksheet(nm,sheet="hhld")
nm_assets <- readWorksheet(nm,sheet="assets_income")
nm_health <- readWorksheet(nm,sheet="health")
nm_ccy <- readWorksheet(nm,sheet="ccy")
nm_grazing <- readWorksheet(nm,sheet="grazing")
nm_wildlife <- readWorksheet(nm,sheet="wildlife")
nm_security <- readWorksheet(nm,sheet="security")
nm_cellphone <- readWorksheet(nm,sheet="cellphone")

####sera data
se <- loadWorkbook("data/social_comms_data_sera_2015.xlsx")

se_survey <- readWorksheet(se,sheet="survey_brief")
### adding a colummn to the sheet survey_brief indicating this is baseline data
se_survey$survey_type <- c("baseline")

se_hhld <- readWorksheet(se,sheet="hhld")
se_assets <- readWorksheet(se,sheet="assets_income")
se_health <- readWorksheet(se,sheet="health")
se_ccy <- readWorksheet(se,sheet="ccy")
se_grazing <- readWorksheet(se,sheet="grazing")
se_wildlife <- readWorksheet(se,sheet="wildlife")
se_security <- readWorksheet(se,sheet="security")
se_cellphone <- readWorksheet(se,sheet="cellphone")

###merging sheets
survey <- rbind(nm_survey,se_survey)
hhld <- rbind(nm_hhld,se_hhld)
assets <- rbind (nm_assets, se_assets)
health <- rbind(nm_health, se_health)
ccy <- rbind(nm_ccy, se_ccy)
grazing <- rbind(nm_grazing, se_grazing)
wildlife <- rbind (nm_wildlife, se_wildlife)
security <- rbind(nm_security, se_security)
cellphone <- rbind(nm_cellphone, se_cellphone)

###comparing columns to see which ones do not structurally match
#missing <- setdiff(names(nm_wildlife),names(se_wildlife))
#missing
#missing <- setdiff(names(nm_assets),names(se_assets))
#missing

###adding unique id to the df and merging with basic survey information
survey$hhuid <- seq.int(nrow(survey))
hhld <- merge(survey,hhld,by ="hhid")
assets <- merge(survey,assets,by ="hhid")
health <- merge(survey, health, by="hhid")
ccy <- merge(survey, ccy, by = "hhid")
grazing <- merge(survey, grazing, by = "hhid")
wildlife <- merge(survey, wildlife, by = "hhid")
security <- merge(security, survey, by = "hhid")
cellphone <- merge(survey, cellphone, by = "hhid")

###importing 2014 data
old <- loadWorkbook("data/social_comms_data_2014_reformatted.xlsx")
old_survey <- readWorksheet(old,sheet="survey_brief")

### adding a colummn to the sheet survey_brief indicating this is baseline data
old_survey$survey_type <- c("baseline")
old_hhld <- readWorksheet(old,sheet="hhld")
old_hhld2 <- readWorksheet(old,sheet="hhld2")
old_assets <- readWorksheet(old,sheet="assets_income")
old_health <- readWorksheet(old,sheet="health")
old_ccy <- readWorksheet(old,sheet="ccy")
old_grazing <- readWorksheet(old,sheet="grazing")
old_wildlife <- readWorksheet(old,sheet="wildlife")
old_security <- readWorksheet(old,sheet="security")
old_cellphone <- readWorksheet(old,sheet="cellphone")

old_hhld1 <- merge(old_hhld,old_hhld2, by="hhid")
library(plyr)
#str(old_hhld1)
colnames(old_hhld1) <- c("hhid","index","name","respondent","relation_to_head","gender","age","marital", "edu_level","activity","activity.other.","female_head","length_stay","belong_grp_ranch","name.1","tribe","tribe.other.")
old_survey$hhuid <- seq.int(nrow(old_survey))

old_hhld3 <- merge(old_survey,old_hhld1,by ="hhid")
old_assets1 <- merge(old_survey,old_assets,by ="hhid")
old_health1 <- merge(old_survey, old_health, by="hhid")
old_ccy1 <- merge(old_survey, old_ccy, by = "hhid")
old_grazing1 <- merge(old_survey, old_grazing, by = "hhid")
old_wildlife1 <- merge(old_survey, old_wildlife, by = "hhid")
old_security1 <- merge(old_security, old_survey, by = "hhid")
old_cellphone1 <- merge(old_survey, old_cellphone, by = "hhid")

###merging sheets
survey <- rbind(survey,old_survey)
###adding county data into a column
survey$county <- revalue(survey$ccy, c("sera"= "Samburu", "namunyak" = "Samburu", "Kalama"="Samburu","Melako"="Marsabit","Nakuprat_Gotu"="Isiolo","Ilngwesi"="Laikipia"))

hhld <- rbind(hhld,old_hhld3)
assets <- rbind (assets, old_assets1)
health <- rbind(health, old_health1)
ccy <- rbind(ccy, old_ccy1)
grazing <- rbind(grazing, old_grazing1)
wildlife <- rbind (wildlife, old_wildlife1)
security <- rbind(security, old_security1)
cellphone <- rbind(cellphone, old_cellphone1)

### all data has been merged
