#Introduction to R Workshop Script
#The Graduate Institute of International and Development Studies (IHEID), Geneva
#This is the R Script for the introduction to R workshop, organized by the Law Department
#Created by Chanya Punyakumpol, 2022

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

#construct a matrix from the vectors we have created earlier:
score_winter
score_spring

student_score <- c(score_winter, score_spring)
student_score
student_score_matrix <- matrix(student_score, byrow = F, nrow = 9) 
#byrow indicates whether you are filling the matrix by row first (T) or by column first (F), and nrow indicates the number of 9 for the matrix.

student_score
student_score_matrix

#naming rows and columns of the matrix: rownames() and colnames()
rownames(student_score_matrix) <- student_names
colnames(student_score_matrix) <- c("Winter", "Spring")
student_score_matrix

#summing elements in the matrix: rowSums() and colSums()
total_student_score <- rowSums(student_score_matrix)
total_student_score

total_score_bySemester <- colSums(student_score_matrix)
total_score_bySemester

#adding a row or a column to the matrix: cbind() and rbind()
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

#back to the original example: we assign values to the sex variable for all observations:
sex_vector <- c("M", "F", "M", "F", "M", "F", "M", "M", "F")
names(sex_vector) <- student_names
sex_vector
#However, this is still a vector with characters, not factor. To turn this into a factor, we use factor():
sex_vector_factor <- factor(sex_vector)
sex_vector_factor

#the previous example is a nominal categorical variable. What if we want to create a ordinal one?
winter_grade <- c("D", "C", "C", "C", "B", "B", "B", "B", "A")
spring_grade <- c("C", "D", "B", "B", "C", "C", "B", "A", "B")

#we add additional option into factor():
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
                         spring_grade_factor, sex_vector_factor)
student_df

#To inspect the data, we use: str() to check different data types contained in the data frame
str(student_df)

#and head() can show the first few observations:
head(student_df)

#selecting elemebts in the matrix:
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

#only interested in the score in spring semester, ordered by the grade:
student_df$score_spring[___]

#E. List:
#List is capable of storing many different types of variables and data structures under one name.
student_info <- list(winter_grade_factor, spring_grade_factor, student_df)
student_info

#name each item store in the list
names(student_info) <- c("winter_grade", "spring_grade", "student_df")
student_info

#call an item in the list:
student_info$student_df
student_info[[3]]

#IV. Install and Download R Packages
install.packages("tidyr")
library(tidyr)

#installing multiple packages at once:
install.packages(c("ggplot2", "dplyr"))

#RStudio also provides an easy interface to install and load R packages by 
#simply clicking on `install` button and type the name of the package you want to install. 
#To load the package, simply go to the `Packages` tab and check the box.

#Alternatively, you can also download the package from GitHub using 
#the `install_github()` function from the `devtools` package:
devtools::install_github("tidyverse/ggplot2")

#V. Reading Data into R
#A. From Base R
#First, download the file here: https://raw.githubusercontent.com/jfjelstul/IHEID-R-workshop/master/data/student_data.csv
#importing csv use read.csv():
student_url <- "https://raw.githubusercontent.com/jfjelstul/IHEID-R-workshop/master/data/student_data.csv"
student_df <- read.csv(student_url)
student_df

#examine the structure of the data frame: do you notice anything different 
#from the previous data frame we have constructed?
str(student_df)

#alternatively, you can also use read.table() with a separator "," for csv and "\t" for tab-delimited files:
read.table(student_url, header = T, sep = ",") #a .csv file is basically separated by ","

#we need to change grade and sex variables into factors:
student_df$winter_grade_factor <- factor(student_df$winter_grade_factor, order = T, levels = c("D", "C", "B", "A"))
str(student_df)
student_df

student_df$spring_grade_factor <- factor(student_df$spring_grade_factor, order = T, levels = c("D", "C", "B", "A"))
str(student_df)

student_df$sex_vector_factor <- factor(student_df$sex_vector_factor, order = F)
str(student_df)

#Alternatively, you can also pre-specify the data type in the read.table function:
student_df <- read.table(student_url, header = T, sep = ",", 
                         colClasses = c("character", "numeric", "numeric", "factor", "factor", "factor"))
str(student_df)

#However, if you want to specify the grades as ordinal, we still need to use factor() with order = T option.
student_df$winter_grade_factor <- ___
student_df$spring_grade_factor <- ___
str(student_df)
#B. From the `readr` package:
#First, load the library (install the package before if needed):
library(readr)

student_df_readr <- read_csv(student_url)
str(student_df_readr)
student_df_readr

#do you notice something we need to fix here?
#Again, the data we have displays different data types than what we would want. 
#There is a way to specify which data type for each variable with an option `col_types` 
#which is equivalent to `colClasses` in `read.table()` in base R.
#But, you will need to construct an object to specify the type of data:

of <- col_factor(levels = c("D", "C", "B", "A"), ordered = T) #for readr, it is possible to specify ordinal factors
cha <- col_character()
int <- col_integer()
fac <- col_factor(levels = c("F", "M"))
student_df_readr <- read_csv("student_data.csv", col_types = list(cha, int, int, of, of, fac))
str(student_df_readr)

#There is also an equivalent function to `read.table()` in the `readr` package: `read_delim()`
#which you can further customize in the case that the file has a different separator:
read_delim(student_url, delim = ",", col_types = list(cha, int, int, of, of, fac))

#C. read excel files from the `readxl` package:
#load the `readxl` package (install before if needed) 
#and download the excel files: https://github.com/jfjelstul/IHEID-R-workshop/blob/master/data/student_data.xlsx
library(readxl)

excel_sheets("student_data.xlsx") #show all worksheets

student_df_2021 <- read_excel("student_data.xlsx", sheet = 1)
student_df_2022 <- read_excel("student_data.xlsx", sheet = 2)

str(student_df_2021)
str(student_df_2022)

#Note that unlike the `readr` package, to specify the variables as factors 
#we will need to work on this after we import data from excel:
student_df_2021$winter_grade_factor <- factor(student_df_2021$winter_grade_factor, levels = c("D", "C", "B", "A"), ordered = T)
student_df_2021$spring_grade_factor <- factor(student_df_2021$spring_grade_factor, levels = c("D", "C", "B", "A"), ordered = T)
student_df_2021$sex_vector_factor <- factor(student_df_2021$sex_vector_factor, levels = c("F", "M"), ordered = F)

str(student_df_2021)

#D. Import data in RStudio: RStudio has a point-and-click option to import a data set

#VI.If-Else statements and for loops
#A. The If-Else Statement
if(student_df$winter_grade_factor[1] > "C"){ #the condition inside the parentheses test whether the student in row 1 has a grade greater than C
  print(student_df$name[1]) #if so, his or her name will be printed out here.
}

#notice that `print() was not executed in the previous lines of code.
#Let's try again:
if(student_df$winter_grade_factor[6] > "C"){ #similarly, this has a similar test for the student in row 6
  print(student_df$name[6])
}
#Now, because Erin (the student in row 6), as a grade greater than "C", the name is printed.

if(student_df$winter_grade_factor[1] > "C") {
  cat(student_df$name[1],": ", "Pass")
} else {
  cat(student_df$name[1],": ", "Fail")
}

#Let's try again with Erin
if(student_df$winter_grade_factor[6] > "C") {
  ___
} else {
  ___
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

#VII. Basic Functions
#A function is particularly useful when you will have to repeat similar lines of code often (which is often the case). 
#Functions are usually defined in the beginning of the coding script or in a separate R Script, named defined functions - 
#just to organize them separately.

#This is a basic syntax for a function
grade_check <- function(name, grade){ #name and grade here are the two arguments you need to put in when using this function
  if(grade > "C"){ #check if the grade is greater than C.
    ___
  } else {
    ___
  }
}

#now use the function we just created. The code is much more concise in this fashion.
for(i in 1:row_num){
  grade_check(student_df$name[i], student_df$winter_grade_factor[i])
}


