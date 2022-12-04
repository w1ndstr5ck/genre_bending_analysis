import csv
import json

movies = []
lines = []

with open("E:\Code\IDSC_4110\Final Project\movies.csv", mode="r", encoding='utf-8') as data:
    csvFile = csv.reader(data)
    for line in csvFile:
        lines.append(line)

#print(lines)

for line in lines:
    movie = {"movieId" : "",
        "title" : "",
        "genres" : ""}
    movie["movieId"] = line[0]
    movie["title"] = line[1]
    genres = line[2].split("|")
    movie["genres"] = genres
    movies.append(movie)

json_object = json.dumps(movies, indent=4)
 
# Writing to sample.json
with open("movies.json", "w") as outfile:
    outfile.write(json_object)