#
# Introduction to R, BIOL 309 - Fall 2023 

#
# Just a few of the many things you can do with R:
#   
# 1. Import your own data or data from the internet to analyze
# 
# 2. Make awesome graphs, charts, etc to display your findings
# 
# 3. Statistical analysis, from simple to complex
# 
# 4. Download R packages with specific functions relevant to your field of study 
#    and your data
# 
# 5. Impress future employers :D
# 
# 
# Don't panic! You can do a whole lot using free resources online, without even 
# writing any code yourself.
# 
# Today we will get R running on your computer using RStudio Cloud, although you
# can download the R and RStudio software to your computer if you prefer. 
# 
# We will start by working from the Command Line in the Console. See the handout 
# for what that looks like.
# 
# I'll guide you through some basic commands. If you type them in at the ">" 
# then R will do them.
# 
# Be sure to type them exactly the same way I type them. If things aren't 
# spelled or capitalized correctly, R has no idea what you are trying to get it 
# to do and spits out weird error messages. Don't worry, you can't hurt anything 
# on your computer in RStudio because we are working within the R program.
# 
# 
# ------------------------------------------------------------------------------
#
# R does have some jargon associated with it. I am trying to keep things simple, 
# but I might not catch everything that could be confusing. Also, information 
# you find online will likely use some of these words.	
# 
# For the purposes of this class, here are some definitions before we get too 
# far into the code:
# 
# 1. A script is another name for an R file (like this one) with code in it. 
# 
# 2. A function is a line or lines of code that perform a given task. 
# 
# 3. A package is a collection of functions used for related tasks, such as 
#    making graphs.
# 
# 4. I will refer to things you tell R to do as "commands". These may or may not 
#    be functions.
# 
# 5. Data can also be referred to as a dataset. When fed into R, it creates a 
#    dataframe.
# 
# Don't worry about memorizing these, but do reference this if you are confused!
#   
# ------------------------------------------------------------------------------
#   
# So, you can use the Command Line to tell R what to do, right?
#   
# The problem: you won't have your commands saved to use in the future. For 
# that you will need an R script, which is a file like this one. You can find 
# thousands of R scripts and code examples online for free, for basically any 
# analysis you might want to do!
# 
# If you look at the rest of this file, everything without the "#" at the 
# beginning of the line is a command or series of commands you can give R. R 
# ignores everything with "#" at the beginning (these are called comments). 
# You'll notice that most of this document is comments.
# 
# If you put your cursor on the next line and hit "Run", what happens?
#   
#  45 * 6
# 
# Now, delete the # in front of the line, and try again.
# It's the same thing we typed earlier in class, only it is saved in this 
# script, so you can multiply these two numbers as many times as you want, even 
# years from now!
# 

# R has many builtin datasets. Type "data()" in the console to see a list. We
# will use a few of them, but feel free to explore!

# Let's look at some other functions in R.
# (Don't worry about the code itself, just keep hitting "Run" line by line).

# We can make very basic plots without loading any packages at all. 
# (Although most publication-quality figures will be made using a package)

data("co2")

co2

plot(co2)

data("rivers")

# A histogram shows the number of observations in each "bin" on the x-axis

hist(rivers, main="Length of US Rivers", xlab="length (miles)", col="cornflowerblue")

# Are there more short or long rivers?

# The height of the bar is the frequency of that bin.
# Taller bar = higher frequency

# So we would say short rivers occur at a higher frequency than long rivers

# You can change "cornflowerblue" to any builtin R color name (list on Moodle)
# Or change it to a hexidecimal code (often used in HTML) with a "#" in front 
#  (Google "color hex codes")

# Be sure to put it in quotes, as shown above (replace only the highlighted part)

hist(islands, main="Area of major landmasses on Earth", xlab="area (sq mi)", col="darkviolet")

hist(precip, main="Annual Precipitation in Major US Cities ", xlab="rainfall (inches)", col="#66CC33")

# If you've formatted it correctly, RStudio will highlight your text in that color!


# ------------------------------------------------------------------------------
#   
# To do most cool things in R, you will need to be familiar with installing and 
# loading R packages.
# (Don't worry, you can do it from the menu without writing any code!) 
# 
# As we saw earlier, packages let you do specific things, like create certain 
# types of graphs or make a phylogenetic tree. But imagine if you loaded all the 
# possible functions into R at the same time - your computer would run really 
# slowly or crash! Packages let you load just what you need, when you need it.
# 
# Take a look at this line of code:
# 
library(tidyverse)
# 
# You will often see the "library" function at the beginning of scripts. It is 
# used to load packages. But it doesn't work if you hit "Run" - why?
# 
# Before you can load a package, you need to download it. You can do this from 
# the menu in RStudio, as shown in your guide. Following those instructions, 
# download the package in parentheses ("tidyverse")
# 
# Now you can go back to the library function. 
# Put your cursor on that line and hit Run, and you're good to go!
#     
# The storms dataset is builtin to tidyverse. Let's preview it:

data("storms")     
head(storms) 

# Again, don't worry about the code itself. We just want to see some things we
# can do with R.

# combine year, month, and day columns to create "date"
storms$date <- as.Date(paste(storms$year, storms$month, storms$day, sep = "-"), "%Y-%m-%d")

# create a column of dates converted to week numbers (out of 52 in a year)
storms$week_num <- strftime(storms$date, format="%V")

# create a column of number of storms per week
storms <- storms %>% group_by(week_num) %>% summarize(weekly_storms = n_distinct(name))

# plot the number of storms per week
ggplot(data=storms, aes(x=week_num, y=weekly_storms)) +
  geom_bar(stat="identity") +
  ggtitle("Total Number of Atlantic Storms per Week (1975-2021)") +
  xlab("Week of the Year") +
  ylab("Number of Storms")

# "ggplot2" is the most commonly used package for creating graphs in R because 
# of its versatility 
# It is part of the tidyverse collection that we loaded.

# You will see the function "ggplot" come up again and again throughout this 
# course. We will learn more about its structure in a future class!

# Now, we can clean out everything we've loaded into R to free up some RAM
# We can do this by hitting the broom button on the Environment pane

# You will then want to re-load the tidyverse package using the library function:
library(tidyverse)

# We can also load in data straight from a URL.

titanic <- read_delim(file=url("https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv"), delim=",")


ggplot(data=titanic, aes(x=Age)) + 
  geom_histogram(aes(fill=as.factor(Survived))) +
  ggtitle("Age distribution onboard the Titanic") + 
  scale_fill_discrete(name="Survived?", labels=c("no", "yes"))

# -----------------------------------------------------------------------------

# R also has some useful but slightly silly packages.

# What if we wanted R to make a noise when a function is complete? This can be 
# useful for functions that take a long time, so you can do other things while
# they run.

library(beepr)

# This requires a new library. How do we load it into R?
#
# First, you will need to download and install the packages in parentheses, as 
# shown in the R guide.
#   
# Next, put the cursor on the library command and hit Run  - 
# now you're ready to use beepr!

# Let's try it out with data on island fauna:

colnames <- c("island", "area","elevation","num_soil_types", "latitude", "dist_from_mainland", "num_species")

island_fauna <- read.table(file=url("https://users.stat.ufl.edu/~winner/data/britain_species.dat"), col.names=colnames, nrows=25)

ggplot(data=island_fauna, aes(x=elevation, y=num_species)) +
  geom_point(); beep(3)

ggplot(data=island_fauna, aes(x=latitude, y=num_species)) +
  geom_point(); beep(8)

ggplot(data=island_fauna, aes(x=dist_from_mainland, y=num_species)) +
  geom_point(); beep(5)

# The more you run R code, the more familiar it will become, so keep practicing!
# There is lots of documentation online, but there's no one right way to start 
# off in data analysis and programming in R. 

# If you're interested, I've put some links to online R tutorials on Moodle.
# The more you use R, the more intuitive it will get!

#   ----------------------------------------------------------------------------------------------------------



# created and compiled by Sarah Bolinger