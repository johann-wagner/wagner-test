# showcase_join.R ---------------------------------------------------------

# Purpose: Convert JavaScript Code into R Code.


# HW JavaScript Code ---------------------------------------------------------

# const arr1 = { 'key1': 'value1', 'key2': 'value2' };
# const arr2 = { 'key1': 'newValue1', 'key3': 'newValue3' };
# 
# const totalArr = { arr1, arr2 };
# console.log(`totalArr: ${JSON.stringify(totalArr)}`);
# 
# // {"key1":"newValue1","key2":"value2","key3":"newValue3"};



# JW R Code ------------------------------------------------------------------

library(tidyverse)
library(jsonlite)

arr1 <- tibble(key = c('key1', 'key2'),
               value = c('value1', 'value2'))
arr2 <- tibble(key = c('key1', 'key3'),
               value = c('newValue1', 'newValue3'))

arr1 %>% 
  full_join(arr2,
            join_by(key)) %>% 
  mutate(
    value = case_when(!is.na(value.y) ~ value.y,
                      .default = value.x)
  )



# ChatGPT Incorrect R Code ------------------------------------------------

# Create two named lists
arr1 <- list(key1 = "value1", key2 = "value2")
arr2 <- list(key1 = "newValue1", key3 = "newValue3")

# Merge the two lists into a single list
mergedList <- c(arr1, arr2)

# Convert the merged list to a JSON string
jsonString <- toJSON(mergedList)

cat(jsonString)

# Create two named lists
arr1 <- list(key1 = 'value1', key2 = 'value2')
arr2 <- list(key1 = 'newValue1', key3 = 'newValue3')

# Create an empty named list to merge into
totalArr <- list()

# Merge the two lists into a single list
totalArr <- c(totalArr, arr1, arr2)

# Convert the merged list to a named list
totalArr <- as.list(totalArr)

# Convert the named list to a JSON string
jsonString <- toJSON(totalArr)

cat(jsonString)



# ChatGPT Correct R Code --------------------------------------------------

# Create two data frames
arr1 <- data.frame(key = c('key1', 'key2'), value = c('value1', 'value2'))
arr2 <- data.frame(key = c('key1', 'key3'), value = c('newValue1', 'newValue3'))

# Merge the two data frames and keep unique keys from both
totalArr <- bind_rows(arr2, arr1) %>%
  distinct(key, .keep_all = TRUE)

# Convert the result to a named list
totalArr_list <- as.list(setNames(totalArr$value, totalArr$key))

# Convert the named list to a JSON string
jsonString <- toJSON(totalArr_list)

cat(jsonString)
