#Download the packages if not already downloaded 

# Download ggplot2 package
#install.packages("ggplot2")

# Download plotly package
#install.packages("plotly")

# Download dplyr package
#install.packages("dplyr")

# Download readr package
#install.packages("readr")

# Download htmlwidgets package
#install.packages("htmlwidgets")

# Download RColorBrewer package
#install.packages("RColorBrewer")

# Load the required packages
library(ggplot2)   # for data visualization
library(plotly)    # for interactive plots
library(dplyr)     # for data manipulation
library(readr)     # for reading data
library(htmlwidgets) # for saving the plot as HTML
library(RColorBrewer)



# Read in the parkinson.csv data and select columns
parkinson_df <- read_csv("Data/parkinson.csv") %>%
  select(YEAR, STATE, RATE)

# Preview the first few rows of the data
head(parkinson_df)

# Set the font and label options
font = list(
  family = "Lucida Grande",
  size = 5,
  color = "black"
)

label = list(
  bgcolor = "#EEEEEE",
  bordercolor = "transparent",
  font = font
)

# Define the color palette
color_palette <- colorRampPalette(rev(RColorBrewer::brewer.pal(11, "RdBu")))(100)

# Create the plotly map
parkinson_map <- plot_geo(parkinson_df,
                          locationmode = "USA-states",
                          frame = ~YEAR) %>%
  add_trace(locations = ~STATE,
            z = ~RATE,
            zmin = 0,
            zmax = max(parkinson_df$RATE),
            colors = color_palette, # Set the color palette
            color = ~RATE) %>%
  layout(geo = list(scope = 'usa',
                    bgcolor = '#F5F5F5'), # Set the background color of the map
         title = list(text = "Death rate due to Parkinson disease in the US 2005-2021 , State by state  ",
                      font = list(family = "Lucida Grande" , size = 15),
                      x = 0),
         font = list(family = "Lucida Grande"),
         paper_bgcolor = '#F5F5F5', # Set the background color of the plot
         plot_bgcolor = '#F5F5F5',
         shapes = list(
           type = "line",
           x0 = -0.1,
           y0 = 0,
           x1 = 1.1,
           y1 = 0,
           line = list(color = "black", width = 2)
         ),
         annotations = list(
           list(
             x = -0.1,
             y = -0.065,
             text = "U.S. Centers for Disease Control and Prevention (CDC)",
             showarrow = FALSE,
             xref = "paper",
             yref = "paper",
             font = list(
               family = "Arial",
               size = 13,
               color = "black"
             )
           ),
           list(
             x = -0.115,
             y = 0,
             text = "*Age-Adjusted Death Rates per 100,000 total population ",
             showarrow = FALSE,
             xref = "paper",
             yref = "paper",
             font = list(
               family = "Arial",
               size = 12,
               color = "black"
             )
           )
         )
  ) %>%
  config(displayModeBar = FALSE)


# Save the plot as an HTML file in the "Graph" folder
htmlwidgets::saveWidget(parkinson_map, file = "Graph/parkinson_map.html")


# Display the plotly map
parkinson_map

