setwd("~/Machine Learning/Machine Learning A-Z Template Folder/Part 1 - Data Preprocessing")
df=read.csv('Data.csv')
#condition valueif true
df$Age=ifelse(is.na(df$Age),
              ave(df$Age,FUN = function(x)mean(x,na.rm = TRUE)),#asks r if nan exist
              df$Age)

df$Salary=ifelse(is.na(df$Salary),
              ave(df$Salary,FUN = function(x)mean(x,na.rm = TRUE)),#asks r if nan exist
              df$Salary)

df
#encoding categorical data
# using factor function will 
# transform categorical to numberic categories 
# but will see variable as factor 

df$Country=factor(df$Country,
                  levels = c('France','Spain','Germany'),
                  labels = c(1,2,3))
df$Purchased=factor(df$Purchased,
                  levels = c('No','Yes'),
                  labels = c(0,1))
#split into train and test dataset
#install.packages('caTools')
library(caTools)
# in python we used random_state = 0, here set seed 
set.seed(123)
#here we only use dependent variable
split=sample.split(df$Purchased,SplitRatio = 0.8) #here splitratio is for train set unlike  1-0.2
#it will return true if obs was chosen for training_set and False if for test_set
training_set=subset(df,split==TRUE)
test_set=subset(df,split==FALSE)
