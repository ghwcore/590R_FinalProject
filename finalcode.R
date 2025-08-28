#EPI590R Final Project

#1. Created RProject.

#2.Created github repo and added lines below into terminal.
#git remote add origin https://github.com/ghwcore/EPI590R_FinalProject.git
#git branch -M main
#git push -u origin main

#Added the pregnancy data with {here}
here::here("pregnancy_data.csv")
dat <- read.csv(here::here("pregnancy_data.csv"))
print(dat)

#Add library
library(gtsummary)

#
