#First we do the data Preprocessing
df=read.csv('Salary_Data.csv')

# Checking if there is any missing value
is.na(df)

# Set the seed of R‘s random number generator, 
# which is useful for creating simulations or 
# random objects that can be reproduced.

set.seed(123)

# split dataset into training and test dataset
# sample.split(Y, SplitRatio = 2/3, group = NULL) Split data from vector Y into two sets in predefined 
# ratio while preserving relative ratios of different 
# labels in Y. 
# Used to split the data used during classification 
# into train and test subsets.
# (0<=splitratio<1)
# In R the split Ratio is for traing set

split=sample.split(df$Salary,SplitRatio = (2/3)) 

# subset() Return subsets of vectors, matrices or 
# data frames which meet conditions.
# For below it will return true if observation was 
# chosen for training_set and 
# False if for test_set

training_set=subset(df,split==TRUE)
test_set=subset(df,split==FALSE)

# Linear regression Model
regressor = lm(formula=Salary ~ YearsExperience,
               data = training_set)

#information about the regressor
summary(regressor)
# coefficient here shows the statistical significance 
# no * means thats there no statistical signifance whereas 
# *** means higher statistical significance 
# The lower the P value more significant your independent 
# variable is going to be 
# When P value is over 5% means that its less significant, 
# lower P value means highly significant

# Predicting the Test set results
y_pred = predict(regressor,new_data=test_set)

# Visualization
# install.packages("ggplot2")
library(ggplot2)

ggplot() +
  geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
             colour = 'red') +
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +
  ggtitle('Salary vs Experience (Training set)') +
  xlab('Years of experience') +
  ylab('Salary')

ggplot() +
  geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
             colour = 'red') +
  geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, newdata = training_set)),
            colour = 'blue') +
  ggtitle('Salary vs Experience (Test set)') +
  xlab('Years of experience') +
  ylab('Salary')