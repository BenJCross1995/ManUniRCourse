#----------------------------------------#
#-----MANCHESTER UNIVERSITY R COURSE-----#
#---------13/04/2023-14/04/2023----------#
#----------------------------------------#

# Course Notes - https://uomresearchit.github.io/r-tidyverse-intro/setup/
# Google Docs - https://docs.google.com/document/d/1nFisfUKHSrZeAkEKCVKBEhnhduB_cNzoZ65VBsGYqPQ/edit
setwd("C:/Users/bencros/Documents/GitHub/ManUniRCourse/")

#--------------------DAY 1--------------------#

#----------INTRODUCTION TO R AND RSTUDIO----------#
#----MATHEMATICAL FUNCTIONS----# ####

sin(1) # Trigonometry

log(1) # Logarithms

log(10) # Base-10 logarithm

exp(0.5) # Exponential function

#----COMPARISONS----# ####
1 == 1 # Equality

1 != 2 # Inequality

1 < 2 # Less than

1 <= 1 # Less than or equal to

1 >0 # Greater than

1 >= -9 # Greater than or equal to

#----VARIABLES----# ####

# Can create variable using <-
x <- 1/40
x

# Perform calculations on it
log(x)

# Change the value number
x <- 100
x

# Add variable to itself
x <- x + 1
x

# Can also assign characters
sentence <- "The cat sat on the mat"

# Ends in an error
sentence + 1



#----VECTORISATION----# ####

# Create vector
1:5

# Can perform operations
(1:5) * 2 
(1:5)^2
2^(1:5)

# Can assign it
x <- 5:10

y <- c(2, 4, -1)

# They can also be strings
c("a", "b", "c", "def")

# There are some built in constants
LETTERS
letters
month.abb
month.name

#----VECTOR LENGTHS----# ####

length(x)

length(letters)

#----SUBSETTING VECTORS----# ####

# Subset a single value
month.name[2]

#Subset more than 1
month.name[2:4]

month.name[c(2,3,4)]

# Subset element not in vector
month.name[10:13]

#----MISSING DATA----# ####
1 + NA

x <- NA
x == NA # Instead used in.na(x)

#----SKIPPING AND REMOVING VARIABLES

month.name[-2] # Remove Feb

month.name[c(-1, -5)]  # or month.name[-c(1,5)]

month.name[-(1:3)] # Remove first three months

#----SUBSETTING WITH LOGICAL VECTORS----# ####
fourmonths <- month.name[1:4] # First 4 months of year
fourmonths

# Remove Feb
fourmonths[c(TRUE, FALSE, TRUE, TRUE)]

fourmonths[c(TRUE, FALSE)] # If lengths dont match it recycles over smaller vec

# WE can do this in a numeric way too
my_vector <- c(0.01, 0.69, 0.51, 0.39)
my_vector > 0.5

my_vector[my_vector > 0.5] # To get values greater than 0.5






#----------LOADING DATA INTO R----------#

#----LOADING DATA----# ####

library(readr)

cats <- read_csv("data/feline-data.csv")

spec(cats) # More detailed column info

cats

# Specify data type
cats <- read_csv("data/feline-data.csv", col_types = cols(
  coat = col_character(),
  weight = col_double(),
  likes_string = col_logical()
) )

# New file same types
cats2 <- read_csv("data/feline-data_v2.csv", col_types = cols(
  coat = col_character(),
  weight = col_double(),
  likes_string = col_logical()
) )

#----EXPLORING TIBBLES----# ####

cats$weight # Access column

cats[1:2,2:3] # Return first two rows and last two columns

# Sub-setting with square brackets returns a tibble, using $
# returns a vector.

final_data <- cats[,c(1,3)]

write_csv(final_data, "data/final_data.csv")


#----------MANIPULATING TIBBLES WITH DPLYR----------#

#----LOAD DATA----# ####
library(tidyverse)

# Read gapminder data
gapminder <- read_csv("data/gapminder-FiveYearData.csv")

#----DPLYR PACKAGE----# ####

# Select()
year_country_gdp <- select(gapminder, year, country, 
                           gdpPercap)

# Filter()
gapminder_europe <- filter(gapminder,
                           continent == "Europe")

# Pipe Operator
gapminder_ar <- gapminder %>%
  filter(continent == "Europe") %>%
  select(year, country, gdpPercap)
