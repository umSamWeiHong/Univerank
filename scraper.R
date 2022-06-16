library(rvest)
library(dplyr)
library(jsonlite)
library(tidyverse)

data1 <- jsonlite::fromJSON('https://www.timeshighereducation.com/sites/default/files/the_data_rankings/world_university_rankings_2017_0__06ec07a66faf58bb6171791e5852fe1c.json')
table1 <- data1$data
table1['year'] <- 2017

data2 <- jsonlite::fromJSON('https://www.timeshighereducation.com/sites/default/files/the_data_rankings/world_university_rankings_2018_0__e814f039fcc8ddc45dc6085e4a8a8b66.json')
table2 <- data2$data
table2['year'] <- 2018

data3 <- jsonlite::fromJSON('https://www.timeshighereducation.com/sites/default/files/the_data_rankings/world_university_rankings_2019_0__8923a34186e552aa8aec863e45bc02d5.json')
table3 <- data3$data
table3['year'] <- 2019

data4 <- jsonlite::fromJSON('https://www.timeshighereducation.com/sites/default/files/the_data_rankings/world_university_rankings_2020_0__24cc3874b05eea134ee2716dbf93f11a.json')
table4 <- data4$data
table4['year'] <- 2020

data5 <- jsonlite::fromJSON('https://www.timeshighereducation.com/sites/default/files/the_data_rankings/world_university_rankings_2021_0__fa224219a267a5b9c4287386a97c70ea.json')
table5 <- data5$data
table5['year'] <- 2021

table1 <- within(table1, remove(cta_button, courses_button))
table2 <- within(table2, remove(cta_button, courses_button))
table3 <- within(table3, remove(cta_button, courses_button))
table4 <- within(table4, remove(cta_button, courses_button))
table5 <- within(table5, remove(cta_button, courses_button))

appendedDf <- rbind(table1, table2, table3, table4, table5)
appendedDf <- appendedDf[ -c(1,5,7,9,11,13,15,17,18,19,25,26,27,28,29,30) ]

appendedDf$rank = (gsub("[\\=,]", "", appendedDf$rank))
appendedDf$rank = (gsub("[\\+,]", "", appendedDf$rank))
appendedDf$rank = sub("(^[^-]+)—.*", "\\1", appendedDf$rank)
appendedDf$rank = sub("(^[^-]+)-.*", "\\1", appendedDf$rank)
appendedDf$rank = sub("(^[^-]+)–.*", "\\1", appendedDf$rank)
appendedDf$stats_number_students = as.numeric(gsub("[\\,,]", "", appendedDf$stats_number_students))
appendedDf$stats_pc_intl_students = as.numeric(gsub("[\\%,]", "", appendedDf$stats_pc_intl_students))
colnames(appendedDf)[13] <- "international_students_percentage"

cols.num <- c("rank","scores_teaching","scores_research","scores_citations","scores_industry_income","scores_international_outlook","stats_student_staff_ratio")
appendedDf[cols.num] <- sapply(appendedDf[cols.num], as.numeric)

appendedDf$scores_teaching <- appendedDf$scores_teaching %>% replace_na(0)
appendedDf$scores_research <- appendedDf$scores_research %>% replace_na(0)
appendedDf$scores_citations <- appendedDf$scores_citations %>% replace_na(0)
appendedDf$scores_industry_income <- appendedDf$scores_industry_income %>% replace_na(0)
appendedDf$scores_international_outlook <- appendedDf$scores_international_outlook %>% replace_na(0)
appendedDf$stats_student_staff_ratio <- appendedDf$stats_student_staff_ratio %>% replace_na(0)
appendedDf$international_students_percentage <- appendedDf$international_students_percentage %>% replace_na(0)
appendedDf$stats_female_male_ratio <- appendedDf$stats_female_male_ratio %>% replace_na('none')

write.csv(appendedDf,"THE.csv")
