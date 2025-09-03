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
library(tidyverse)
library(ggplot2)

#Create descriptive table using {gtsummary}
tbl_summary(dat,
						by =DystociaCase,
						include = c(age, active_labor_duration_min, BMI_late, SES_Index, gravidity,
  											parity, NEFA__Acetate, NEFA__Butyrate, NEFA__Iso.Valerate,
												NEFA__Iso.Caprate, NEFA__Formate, NEFA__Propionate,
												NEFA__Stearic, NEFA__Hexanoic, NEFA__Arachidonic),
						#Modify to show min and max
						statistic = list(
												all_continuous() ~ "{mean} ({min}, {max})"

						)
						) |>
						#add test
						add_p(test = list(
							all_continuous() ~ "t.test",
							all_categorical() ~ "chisq.test"
							))

# logistic model
logistic_model <- glm(DystociaCase ~ age + gravidity + parity,
											data = dat, family = binomial()
)

summary(logistic_model)

#logistic table
tbl_regression(
	logistic_model,
	exponentiate = TRUE

)

#Create figure
hist(dat$SES_Index)


#Create a function
run_lin_reg <- function(dat){
	#linear model
	linear_model <- lm(active_labor_duration_min ~ age,
										 data = dat
	)

	tbl_regression(
		linear_model,
		# include the intercept
		intercept = TRUE,
	)


} #end function

#run function
run_lin_reg(dat)

# Scatter plot for age vs active labor duration min
ggplot(dat, aes(x = age, y = active_labor_duration_min)) +
	geom_point(alpha = 0.6) +
	geom_smooth(method = "lm", se = TRUE, color = "blue") +
	labs(title = "active labor duration min vs age",
			 x = "age",
			 y = "active labor duration min") +
	theme_classic()


