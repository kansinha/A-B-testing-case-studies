install.packages("readxl")   # run only once
library(readxl)

setwd("C:/Users/sinha/OneDrive - The University of Texas at Dallas/Desktop/BUAN 6392")
getwd()

# Load data
df <- read_xlsx("Random_check.xlsx")
colnames(df)

head(df)
str(df)

#Convert Vid and ProdCat to factor
df$Vid <- as.factor(df$Vid)
df$ProdCat <- as.factor(df$ProdCat)

#check group sizes
table(df$Vid)

#compare mean prices
aggregate(ProdPrice ~ Vid, data = df, mean)

#t-test
t.test(ProdPrice ~ Vid, data = df)

#create contingency table
table_cat <- table(df$Vid, df$ProdCat)
table_cat

#chi-square test
chisq.test(table_cat)

################    Data 2     ####################

df1 <- read_xlsx("FP_Analysis.xlsx")

colnames(df1)
head(df1)

#convert Vidwk to factor

df1$VidWk <- as.factor(df1$VidWk)

# Filter to only valid VidWk values (0 or 1)
df1 <- df1[df1$VidWk %in% c(0, 1), ]
df1

# Calculate mean sales for video-on weeks (VidWk = 1)
mean_vid_on <- mean(df1$Sales[df1$VidWk == 1], na.rm = TRUE)

# Calculate mean sales for video-off weeks (VidWk = 0)
mean_vid_off <- mean(df1$Sales[df1$VidWk == 0], na.rm = TRUE)

# Difference-in-Means estimate
DiM <- mean_vid_on - mean_vid_off

# Print results
cat("Mean sales (VidWk = 1):", round(mean_vid_on, 2), "\n")
cat("Mean sales (VidWk = 0):", round(mean_vid_off, 2), "\n")
cat("Difference-in-Means (DiM):", round(DiM, 2), "\n")

# Method 1: T-test to check statistical significance
t_test_result <- t.test(df1$Sales[df1$VidWk == 1],
                        df1$Sales[df1$VidWk == 0])

t_test_result

# method2: Regression-based estimate of video treatment effect

model <- lm(Sales ~ VidWk + PriceDiscWk + EmailWk + CatalogWk + HomePgWk + CatPgWk,
            data = df1)

# View full regression output
summary(model)

#-----------------------------------------------------------------
#Question 4: 

#load data

df2 <- read_xlsx("CP_Analysis.xlsx")
head(df2)
colnames(df2) <- trimws(colnames(df2))


# Regression with both focal product AND coordinating product promotions as controls
cp_model <- lm(CpSales ~ VidWk +
                 FpPriceDiscWk + FpEmailWk + FpCatalogWk + FpHomePgWk + FpCatPgWk +
                 CpPriceDiscWk + CpEmailWk + CpCatalogWk + CpHomePgWk + CpCatPgWk,
               data = df2)

summary(cp_model)

