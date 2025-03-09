depression<-read.csv("depressdata.csv")# read dataset into the variable depression


# Plot 1: mosaic plot for Sleep Duration vs Depression: shows that people who sleep less are less likely to be depress
mosaicplot(depression$Sleep.Duration ~ depression$Depression,
           xlab = 'Sleep Duration',
           ylab = 'Depression', 
           main = "Mosaic Plot of Sleep Duration vs Depression",
           col = c("blue", "red"), 
           border = "black")

# Supporting analysis using table
sleep_dep_table <- table(depression$Sleep.Duration, depression$Depression)
print("\nSleep Duration vs Depression Distribution:")
print(sleep_dep_table)


#Plot 2: Plot Academic Pressure vs Financial Stress
plot(depression$Academic.Pressure, 
     depression$Financial.Stress,
     main = "Academic Pressure vs Financial Stress",
     xlab = "Academic Pressure Level",
     ylab = "Financial Stress Level",
     col = adjustcolor("blue", alpha.f = 0.3))
grid()

# Add trend line: this trend line allows us to understand the relationship between the two
abline(lm(Financial.Stress ~ Academic.Pressure, data = depression), 
       col = "red", 
       lwd = 2)



# Use subset to create high and low stress groups
# Categorizing students into high stress (>=4) and low stress (<=2) groups using subset
high_stress <- subset(depression, Financial.Stress >= 4)
low_stress <- subset(depression, Financial.Stress <= 2)

# Create a stress level factor
depression$stress_category[depression$Financial.Stress >= 4] <- "High_Stress"
depression$stress_category[depression$Financial.Stress <= 2] <- "Low_Stress"

# Use table to put the levels into a matrix
depression_counts <- table(depression$stress_category, depression$Depression)


#Plot 3: Create bar plot, shows that high financial stress students are more likely to be depressed
barplot(t(depression_counts[c("Low_Stress", "High_Stress"),]),
        beside = TRUE,
        col = c("blue", "red"),
        main = "Depression Cases by Financial Stress Level",
        xlab = "Stress Level",
        ylab = "Number of Students",
        legend.text = c("No Depression", "Depression"),
        args.legend = list(x = "topright"))
grid()


# Create a contingency table of Dietary Habits and Depression
diet_depression <- table(depression$Dietary.Habits, depression$Depression)

# Convert table to a matrix and manually reorder rows (moving "Others" to the last row)
diet_depression <- diet_depression[c("Healthy", "Moderate", "Unhealthy", "Others"), ]

#Plot 4: Create the bar plot, notice that students with an Unhealthy diet are more likely to be depressed compared to students who eats healthy.
barplot(t(diet_depression),
        beside = TRUE,
        col = c("blue", "red"),
        main = "Depression Cases by Dietary Habits",
        xlab = "Dietary Habits",
        ylab = "Number of Students",
        legend.text = c("No Depression", "Depression"),
        args.legend = list(x = "topright"))
grid()

# Plot 5: boxplot, to show the gpa of depressed students compared to non depressed students
boxplot(depression$CGPA ~ depression$Depression,
        main = "CGPA Distribution by Depression Status",
        xlab = "Depression",
        ylab = "CGPA",
        names = c("No Depression", "Depression"),
        col = c("blue", "red"),
        border = "black",
        ylim = c(5, 10))  # Set y-axis range to focus on meaningful CGPA range
grid()

# Add mean points, for the average gpa to find the difference in between those who have depression and those who don't
means <- tapply(depression$CGPA, depression$Depression, mean)
points(1:2, means, pch = 18, col = "black", cex = 3)
print(means)


# Calculate average CGPA for each sleep duration category
avg_cgpa_by_sleep <- tapply(depression$CGPA, depression$Sleep.Duration, mean)
print("\nAverage CGPA by Sleep Duration:")
print(avg_cgpa_by_sleep)


# Using table to see depression distribution by gender, shows that male are more likely to be depressed
gender_depression <- table(depression$Gender, depression$Depression)
print("Depression Cases by Gender:")
print(gender_depression)


#Using subset to look at high achievers GPA < 8.0 with depression by gender, this shows that high achieving males are more likely 
# to get depressed
high_achievers_dep <- subset(depression, CGPA >= 8.0 & Depression == 1)
high_achiever_gender <- table(high_achievers_dep$Gender)
print("High Achievers (CGPA >= 8.0) with Depression by Gender:")
print(high_achiever_gender)


