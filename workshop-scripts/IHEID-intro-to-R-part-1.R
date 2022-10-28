#Introduction to R Workshop Script
#The Graduate Institute of International and Development Studies (IHEID), Geneva
#This is the R Script for the introduction to R workshop, organized by the Law Department
#Created by Chanya Punyakumpol, 2022
#you can check out all code and output on: https://rpubs.com/chanyap/intro_R

#I. Basic of RStudio: first download both R and RStudio to your computer.
# what's the difference between R and RStudio? 
# Interesting features of RStudio:
#- Console
#- Workspace and History
#- Files, Plots, Packages, and Help
#- R Script and Data View

#Let's start a new project!

#II. Basic R Operations and Different Data Types
#A. Basic arithmetic
2+3
4*5-8
(6/3)+5
2^3
5%%2
#try your own arithmetic operations!

#B. variable assignment
x <- 70 #notice the addition of x on the environment window on your right.
x

y <- 50
y

x+y

z <- x+y #combine with the arithmetic operator

z

w <- x-y 

# what is the value of w?
w

x <- x*2
#what is the value of x?
x

#C. Different Data Types:
numeric_var <- 34.5
char_var <- "R Workshop"
logical_var <- TRUE

#A useful Function: class() -- to check the type of variable assigned
class(numeric_var)
class(char_var)
class(logical_var)

#for a character variable, it should be noted that R is case-sensitive:
char_var2 <- "r workshop"
char_var2 == char_var

#III. Working with Various Data Structure
#A. Vector: A vector can store one type of data with a dimension n x 1, using the function `c()`
score_winter <- c(3, 4, 4, 4, 5, 5, 5, 5, 6)

#let's check what a vector looks like:
score_winter

#it can also store different types of variable:
student_names <- c("Steve", "Carol", "Sam", "Maddie", "Aaron", "Erin", "Ian", "Kyle", "Lucy")
student_names

#it can, however, only hold one type of variable:
test_vector <- c("Steve", 1)
class(test_vector) #1 is coerced into a character type.

#naming vector elements: names()
names(score_winter) <- student_names
score_winter

#performing arithmetic on vectors:
score_spring <- c(4, 3, 5, 5, 3, 3, 5, 6, 5)
names(score_spring) <- student_names

total_score <- ___ + ___ #calcuate the total scores for winter and spring
total_score

#using sum() to add up all elements:
sum_all_score <- sum(total_score)
average_score <- sum_all_score/9
average_score

#selecting elements in a vector: there are different ways to do so
total_score[1]
total_score[c(2,5,7)]
total_score[c("Ian", "Kyle")]
total_score[3:9]

#select by condition
selection <- score_winter > 4
score_winter[selection]

#B. Matrix
#try this first:
?matrix #? is useful to check R Documentation of a function you want to learn more about

#create a matrix of different dimensions:
matrix(1:16, nrow = 4, ncol = 4)
matrix(1:16, nrow = 2, ncol = 8)
matrix(1:16, nrow = 8, ncol = 2)

#construct a matrix from the vectors we have created earlier: cbind() and rbind()
score_winter
score_spring

student_score_byCol <- cbind(score_winter, score_spring)
student_score_byRow <- rbind(score_winter, score_spring)

student_score_matrix <- student_score_byCol

#naming rows and columns of the matrix: rownames() and colnames()
rownames(student_score_matrix) <- student_names
colnames(student_score_matrix) <- c("Winter", "Spring")
student_score_matrix

#summing elements in the matrix: rowSums() and colSums()
total_student_score <- rowSums(student_score_matrix)
total_student_score

total_score_bySemester <- colSums(student_score_matrix)
total_score_bySemester

#adding a row or a column to the matrix:
all_score_matrix <- cbind(student_score_matrix, total_student_score)
all_score_matrix

#selecting elements in the matrix:
all_score_matrix[4,3]

#select all elements in a specific row or column
all_score_matrix[7,]
all_score_matrix[,1]

#subset of a matrix
all_score_matrix[3:5,]
all_score_matrix[,1:2]

#C. Factor
#Create a factor: factor()

#back to the original example: we assign grades to all observations based on their scores
winter_grade <- c("D", "C", "C", "C", "B", "B", "B", "B", "A")
spring_grade <- c("C", "D", "B", "B", "C", "C", "B", "A", "B")

#creating a factor
winter_grade_factor <- factor(winter_grade)
winter_grade_factor <- factor(winter_grade, order = T, levels = c("D", "C", "B", "A"))
spring_grade_factor <- factor(spring_grade, ___, ___) #set the ordinal factors for spring_grade_factor

winter_grade_factor
spring_grade_factor

#Use summary() to quickly look at the factor variable:
summary(winter_grade_factor)
summary(spring_grade_factor)

#D. Data Frame:
#A data frame can keep various variables of different types as columns and each observation as a row
#To create a data frame, use data.frame():
student_df <- data.frame(score_winter, score_spring, winter_grade_factor, 
                         spring_grade_factor)
student_df

#To inspect the data, we use: str() to check different data types contained in the data frame
str(student_df)

#and head() can show the first few observations:
head(student_df)

#selecting elements in the matrix:
student_df[3,4]
student_df[3,] #select one observation with all variables (selecting a row)
student_df[,3] #select one variable with all observations (selecting a column)

#Alternatively, if you know the variable name: $
student_df$winter_grade_factor
student_df$winter_grade_factor[3]

#Another way to do this is using the function subset():
?subset

#selecting students with grades greater than C in the winter semester
subset(student_df, winter_grade_factor > "C")
#selecting students with grades equal to B in the spring semester
subset(student_df, ___) 

#Reorder observations by decreasing or increasing values: order()
order(student_df$spring_grade_factor)
student_df[order(student_df$spring_grade_factor),]

#reverse the order:
student_df[order(student_df$spring_grade_factor, decreasing = T), ]


#IV. Install and Download R Packages
install.packages("tidyr")
library(tidyr)

#installing multiple packages at once:
install.packages(c("ggplot2", "dplyr"))

#RStudio also provides an easy interface to install and load R packages by 
#simply clicking on `install` button and type the name of the package you want to install. 
#To load the package, simply go to the `Packages` tab and check the box.

#V. Reading Data into R
#A. From Base R
#importing csv use read.csv():
student_url <- "https://raw.githubusercontent.com/jfjelstul/IHEID-R-workshop/master/data/student_data.csv"
student_df <- read.csv(student_url)
student_df

#examine the structure of the data frame: str()
str(student_df)

#alternatively, you can also use read.table() with a separator "," for csv and "\t" for tab-delimited files:
read.table(student_url, header = T, sep = ",") #a .csv file is basically separated by ","

#we need to change grade into factors:
student_df$winter_grade_factor <- factor(student_df$winter_grade_factor, order = T, levels = c("D", "C", "B", "A"))
str(student_df)
student_df

student_df$spring_grade_factor <- factor(student_df$spring_grade_factor, order = T, levels = c("D", "C", "B", "A"))
str(student_df)


#B. From the `readr` package:
#First, load the library (install the package before if needed):
library(readr)

student_df_readr <- read_csv(student_url)
str(student_df_readr)
student_df_readr

#still need to deal with factor variables
student_df_readr$winter_grade_factor <- factor(student_df$winter_grade_factor, order = T, levels = c("D", "C", "B", "A"))
student_df_readr$spring_grade_factor <- factor(student_df$spring_grade_factor, order = T, levels = c("D", "C", "B", "A"))


#D. Import data in RStudio: RStudio has a point-and-click option to import a data set

#VI.If-Else statements and for loops
#try this logical test: what does it tell you?
student_df$winter_grade_factor > "C"

#A. The If-Else Statement
if(student_df$winter_grade_factor[1] > "C"){ #the condition inside the parentheses test whether the student in row 1 has a grade greater than C
  print(student_df$name[1]) #if so, his or her name will be printed out here.
}

#notice that `print() was not executed in the previous lines of code.
#Let's try again:
if(student_df$winter_grade_factor[6] > "C"){ #similarly, this has a similar test for the student in row 6
  print(student_df$name[6])
} #Now, because Erin (the student in row 6), as a grade greater than "C", the name is printed.

student_df$winter_grade_factor > "C"

if(student_df$winter_grade_factor[1] > "C") {
  cat(student_df$name[1],": ", "Pass")
} else {
  cat(student_df$name[1],": ", "Fail")
}

#B. 
row_num <- nrow(student_df) #get the number of row, i.e the number of observations in the data set
#check the number of rows we have:
row_num

#put in the for-loop:
for(i in 1:row_num){
  if(student_df$winter_grade_factor[i] > "C") {
    cat(student_df$name[i], ": ", "Pass","\n")
  } else {
    cat(student_df$name[i], ": ", "Fail", "\n") 
  }
}



