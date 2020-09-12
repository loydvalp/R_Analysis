#### Module 15 Challenge.
### Part One: MPG Regression

library(tidyverse)
library(ggpubr)

## Read the MechaCar MPG  Dataset. A CSV file.
MechaCar_table <- read.csv(file='MechaCar_mpg.csv',check.names=F,stringsAsFactors = F)

# Rename var
MechaCar_table  <- MechaCar_table %>%
  rename(
    vehicle_length = "vehicle length",
    vehicle_weight = "vehicle weight",
    spoiler_angle = "spoiler angle",
    ground_clearance = "ground clearance"
  )
head(MechaCar_table)

# Generate multiple linear regression model

lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = MechaCar_table)

# Generate summary statistics

summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = MechaCar_table))

# plot the distribution curve
shapiro.test(MechaCar_table$vehicle_length)
#W = 0.93421, p-value = 0.008003

# vehicle length vs mpg
vl_length <- lm(mpg ~ vehicle_length,MechaCar_table)
vlen <- vl_length$coefficients['vehicle_length']*MechaCar_table$vehicle_length +
  + vl_length$coefficients['(Intercept)']
plt <- ggplot(MechaCar_table,aes(x=vehicle_length,y=mpg))
plt + geom_point()+geom_line(aes(y=vlen),color='red')

# ground clearance vs mpg
GC <- lm(mpg ~ ground_clearance,MechaCar_table)
GCy_value <- GC$coefficients['ground_clearance']*MechaCar_table$ground_clearance +
  + GC$coefficients['(Intercept)']
plt <- ggplot(MechaCar_table,aes(x=ground_clearance,y=mpg))
plt + geom_point()+geom_line(aes(y=GCy_value),color='red')

### Part Two: Suspension Coil Summary

##  Create a summary statistics table for the suspension coil's pounds-per-inch continuous variable.
##  Be sure to include the following metrics: Mean, Median, Variance, Standard deviation.

## Read the suspension_coil  Dataset. A CSV file.
SuspenCoil_table <- read.csv(file='Suspension_Coil.csv',check.names=F,stringsAsFactors = F)

# Visualizing PSI distribution using density plot
ggplot(SuspenCoil_table,aes(x=PSI)) + geom_density() #looks normal

# Shapiro test
shapiro.test(SuspenCoil_table$PSI)
# W = 0.85286, p-value = 6.011e-11

summary(SuspenCoil_table$PSI) # mean = 1500 and median = 1500
var(SuspenCoil_table$PSI) # variance = 76.23
sd(SuspenCoil_table$PSI) # standard deviation = 8.73

psi_summary <- SuspenCoil_table %>% group_by(Manufacturing_Lot) %>% summarize(Min_PSI=min(PSI), Mean_PSI=mean(PSI), Median_PSI=median(PSI), Max_PSI=max(PSI), Standard_Dev=sd(PSI), Variance=var(PSI))
psi_summary

### Part Three:  Suspension Coil T-Test

# Suspension Coil T-Test
t.test(x=SuspenCoil_table$PSI,mu=1500)