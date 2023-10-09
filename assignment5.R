#Dependancies
library(tidyverse)
library(here)
library(ggplot2)

#Problem 2----
# Read the entire data file into memory using the readLines()-function. Use the
# URL direcly or read the data from the local file that is in the repository.
raw_file <- readLines(con = here("suites_dw_Table1.txt"))

# The next step is then to find out *which* line starts with "--", and pick out
# the first one.
L <- 
  (substr(x = raw_file, start = 1, stop = 2) == "--") %>% 
  which() %>% 
  min()

# Save the variable descriptions (i.e. the information in lines 1:(L-2)) in a
# text-file for future reference using the cat()-function.
cat(raw_file[1:(L-2)], sep = "\n", file = "categories.txt")

#Create dataframe of the text file.
df <- read_delim(here("suites_dw_Table1.txt"),col_names = TRUE, delim = "|", skip = L-2) 
df <- df[-1,]
#Save as Csv
write.csv(df,file ="test.csv", row.names = FALSE)

# Read the file back in as a normal csv-file.
galaxies <- read_csv("test.csv")

#Problem 3 ----

#Histogram of linear diameter of the galaxy in kpc
galaxies %>% 
  ggplot(aes(x =a_26)) +
  geom_histogram()

#Histogram of 
galaxies %>% 
  ggplot(aes(x =log_lk)) +
  geom_histogram()

galaxies %>% 
  ggplot(aes(x =log_lk, y=m_b)) +
  geom_point()

#Only the closest galaxies represented seems to have a solar mass less than 5
