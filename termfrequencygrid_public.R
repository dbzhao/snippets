##################################################
## Code to visualize term frequency in illustrative grid format using ggplot2
## Daniel Zhao, @danielbzhao
## 2020-07-17
##################################################

library(ggplot2)

### Load data
# Data should be a csv of format:
#   term  | frequency
#   'abc' | 123
#   'def' | 100
#   ...
terms <- read.csv(file="filename.csv")

### Data cleaning
# Insert your own data cleaning e.g. adding line breaks to long labels

### Graphing
# Set up indices for tiles based on width x height params
width = 8
height = 8
terms$colnum <- (((1:nrow(terms)-1) %% width) + 1) # repeating 1-to-width seq
terms$rownum <- floor((1:nrow(terms)-1)/width) # repeating seq incrementing by 1 each width

# Create plot
ggplot(head(terms, width*height), aes(x=colnum, y=rownum)) +
  # Create tiles
  geom_tile(aes(fill=frequency),
            color='white', # Color of lines between tiles
            size=0.5) +
  # Scale color based on frequency
  scale_fill_gradient(low="gray70", # Starting at gray compresses gradient but allows text to all be 1 color
                      high="black",
                      name='Frequency of\nmost common phrases' # legend title
                      ) +
  # Add text labels
  geom_text(aes(label=term),
            color='white',
            fontface="bold",
  ) +
  theme_void() + # remove grid, axes, ticks
  # Formatting choices
  theme(legend.position='bottom',
        legend.title=element_text(size=12),
        legend.text=element_text(),
        plot.title=element_text(size=14, face="bold", color="gray15"),
        plot.caption=element_text(size=10, face="plain", color="#858C94", hjust=0), # legend to left
        plot.margin=margin(t=5,l=5,r=5,b=8,"mm")
  ) +
  labs(title = "<title>",
       caption = "Source: <source>"
  ) +
  scale_y_reverse() # reverse y-axis so start is top-left, not bottom-left
