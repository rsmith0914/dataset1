---
Title: 'Netflix_Data'
Author: 'Ryan'
Date: '8/31/21'
---

#loading packages
library(dplyr)
library(readr)
library(ggplot2)
library(tidyr)
library(stringr)
library(tidyverse)
library(plotly)

#import data
data<- read_csv("~/Portfolio Data Sets/netflix_titles.csv")
view(data)

#cleaning data
netflix_titles <- data %>%
  select(-'show_id', - 'cast',-'director', -'country', -'date_added', -'description')%>%
  filter(data$type == 'Movie') %>%
  mutate(duration = substr(duration,1,nchar(duration)-4))%>%
  mutate(duration = as.numeric(duration))%>%
  filter(!grepl('84 min', rating),
         !grepl('66 min', rating),
         !grepl('74 min', rating),
         !grepl('NC-17', rating),
         !grepl('UR', rating),
         !grepl('TV-14', rating),
         !grepl('TV-G', rating),
         !grepl('TV-MA', rating),
         !grepl('TV-PG', rating),
         !grepl('TV-Y', rating))
netflix_titles$rating<- gsub("TV-Y7", "TV-Y", netflix_titles$rating)
netflix_titles$rating<- gsub("TV-Y-FV", "TV-Y", netflix_titles$rating)

#dividing by Genre
netflix_titles$genre_drama <- str_detect(netflix_titles$listed_in, "Dramas", negate = FALSE)
netflix_titles$genre_international_movies <- str_detect(netflix_titles$listed_in, "International Movies", negate = FALSE)
netflix_titles$genre_horror <- str_detect(netflix_titles$listed_in, "Horror", negate = FALSE)
netflix_titles$genre_action <- str_detect(netflix_titles$listed_in, "Action", negate = FALSE)
netflix_titles$genre_independent <- str_detect(netflix_titles$listed_in, "Independent", negate = FALSE)
netflix_titles$genre_scifi <- str_detect(netflix_titles$listed_in, "Sci-Fi", negate = FALSE)
netflix_titles$genre_thrillers <- str_detect(netflix_titles$listed_in, "Thrillers", negate = FALSE)
netflix_titles$genre_sports <- str_detect(netflix_titles$listed_in, "Sports", negate = FALSE)
netflix_titles$genre_comedies <- str_detect(netflix_titles$listed_in, "Comedies", negate = FALSE)
netflix_titles$genre_documentaries <- str_detect(netflix_titles$listed_in, "Documentaries", negate = FALSE)
netflix_titles$genre_romantic<- str_detect(netflix_titles$listed_in, "Romantic", negate = FALSE)
netflix_titles$genre_lgbtq <- str_detect(netflix_titles$listed_in, "LGBTQ", negate = FALSE)
netflix_titles$genre_spirituality <- str_detect(netflix_titles$listed_in, "Faith", negate = FALSE)
netflix_titles$genre_children <- str_detect(netflix_titles$listed_in, "Children", negate = FALSE)

#count by genre
drama_count <- sum(netflix_titles$genre_drama == "TRUE")
international_count <- sum(netflix_titles$genre_international_movies == "TRUE")
horror_count <- sum(netflix_titles$genre_horror == "TRUE")
action_count <- sum(netflix_titles$genre_action == "TRUE")
independent_count <- sum(netflix_titles$genre_independent == "TRUE")
scifi_count <- sum(netflix_titles$genre_scifi == "TRUE")
thrillers_count <- sum(netflix_titles$genre_thrillers == "TRUE")
sports_count <- sum(netflix_titles$genre_sports == "TRUE")
comedies_count <- sum(netflix_titles$genre_comedies == "TRUE")
documentaries_count <- sum(netflix_titles$genre_documentaries == "TRUE")
romantic_count <- sum(netflix_titles$genre_romantic == "TRUE")
lgbtq_count <- sum(netflix_titles$genre_lgbtq == "TRUE")
spirtuality_count <- sum(netflix_titles$genre_spirituality == "TRUE")
children_count <- sum(netflix_titles$genre_children == "TRUE")

#create genre df
genre_title <- c("Drama", "International", "Horror", "Action", "Independent","Scifi",
                 "Thrillers", "Sports", "Comedies", "Documentaries", "Romantic",
                 "LGBTQ", "Spirituality", "Children")
genre_count <- c(drama_count,international_count,horror_count, action_count,
                 independent_count,scifi_count, thrillers_count, sports_count,
                 comedies_count,documentaries_count, romantic_count,lgbtq_count,
                 spirtuality_count,children_count)
genre_data <- data.frame(genre_title, genre_count)

#plot
viz <- plot_ly(netflix_titles,
        title = "Duration vs Release Year",
        x=~release_year,
        y=~duration,
        color = ~rating,
        opacity = 0.9,
        text=~paste("Title: ", title, 
                    "<br>Release Year: ", release_year, 
                    "<br>Duration: ", duration),
        hoverinfo = "text") %>%
  layout(title = "Duration vs Release Year",
         xaxis = list(title="Release Year"),
         yaxis = list(title ="Duration"))
viz