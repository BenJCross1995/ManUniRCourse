#----------------------------------------#
#-----MANCHESTER UNIVERSITY R COURSE-----#
#---------13/04/2023-14/04/2023----------#
#----------------------------------------#

# Course Notes - https://uomresearchit.github.io/r-tidyverse-intro/setup/
# Google Docs - https://docs.google.com/document/d/1nFisfUKHSrZeAkEKCVKBEhnhduB_cNzoZ65VBsGYqPQ/edit
# Questions - https://pad.carpentries.org/2023-04-13-rit-online

setwd("C:/Users/bencros/Documents/GitHub/ManUniRCourse/")

#--------------------DAY 1--------------------#

#----------1 - INTRODUCTION TO R AND RSTUDIO----------#
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


#--------------3 - LOADING DATA INTO R---------------#
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



#--------4 - MANIPULATING TIBBLES WITH DPLYR---------#
#----LOAD DATA----# ####
library(tidyverse)

# Read gapminder data
gapminder <- read_csv("data/gapminder-FiveYearData.csv")

#----DPLYR PACKAGE----# ####

#----SELECT----# ####
year_country_gdp <- select(gapminder, year, country, 
                           gdpPercap)

#----FILTER----# ####
gapminder_europe <- filter(gapminder,
                           continent == "Europe")

#----PIPE OPERATOR----# ####
gapminder_ar <- gapminder %>%
  filter(continent == "Europe") %>%
  select(year, country, gdpPercap)

#----USING IN----# ####
gapminder %>%
  filter(country %in% c("Denmark", "Norway", "Sweden"))

#----ARRANGE----# ####
gapminder %>%
  filter(continent == "Europe", year == 2007) %>%
  arrange(desc(pop))

#----MUTATE----# ####
gapminder_gdp <- gapminder %>%
  mutate(gdp = gdpPercap * pop)

gapminder_log <- gapminder %>%
  mutate(logGdpPerCap = log(gdpPercap))

#----SUMMARISE----# ####
gapminder_le <- gapminder %>%
  filter(year == 2007) %>%
  summarise(meanlife = mean(lifeExp))

#----GROUP BY----# ####
gapminder_by_le <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(meanlife = mean(lifeExp)) %>%
  arrange(desc(meanlife))

#----N----# ####
gapminder %>%
  filter(year == 2002) %>%
  group_by(continent) %>%
  summarise(se_pop = sd(pop)/sqrt(n())) %>%
  arrange(desc(se_pop))

#----N VS COUNT----# ####
gapminder %>%
  filter(year == 2002) %>%
  group_by(continent) %>%
  summarise(n.obs = n())

gapminder %>%
  filter(year == 2002) %>%
  count(continent, sort = TRUE)

#----IF ELSE----# ####
gapminder %>%
  mutate(gdp = ifelse(lifeExp > 50, gdpPercap * pop, NA))

#----QUESTIONS----# ####

# Find the number of rows for Africa
gap_af <- gapminder %>%
  filter(continent == "Africa") %>%
  select(lifeExp, country, year)
nrow(gap_af)

# Rank by life expectancy in Europe in 2007 - lowest = 1
gapminder %>%
  filter(continent == "Europe" & year == 2007) %>%
  mutate(rank = rank(lifeExp)) %>%
  arrange(rank)

# Reverse so highest life expectancy is 1
gapminder %>%
  filter(continent == "Europe" & year == 2007) %>%
  mutate(rank = rank(desc(lifeExp))) %>%
  arrange(rank)
        
# Mean life expectancy 
gapminder %>%
  group_by(continent, year) %>%
  summarise(avg_life_exp = mean(lifeExp))
         

#-----5 - CREATING PUBLICATION-QUALITY GRAPHICS-----#
#----GGPLOT2----# ####
gapminder <- read_csv("data/gapminder-FiveYearData.csv")

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

#----COMBINING DPLYR AND GGPLOT2----# ####
gapminder %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

#----QUESTIONS----# ####
# Question 1
ggplot(data = gapminder, aes(x = year, y = lifeExp)) +
  geom_point()

# Question 2
ggplot(data = gapminder, aes(x = year, y = lifeExp)) +
  geom_point(aes(colour = continent))

# Question 3
gapminder %>%
  ggplot(aes(x = year,
             y = gdpPercap,
             colour = continent,
             group = country)) +
  geom_line()

gapminder %>%
  ggplot(aes(x = year, y = gdpPercap,
             colour = continent, group = country)) +
  geom_line() +
  facet_wrap(~continent, ncol = 1,
             scales = 'free')

# Question 4
gapminder %>%
  group_by(continent, year) %>%
  summarise(avg_gdp = mean(gdpPercap)) %>%
  ggplot(aes(x = year, y = avg_gdp, colour = continent)) +
  geom_line()

# Question 5
gapminder %>%
  ggplot(aes(x = year, y = log(gdpPercap), colour = continent,
             group = country)) +
  geom_line() +
  facet_wrap(~continent, ncol = 1, scales = 'free')

ggsave("plots/myplot.png")
