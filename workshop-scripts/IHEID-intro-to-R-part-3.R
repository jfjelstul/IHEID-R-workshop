# SOCIAL SCIENCE METHODS FOR LAWYERS
# The Graduate Institute, Geneva, May the 4th...
# Module 3: Intro to R 
# Unit 3: Visualizations 
# Umut Yüksel

#### Introduction #### 

# Visualizations are useful for HIGHLIGHTING TRENDS AND PATTERNS in the data. 
# They also allow us to DETECT ERROS we might have made in coding. 

# In this unit, we will show you how to use ggplot2 to visualize your data.  
# We will continue to rely the EU Infringements Procedure (EUIP) Database.

# We begin by introducing ggplot2. We then move onto visualizing  

#### ggplot2 #### 

# ggplot2 is part of "tidyverse", which you can install and load: 
install.packages("tidyverse")
library(tidyverse)

# Or you can just install and load ggplot2:
# install.packages("ggplot2")
# library(ggplot2)

# ggplot2 is a powerful and flexible way of creating plots.
# It requires you to:
# (1) provide the data to be plotted, 
# (2) specify the variables to be used, 
# (3) specify the way in which the data points should be represented.

# After these initial specifications, you can build your plot layer by layer. 

# Let's create a few random data points and see how this works:
df <- data.frame(a = c(0, 1, 2, 3, 4, 5), 
                 b = c(3, 2, 1, 2, 3, 4),
                 c = c("r", "r", "r", "b", "b", "b"))

df

ggplot(df, aes(x = a, y = b)) # this creates the coordinate system 
# where our variables (a and b) could be mapped

ggplot(df, aes(x = a, y = b)) + 
  geom_point() # this specifies how the data should be represented, note the + 

ggplot(df, aes(x = a, y = b, color = c)) + # we add color to it
  geom_point() 

# We can then modify our plot by adding new arguments and layers to this representation: 
ggplot(df, aes(x = a, y = b, color = c)) + 
  geom_point(size = 10) # larger points

ggplot(df, aes(x = a, y = b, color = c)) + 
  geom_point(size = c(2, 4, 6, 8, 10, 12)) # points getting larger

# Let's add some labels: 
ggplot(df, aes(x = a, y = b, color = c)) + 
  geom_point(size = c(2, 4, 6, 8, 10, 12)) +   
  labs(title = "Bouncing points", 
       x = "The x-axis", 
       y = "The y-axis",
       caption = "Some caption") 

# Let's modify our legend (linked to our "color" aesthetic): 
ggplot(df, aes(x = a, y = b, color = c)) + 
  geom_point(size = c(2, 4, 6, 8, 10, 12)) +   
  labs(title = "Bouncing points", 
       subtitle = "Just some random points",
       x = "The x-axis", 
       y = "The y-axis", 
       caption = "Some caption") +
  scale_color_discrete(name = "Colors",
                       label = c("Reds", "Blues"))

# We can also change the theme and increase the size of our elements:
ggplot(df, aes(x = a, y = b, color = c)) + 
  geom_point(size = c(2, 4, 6, 8, 10, 12)) +   
  labs(title = "Bouncing points", 
       subtitle = "Just some random points",
       x = "The x-axis", 
       y = "The y-axis", 
       caption = "Some caption") +
  scale_color_discrete(name = "Colors",
                       label = c("Reds", "Blues")) +   
  theme_bw() 

ggplot(df, aes(x = a, y = b, color = c)) + 
  geom_point(size = c(2, 4, 6, 8, 10, 12)) +   
  labs(title = "Bouncing points", 
       subtitle = "Just some random points",
       x = "The x-axis", 
       y = "The y-axis", 
       caption = "Some caption") +
  scale_color_discrete(name = "Colors",
                       label = c("Reds", "Blues")) + 
  theme_classic() # check out the other themes 

ggplot(df, aes(x = a, y = b, color = c)) + 
  geom_point(size = c(2, 4, 6, 8, 10, 12)) +   
  labs(title = "Bouncing points", 
       subtitle = "Just some random points",
       x = "The x-axis", 
       y = "The y-axis", 
       caption = "Some caption") +
  scale_color_discrete(name = "Colors",
                       label = c("Reds", "Blues")) + 
  theme_minimal(base_size = 15)

# We can also change the position of our legend (or remove it completely): 

ggplot(df, aes(x = a, y = b, color = c)) + 
  geom_point(size = c(2, 4, 6, 8, 10, 12)) +   
  labs(title = "Bouncing points", 
       subtitle = "Just some random points",
       x = "The x-axis", 
       y = "The y-axis", 
       caption = "Some caption") +
  scale_color_discrete(name = "Colors",
                       label = c("Reds", "Blues")) + 
  theme_minimal(base_size = 15) + 
  theme(legend.position = "bottom") # try putting "top", "left", and "None" instead of "bottom"

# Finally, note that you can save this plot and add layers to the saved object later: 
p <- ggplot(df, aes(x = a, y = b, color = c)) + 
  geom_point(size = c(2, 4, 6, 8, 10, 12)) +   
  labs(title = "Bouncing points", 
       subtitle = "Just some random points",
       x = "The x-axis", 
       y = "The y-axis", 
       caption = "Some caption") +
  scale_color_discrete(name = "Colors",
                       label = c("Reds", "Blues")) + 
  theme_minimal(base_size = 15) + 
  theme(legend.position = "bottom") 

p + theme(axis.ticks = element_blank()) + # remove the ticks
  theme(axis.text = element_blank()) # remove the text on the axes 

#### Bar graph ####

# Make sure you have run these from the previous script: 
devtools::install_github("jfjelstul/euip", force = TRUE)
decisions <- euip::decisions

# Also, feel free to install a custom theme:
# devtools::install_github("jfjelstul/ggminimal")
# library(ggminimal)

# Let's begin with a bar graph, visualizing the letters of formal notice (LFNs) 
# received by member state in 2018. 

# The first step is to create a dataframe that is ready to be plotted. 
# We take the decisions that are at the LFN stage in 2018:
lfn_2018 <- decisions |>
  filter(stage_lfn_258 == 1, decision_year == 2018) |>
  group_by(member_state) |>
  summarize(count = n()) 

lfn_2018

# Now let's plot it: 
ggplot(lfn_2018, aes(x = member_state, y = count)) + 
  geom_bar(stat = "identity")

# The plot shows the states on the x-axis, and the number LFNs received in 2018. 
# As you can see, it is not terrible--we can barely read the names of the states.

# Now let us customize it a little, adding a title and axis labels, increasing size,
# and rotating the text on the x-axis so that we can read the names of the states:

ggplot(lfn_2018, aes(x = member_state, y = count)) +
  geom_bar(stat = "identity") +
  labs(title = "Letters for formal notice (2018)", 
       x = "Member state", 
       y = "Number of decisions") + 
  theme_bw(base_size = 15) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
# "angle" does the rotation and "hjust = 1" simply nudges the text down to avoid overlap. 

# Now it would be good to arrange countries on the x-axis by the number of decisions. 
# For this, we have to rearrange the member_state variable, like so: 

lfn_2018_ordered <- lfn_2018 |> 
  mutate(member_state = fct_reorder(member_state, count)) 

# Simply swap the data frames to see what this does: 
ggplot(lfn_2018_ordered, aes(x = member_state, y = count)) +
  geom_bar(stat = "identity") +
  labs(title = "Letters for formal notice (2018)", 
       x = "Member state", 
       y = "Number of decisions") + 
  theme_bw(base_size = 15) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Much better. Let's add a final piece of information to the graph so that 
# we see which countries receive more letters than average and which fewer:
ggplot(lfn_2018_ordered, aes(x = member_state, y = count)) +
  geom_bar(stat = "identity") +
  geom_hline(aes(yintercept = mean(count)), linetype = "dashed", size = 0.5) + 
  labs(title = "Letters for formal notice (2018)", 
       x = "Member state", 
       y = "Number of decisions") + 
  theme_bw(base_size = 15) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

# Let's do a few final adjustments: 
ggplot(lfn_2018_ordered, aes(x = member_state, y = count)) +
  geom_bar(stat = "identity", size = 0.5, color = "black", fill = "gray90", width = 0.75) +
  geom_hline(aes(yintercept = mean(count)), linetype = "dashed", size = 0.5) + 
  scale_y_continuous(breaks = seq(0, 40, 5)) +
  labs(title = "Letters for formal notice (2018)", 
       x = NULL, 
       y = "Number of decisions") + 
  theme_bw(base_size = 15) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

# When we are satisfied with your plot, we can save it using ggsave: 
final_bar_graph <- ggplot(lfn_2018_ordered, aes(x = member_state, y = count)) +
  geom_bar(stat = "identity", size = 0.5, color = "black", fill = "gray90", width = 0.75) +
  geom_hline(aes(yintercept = mean(count)), linetype = "dashed", size = 0.5) + 
  labs(title = "Letters for formal notice (2018)", 
       x = NULL, 
       y = "Number of decisions") + 
  theme_bw(base_size = 15) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

ggsave(final_bar_graph, filename = "~/Desktop/bar-graph.pdf", device = "pdf", width = 10, height = 7, scale = 1.25)

#### Line graph #### 

# Let's check another type of graph that shows evolution over time. 
# Instead of getting counts per unit, we can get counts per year to show how
# applications, decisions, violations, etc. evolve over time. 

# Let's have a look at the decisions between the years of 2004 and 2018. 
# Again, we can begin by getting a data frame that will do for our purposes: 

lfn_258_2004_to_2018 <- decisions |>
  filter(stage_lfn_258 == 1 & decision_year >= 2004 & decision_year <= 2018) |>
  group_by(decision_year) |> # we group by decision_year, instead of member-state
  summarize(count = n())

lfn_258_2004_to_2018

# We can begin by plotting the points using geom_point(): 
ggplot(lfn_258_2004_to_2018, aes(x = decision_year, y = count)) + 
  geom_point() 
  
# We can add lines to connect the points: 
ggplot(lfn_258_2004_to_2018, aes(x = decision_year, y = count)) + 
  geom_point() +
  geom_line() 

# Let's add titles and labels, and change the breaks on the axes: 
ggplot(lfn_258_2004_to_2018, aes(x = decision_year, y = count)) + 
  geom_point() +
  geom_line() + 
  labs(title = "Letters for formal notice by year", 
       x = NULL, 
       y = "Number of decisions") + 
  scale_y_continuous(breaks = seq(0, 2000, 100)) +
  scale_x_continuous(breaks = seq(2002, 2018, 1)) + 
  theme_bw(base_size = 15)

# We can visualize addition information, for instance, the entry into force of the Treaty of Lisbon: 
ggplot(lfn_258_2004_to_2018, aes(x = decision_year, y = count)) + 
  geom_point() +
  geom_line() + 
  geom_vline(xintercept = 2009, linetype = "dashed", size = 0.5) +
  annotate(geom = "text", x = 2009-0.33, y = 1600, 
           label = "Lisbon Treaty", 
           color = "black",
           angle = 90, 
           size = 5) +
  labs(title = "Letters for formal notice by year", 
       x = NULL, 
       y = "Number of decisions") + 
  scale_y_continuous(breaks = seq(0, 2000, 100)) +
  scale_x_continuous(breaks = seq(2002, 2018, 1)) + 
  theme_bw(base_size = 15) 
  
# Again, when satisfied, we can save the plot. 

# We can also plot several lines showing different stages. 
# Let's capture the three stages of: 
# - Letter of formal notice (LFN)
# - Reasoned opinion
# - Referral to the Court 

# The dataframe we need can be obtained as follows: 

three_stages <- decisions |>
  filter(decision_stage_id %in% c(1, 2, 3) & decision_year >= 2004 & decision_year <= 2018) |>
  group_by(decision_year, decision_stage) |>
  summarize(count = n()) |>
  mutate(decision_stage = factor(decision_stage))

# Now let's plot: 
ggplot(three_stages, aes(x = decision_year, y = count, color = decision_stage)) +
  geom_point() +
  geom_line() +
  labs(title = "Article 258 decisions by year",
       x = NULL, 
       y = "Number of decisions") + 
  scale_y_continuous(breaks = seq(0, 2000, 100)) +
  scale_x_continuous(breaks = seq(2002, 2018, 1)) +
  scale_color_discrete(name = "Decision stage") +
  theme_bw(base_size = 15) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

# You can also represent this information as a bar graph with different categories:
# (Note that we now use "fill =" instead of "color =" for the grouping variable)
ggplot(three_stages, aes(x = decision_year, y = count, fill = decision_stage)) +
  geom_bar(stat = "identity")

# We can customize again: 
ggplot(three_stages, aes(x = decision_year, y = count, fill = decision_stage)) +
  geom_bar(stat = "identity", size = 0.5, width = 0.75) + 
  labs(title = "Distribution of Article 258 decisions by year",
       x = NULL, 
       y = "Number of decisions") + 
  scale_y_continuous(breaks = seq(0, 3000, 200)) +
  scale_x_continuous(breaks = seq(2002, 2018, 1)) +
  scale_fill_discrete(name = "Decision stage") +
  theme_bw(base_size = 15) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Instead of stacking these, you can also have the bars side by side by adding position: 

ggplot(three_stages, aes(x = decision_year, y = count, fill = decision_stage)) +
  geom_bar(stat = "identity", size = 0.5, width = 0.75, position = "dodge") + 
  labs(title = "Distribution of Article 258 decisions by year",
       x = NULL, 
       y = "Number of decisions") + 
  scale_y_continuous(breaks = seq(0, 2000, 100)) +
  scale_x_continuous(breaks = seq(2002, 2018, 1)) +
  scale_fill_discrete(name = "Decision stage") +
  theme_bw(base_size = 15) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# or have it all represent proportions: 

ggplot(three_stages, aes(x = decision_year, y = count, fill = decision_stage)) +
  geom_bar(stat = "identity", size = 0.5, width = 0.75, position = "fill") + 
  labs(title = "Distribution of Article 258 decisions by year",
       x = NULL, 
       y = "Proportion of decisions") + 
  scale_y_continuous(breaks = seq(0, 1, 0.10)) +
  scale_x_continuous(breaks = seq(2002, 2018, 1)) +
  scale_fill_discrete(name = "Decision stage") +
  theme_bw(base_size = 15) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# You have a lot of options when it comes to colors. 
# You can use one of the RColorBrewer palettes, for instance*: 
# *see here: https://r-graph-gallery.com/38-rcolorbrewers-palettes.html

ggplot(three_stages, aes(x = decision_year, y = count, fill = decision_stage)) +
  geom_bar(stat = "identity", size = 0.5, width = 0.75) + 
  labs(title = "Distribution of Article 258 decisions by year",
       x = NULL, 
       y = "Number of decisions") + 
  scale_y_continuous(breaks = seq(0, 3000, 200)) +
  scale_x_continuous(breaks = seq(2002, 2018, 1)) +
  scale_fill_brewer(name = "Decision stage", palette = "Dark2") + # try: palette="Pastel1" etc. 
  theme_bw(base_size = 15) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

# A final option we will introduce is the geom_wrap().
# This allows you to create panels per the grouping variables: 

ggplot(three_stages, aes(x = decision_year, y = count, fill = decision_stage)) +
  geom_bar(stat = "identity", size = 0.5, width = 0.75) + 
  labs(title = "Distribution of Article 258 decisions by year and decision stage",
       x = NULL, 
       y = "Number of decisions") + 
  scale_y_continuous(breaks = seq(0, 3000, 200)) +
  scale_x_continuous(breaks = seq(2002, 2018, 2)) +
  scale_fill_brewer(name = "Decision stage", palette = "Dark2") + # try: palette="Pastel1" etc. 
  theme_bw(base_size = 9) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
  theme(legend.position = "bottom") +
  facet_wrap(~decision_stage) 

# Note that for all these to work properly, you need to have your grouping variable  
# saved as a factor with all the levels properly identified and labeled. 

#### Endless, the possibilities are... #### 

# There is much more you can do with ggplot2 (and other packages). 
# We have some examples for you on our GitHub page. 

# See also hundreds of guides online: 
# -  https://r-graph-gallery.com (a great variety of charts with reproducible code)

# Don't be shy to Google whenever you have a visualization idea in mind. 
# You can bet that someone has already implemented using ggplot2 or R. 

# The end. 
