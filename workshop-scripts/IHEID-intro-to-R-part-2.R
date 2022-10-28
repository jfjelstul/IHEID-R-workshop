# European Society of International Law (ESIL)
# Geneva Graduate Institute
# Social Science Methods for Legal Scholars
# Intro to R
# Joshua C. Fjelstul, Ph.D.

# Load the tidyverse package
library(tidyverse)

# Load EU infringement data ----------------------------------------------------

# We're going to use data on EU infringement cases from the European Union
# Infringements Procedure (EUIP) Database. This database has an R package that
# we can install from GitHub
devtools::install_github("jfjelstul/euip")

# Extract the decisions table from the `euip` package
decisions <- euip::decisions

# The unit of observation is a decision in an Commission infringement case

# This is an example of a "tidy" dataset:
# 1) Each variable has its own column
# 2) Each observation has its own row
# 3) Each value has its own cell

# All tools from the `tidyverse` are designed for "tidy" data

# About the EU infringement procedure ------------------------------------------

# You always want to start by making sure you understand the structure of your
# data and how to interpret it substantively

# The EU infringement procedure is a legal procedure by which the European
# Commission can bring a legal case against an EU member state for violating EU
# law. It is a pre-trial bargaining procedure, but the Commission can refer
# cases to the Court of Justice of the European Union (CJEU)

# There are 6 possible stages:
# 1. Letter of formal notice (Article 258 TFEU) = notice of a possible infringement
# 2. Reasoned opinion (Article 258 TFEU) = Commission lays out legal case
# 3. Referral to the Court (Article 258 TFEU) = Commission asks the Court to establish a violation
# 4. Letter of formal notice (Article 260 TFEU) = notice of possible noncompliance with a CJEU ruling
# 5. Reasoned opinion (Article 260 TFEU) = Commission lays out legal case
# 6. Referral to the Court (Article 260 TFEU) = Commission asks the Court to impose a fine

# The Commission can close a case or withdraw a decision at any time for any
# reason. Infringement cases are managed by Directorates-General (DGs) of the
# Commission, which are organized by policy area

# Pipes ------------------------------------------------------------------------

# Pipes are a programming technique that converts nested code to linear code.
# This makes your code a lot easier to read

# Let's make a short vector of random numbers between 0 and 10
set.seed(12345)
random_numbers <- runif(n = 10, min = 1, max = 10)

# Suppose we want to find the median integer. There are 4 basic ways of doing
# this in R

# Option 1: create a new object each time
# This quickly clutters up your R environment and the names aren't meaningful
x_1 <- round(random_numbers)
x_2 <- median(x_1)

# Option 2: overwrite the object
# This way, you have to rerun the code from the beginning
x <- round(random_numbers)
x <- median(x)

# Option 3: nest the functions
# Here, you have to think from the inside out
x <- median(round(random_numbers))
x <- median(
  round(random_numbers)
)

# Option 4: use a pipe
# This way, you can think linearly
x <- random_numbers |>
  round() |>
  median()

# Pipes are really useful when you need to do a lot of operations in sequence on
# the same dataset, like renaming variables, then selecting variables, then
# selecting observations, then grouping observations, then collapsing
# observations. But pipes usually aren't a good solution when the functions you
# need to use have multiple inputs or outputs

# Clean environment
rm(random_numbers, x, x_1, x_2)

# Sorting data ------------------------------------------------------------

# Example 1: sort data by date (ascending order)
decisions <- decisions |>
  arrange(decision_date)

# Example 2: sort data by date (descending order)
decisions <- decisions |>
  arrange(desc(decision_date))

# Example 3: sort data by member state, then date (ascending order)
decisions <- decisions |>
  arrange(member_state_id, decision_date)

# Example 4: sort data by member state, then date (descending order)
decisions <- decisions |>
  arrange(member_state_id, desc(decision_date))

# Example 5: sort by key_id
decisions <- decisions |>
  arrange(key_id)

# Filtering data ---------------------------------------------------------------

# Example 1: get ROs
# Example of the `==` operator
example <- decisions |>
  filter(stage_ro_258 == 1)

# Example 2: get decisions with a press release
# Example of the `!=` operator
example <- decisions |>
  filter(press_release == 1)
example <- decisions |>
  filter(press_release != 0)

# Example 3: get LFNs and ROs
# Example of the `|` operator
example <- decisions |>
  filter(stage_lfn_258 == 1 | stage_ro_258 == 1)

# Example 4: get ROs with a press release
# Example of the `&` operator
example <- decisions |>
  filter(stage_ro_258 == 1 & press_release == 1)

# Example 5: get LFNs and ROs with a press release
# Example of a compound logical condition
example <- decisions |>
  filter((stage_lfn_258 == 1 | stage_ro_258 == 1) & press_release == 1)

# Example 6: keep first round decisions
# Example of the `%in%` operator
example <- decisions |>
  filter(decision_stage %in% c(
    "Letter of formal notice (Article 258)",
    "Reasoned opinion (Article 258)",
    "Referral to the Court (Article 258)"
  ))
table(example$decision_stage)

# Example 7: drop closing and withdrawal
# Example of the `!` operator
example <- decisions |>
  filter(
    !(decision_stage %in% c("Closing", "Withdrawal"))
  )
table(example$decision_stage)

# Renaming variables -----------------------------------------------------------

# Rename the reasoned opinions variable
example <- decisions |>
  rename(reasoned_opinion = stage_ro_258)

# Check variable names
names(example)

# Rename multiple variables
example <- decisions |>
  rename(
    formal_notice = stage_lfn_258,
    reasoned_opinion = stage_ro_258,
    referral = stage_rf_258
  )

# Check variable names
names(example)

# Selecting variables ----------------------------------------------------------

# Example 1
# Select a subset of variables
example <- decisions |>
  select(decision_id, member_state, decision_stage)

# Example 2
# Code formatting for selecting a larger number of variables
example <- decisions |>
  select(
    decision_id, case_id,
    member_state_id, member_state, member_state_code,
    decision_stage_id, decision_stage
  )

# Example 3
# Get the member state and DG for reasoned opinions
example <- filter(decisions, stage_ro_258 == 1)
example <- select(
  example,
  decision_id,
  department_id, department,
  member_state_id, member_state, member_state_code
)

# Example 4
# Get the member state and DG for reasoned opinions (using a pipe)
example <- decisions |>
  filter(stage_ro_258 == 1) |>
  select(
    decision_id,
    department_id, department,
    member_state_id, member_state, member_state_code
  )

# Example 5
# Get the member state and DG for reasoned opinions in non-communication cases
example <- decisions |>
  filter(stage_ro_258 == 1 & noncommunication == 1) |>
  select(
    decision_id,
    department_id, department,
    member_state_id, member_state, member_state_code
  )

# Modifying data ---------------------------------------------------------------

# The standard way to modify variables is using the `$` notation
example <- decisions
example$reasoned_opinion <- as.numeric(example$decision_stage == "Reasoned opinion (Article 258)")
table(example$reasoned_opinion)

# The `tidyverse` approach is to use `mutate()` from `dplyr`
# `mutate()` lets us create a new variable in a pipe
example <- decisions |>
  mutate(
    reasoned_opinion = as.numeric(example$decision_stage == "Reasoned opinion (Article 258)")
  ) |>
  arrange(decision_date)
table(example$reasoned_opinion)

# We can use indexing to make categorical variables
example$stage_short <- "missing"
example$stage_short[example$decision_stage == "Letter of formal notice (Article 258)"] <- "LFN 258"
example$stage_short[example$decision_stage == "Reasoned opinion (Article 258)"] <- "RO 258"
example$stage_short[example$decision_stage == "Referral to the Court (Article 258)"] <- "RF 258"
example$stage_short[example$decision_stage == "Letter of formal notice (Article 260)"] <- "LFN 260"
example$stage_short[example$decision_stage == "Reasoned opinion (Article 260)"] <- "RO 260"
example$stage_short[example$decision_stage == "Referral to the Court (Article 260)"] <- "RF 260"
example$stage_short[example$decision_stage == "Closing"] <- "C"
example$stage_short[example$decision_stage == "Withdrawal"] <- "W"
table(example$stage_short)

# We also can use `mutate()` in combination with `case_when()`
example <- decisions |>
  mutate(
    stage_short = case_when(
      decision_stage == "Letter of formal notice (Article 258)" ~ "LFN 258",
      decision_stage == "Letter of formal notice (Article 258)" ~ "LFN 258",
      decision_stage == "Reasoned opinion (Article 258)" ~ "RO 258",
      decision_stage == "Referral to the Court (Article 258)" ~ "RF 258",
      decision_stage == "Letter of formal notice (Article 260)" ~ "LFN 260",
      decision_stage == "Reasoned opinion (Article 260)" ~ "RO 260",
      decision_stage == "Referral to the Court (Article 260)" ~"RF 260",
      decision_stage == "Closing" ~ "C",
      decision_stage == "Withdrawal" ~ "W"
    )
  )
table(example$stage_short)

# You can also specify a catch-all category by setting the condition to `TRUE`
example <- decisions |>
  mutate(
    stage_short = case_when(
      decision_stage == "Letter of formal notice (Article 258)" ~ "LFN 258",
      decision_stage == "Letter of formal notice (Article 258)" ~ "LFN 258",
      decision_stage == "Reasoned opinion (Article 258)" ~ "RO 258",
      decision_stage == "Referral to the Court (Article 258)" ~ "RF 258",
      decision_stage == "Letter of formal notice (Article 260)" ~ "LFN 260",
      decision_stage == "Reasoned opinion (Article 260)" ~ "RO 260",
      decision_stage == "Referral to the Court (Article 260)" ~"RF 260",
      TRUE ~ "other"
    )
  ) |>
  filter(stage_short != "other")
table(example$stage_short)

# Grouping data ----------------------------------------------------------------

# We can group the data by year and member state to create panel data

# Example 1: reasoned opinions per member state per year
example <- decisions |>
  filter(stage_lfn_258 == 1) |>
  group_by(decision_year, member_state) |>
  summarize(
    count = n()
  )

# Example 2: reasoned opinions per member state per year
example <- decisions |>
  filter(stage_lfn_258 == 1) |>
  group_by(decision_year, member_state) |>
  count()

# Example 3: list of case IDs for referrals by member state and year
example <- decisions |>
  filter(stage_rf_258 == 1) |>
  group_by(decision_year, member_state) |>
  summarize(
    case_ids = str_c(case_id, collapse = ", ")
  )

# Example 4: list of all decisions in each case
example <- decisions |>
  filter(stage_additional == 0) |>
  arrange(decision_date) |>
  group_by(case_id) |>
  summarize(
    history = str_c(decision_stage, collapse = ", ")
  )

# Example 5: grouping using `mutate()` instead of `summarize()`
# When you use `mutate()` remember to also use `ungroup()`
example <- decisions |>
  group_by(case_id) |>
  mutate(
    group_id = cur_group_id(), # a unique ID number for each group
    within_group_id = 1:n() # a counter within each group
  ) |>
  ungroup() |>
  arrange(group_id, within_group_id)

# Putting it all together ------------------------------------------------------

# Create a variable that records the history of UK internal market cases
# Example: "LFN 258 (2016-01-27), RO 258 (2016-07-22), Closing (2017-02-15)"
example <- decisions |>
  filter(stage_additional == 0) |>
  filter(
    department %in% c(
      "Directorate-General for Internal Market and Services",
      "Directorate-General for Internal Market, Industry, Entrepreneurship and SMEs"
    )
  ) |>
  filter(str_detect(case_id, "UK")) |>
  arrange(decision_date) |>
  mutate(
    stage = case_when(
      decision_stage == "Letter of formal notice (Article 258)" ~ "LFN 258",
      decision_stage == "Reasoned opinion (Article 258)" ~ "RO 258",
      decision_stage == "Referral to the Court (Article 258)" ~ "RF 258",
      decision_stage == "Letter of formal notice (Article 260)" ~ "LFN 260",
      decision_stage == "Reasoned opinion (Article 260)" ~ "RO 608",
      decision_stage == "Referral to the Court (Article 260)" ~ "RF 260",
      TRUE ~ decision_stage
    ),
    stage_date = str_c(stage, " (", decision_date, ")")
  ) |>
  group_by(case_id) |>
  summarize(
    stages = n(),
    history = str_c(stage_date, collapse = ", ")
  ) |>
  arrange(desc(stages), desc(case_id))

# Clean environment
rm(example)

# Merging data -----------------------------------------------------------------

# We'll start by making a few tibbles we can merge together

# Make a list of all cases since 2010
cases <- decisions |>
  filter(case_year >= 2010) |>
  group_by(
    case_id, case_year, case_number,
    department, member_state
  ) |>
  summarize() |>
  ungroup()

# Make a list of all letters
letters <- decisions |>
  filter(stage_lfn_258 == 1) |>
  select(case_id, decision_id, decision_date)

# Make a list of all opinions
opinions <- decisions |>
  filter(stage_ro_258 == 1) |>
  select(case_id, decision_id, decision_date)

# Example 1: stack tables vertically
example <- bind_rows(letters, opinions)

# There is also a `bind_cols()` function, but this is rarely useful because the
# two tibbles have to have the same number of observations and they have to be
# in the same order. You almost always want to merge based on one or more
# uniquely identifying variables

# There are several options for merging tibbles, but `left_join()` is by far the
# most common

# Example 2: left join (all rows in x)
example <- left_join(cases, opinions, by = "case_id")

# Note that the number of observations increased because there can be multiple
# reasoned opinions per case. Always check the number of observations before and
# after merging to make sure it's what you expect

# There is also `right_join()`, `inner_join()`, and `full_join()` but the use
# cases for these functions are very specific. `left_join()` is almost always
# what you want

# Clean environment
rm(cases, letters, opinions, example)

# Reshaping data ---------------------------------------------------------------

# Again, we'll start by making a few tibbles to work with

# The decisions in each case
cases <- decisions |>
  group_by(case_id) |>
  summarize(
    list_decisions = str_c(decision_stage, collapse = ", ")
  )

# The number of decisions per member state in 2018
# This tibble is already in a long format
frequencies_long <- decisions |>
  filter(str_detect(decision_stage, "258|260")) |>
  filter(decision_year == 2018) |>
  group_by(member_state, decision_stage) |>
  summarize(
    count = n()
  )

# Example 1: expanding data
# Sometimes you have multiple values stored as a string in a
# column of a tibble separated by a comma (or similar) and you want to separate
# these values out into separate observations
# `separate_rows()` lets you expand the number of observations
decisions_new <- cases |>
  separate_rows(
    list_decisions,
    sep = ","
  ) |>
  rename(
    decision_stage = list_decisions
  ) |>
  mutate(
    decision_stage = str_squish(decision_stage)
  )

# Example 2: long to wide
# `pivot_wider()` lets you convert long data to wide data
frequencies_wide <- frequencies_long |>
  mutate(
    var_name = case_when(
      decision_stage == "Letter of formal notice (Article 258)" ~ "lfn_258",
      decision_stage == "Reasoned opinion (Article 258)" ~ "ro_258",
      decision_stage == "Referral to the Court (Article 258)" ~ "rf_258",
      decision_stage == "Letter of formal notice (Article 260)" ~ "lfn_260",
      decision_stage == "Reasoned opinion (Article 260)" ~ "ro_260",
      decision_stage == "Referral to the Court (Article 260)" ~ "rf_260"
    )
  ) |>
  pivot_wider(
    id_cols = member_state,
    names_from = var_name,
    values_from = count,
    values_fill = 0
  )

# Example 3: long to wide with factors
# The same thing but including a column for every factor level
frequencies_wide <- frequencies_long |>
  mutate(
    var_name = case_when(
      decision_stage == "Letter of formal notice (Article 258)" ~ "lfn_258",
      decision_stage == "Reasoned opinion (Article 258)" ~ "ro_258",
      decision_stage == "Referral to the Court (Article 258)" ~ "rf_258",
      decision_stage == "Letter of formal notice (Article 260)" ~ "lfn_260",
      decision_stage == "Reasoned opinion (Article 260)" ~ "ro_260",
      decision_stage == "Referral to the Court (Article 260)" ~ "rf_260"
    ) |>
      factor()
  ) |>
  pivot_wider(
    id_cols = member_state,
    names_from = var_name,
    values_from = count,
    id_expand = TRUE,
    values_fill = 0
  )

# Example 4: going from wide to long
# `pivot_longer()` lets you convert wide data to long data
frequencies_long_new <- frequencies_wide |>
  pivot_longer(
    cols = matches("258|260"),
    names_to = "decision_stage",
    values_to = "count"
  ) |>
  mutate(
    decision_stage = case_when(
      decision_stage == "lfn_258" ~ "Letter of formal notice (Article 258)",
      decision_stage == "ro_258" ~ "Reasoned opinion (Article 258)",
      decision_stage == "rf_258" ~ "Referral to the Court (Article 258)",
      decision_stage == "lfn_260" ~ "Letter of formal notice (Article 260)",
      decision_stage == "ro_260" ~ "Reasoned opinion (Article 260)",
      decision_stage == "rf_260" ~ "Referral to the Court (Article 260)"
    )
  ) |>
  filter(count != 0)

# Clean environment
rm(cases, decisions_new, frequencies_long, frequencies_long_new, frequencies_wide)
