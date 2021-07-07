###############
## Chapter 7 ##
###############

rm(list = ls())

## Reading the csv file 
marketing = read.csv(file = 'Marketing_Campaigns.csv')

## Quick comparisong of the promotions
boxplot(SalesInThousands ~ Promotion, data = marketing, ylab = 'Sales in Thousands ($)', xlab = 'Promotion')

## Selecting Promotion 1 and 2 sales
promotion_1 = marketing$SalesInThousands[which(marketing$Promotion == 1)]
promotion_2 = marketing$SalesInThousands[which(marketing$Promotion == 2)]

par(mfrow = c(2, 2))
hist(promotion_1, col = 'gray', main = 'Promotion 1 Sales Distribution', xlab = 'Sales'); box()
hist(promotion_2, col = 'gray', main = 'Promotion 2 Sales Distribution', xlab = 'Sales'); box()
qqnorm(promotion_1); qqline(promotion_1); grid()
qqnorm(promotion_2); qqline(promotion_2); grid()

## Comparing the sales of Promotions 1 and 2
t.test(promotion_1, promotion_2, alternative = 'greater', var.equal = F)

## Comparing the sales of Promotions 1 and 2
wilcox.test(promotion_1, promotion_2, alternative = 'greater')

## Creating the table of click data 
clicks = data.frame(Headline_A = c(14, 986), Headline_B = c(8, 992), Headline_C = c(12, 988))
rownames(clicks) = c('Click', 'No-Click')

chisq.test(clicks)
fisher.test(clicks)


## Creating the table of click data 
clicks = data.frame(Version_1 = c(10, 40), Version_2 = c(2, 48), Version_3 = c(4, 46))
rownames(clicks) = c('Click', 'No-Click')

chisq.test(clicks)
