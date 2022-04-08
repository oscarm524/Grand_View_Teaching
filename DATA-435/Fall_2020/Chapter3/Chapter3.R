####################
## Chapter 3 Code ##
####################

library(plyr)

## Reading data
marketing_CLV = read.csv(file = 'Marketing_Customer_Value_Analysis.csv')
head(marketing_CLV)

## Quick exploration of Response
table(marketing_CLV$Response)

## Here we create Engaged from Response
marketing_CLV$Engaged = ifelse(marketing_CLV$Response == 'No', 0, 1)
table(marketing_CLV$Engaged)

## Calculating engagement rate
prop.table(table(marketing_CLV$Engaged))

## Sales by channels
sales_by_channel = ddply(marketing_CLV, .(Sales.Channel), summarise, Not_Engaged = sum(Engaged == 0), Engaged = sum(Engaged))

## Total claim amounts by engagement (boxplots)
boxplot(Total.Claim.Amount ~ Engaged, data = marketing_CLV, xlab = 'Engaged', ylab = 'Total Claim Amount')

## Logistic Regression
logit_md = glm(Engaged ~ Customer.Lifetime.Value + Income +
                         Monthly.Premium.Auto + Months.Since.Last.Claim +
                         Months.Since.Policy.Inception + Number.of.Open.Complaints +
                         Number.of.Policies + Total.Claim.Amount, data = marketing_CLV, family = binomial(link = logit))

## Extracting model results
summary(logit_md)

## Encoding Gender
marketing_CLV$Gender = factor(marketing_CLV$Gender, levels = c('F', 'M'))

## Encoding Education
marketing_CLV$Education = factor(marketing_CLV$Education, levels = c('High School or Below', 'Bachelor', 'College', 'Master', 'Doctor'))

marketing_CLV$EducationFactorized = ifelse(marketing_CLV$Education == 'High School or Below', 0 ,
                                           ifelse(marketing_CLV$Education == 'Bachelor', 1, 
                                                  ifelse(marketing_CLV$Education == 'College', 2,
                                                         ifelse(marketing_CLV$Education == 'Master', 3, 4))))
## Enconding Gender
marketing_CLV$GenderFactorized = ifelse(marketing_CLV$Gender == 'F', 0, 1)

## Logistic Regression
logit_md = glm(Engaged ~ Gender + Education, data = marketing_CLV, family = binomial(link = logit))

## Extracting model results
summary(logit_md)

## Building the logistic regression model
logit_md = glm(Engaged ~ Customer.Lifetime.Value + Income +
                  Monthly.Premium.Auto + Months.Since.Last.Claim +
                  Months.Since.Policy.Inception + Number.of.Open.Complaints +
                  Number.of.Policies + Total.Claim.Amount + 
                  Gender + Education, data = marketing_CLV, family = binomial(link = logit))

## Extracting model results
summary(logit_md)
