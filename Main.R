#load in the json file movies.json
library(jsonlite)

working_dir <- getwd()
movies_df <- read_json(paste(working_dir, "movies.json", sep = "/"), simplifyVector = TRUE)
movies_df <- movies_df[-1, ]
head(movies_df)

detach("package:jsonlite", unload = TRUE)

#Read in ratings.csv
ratings_df <- read.csv(paste(working_dir, "ratings.csv", sep = "/"))

#convert movieId to char since it is a key not a value.
ratings_df$movieId <- as.character(ratings_df$movieId)

#Keep only the necessary columns, movieID and rating
ratings_df <- ratings_df[c(2,3)]
head(ratings_df)

#Group by movie and summarise the average rating of each movie.
ratings_df <- ratings_df %>% group_by(movieId) %>% summarise(rating = mean(rating))

#using dplyr's join function join the ratings_df to the movies_df so ratings are attached to the proper movie
library(dplyr)
movies_df <- movies_df %>% left_join(ratings_df, by = c("movieId" = "movieId"))
head(movies_df)

#count the genres list for each movie we we know the count of the genres
movies_df <- movies_df %>% rowwise() %>% mutate(genres.count = length(genres))

#only keep the rating and genres.count columns so we can do anaysis on them
movies_df <- movies_df[4:5]
head(movies_df)

library(car)
