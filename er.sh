#!/bin/bash

declare -A movies

movies["The Shawshank Redemption"]="1994,Drama, Frank Darabont, 9.3,Two imprisoned. Andy Dufresne, a quiet banker, is sentenced to life imprisonment in the Shawshank State Penitentiary for the murder of his wife and her lover, despite his claims of innocence."
movies["The Godfather"]="1972,Crime, Francis Ford Coppola, 9.2,An organized crime  "
movies["The Dark Knight"]="2008,Action, Christopher Nolan, 9,When the menace"
movies["The Godfather: Part II"]="1974,Crime, Francis Ford Coppola, 9,The early life"
movies["12"]="2007,Crime, Nikita Mikhalkov, 7.7,Aleksei is a former"
movies["Schindler's List"]="1993,Biography, Steven Spielberg, 8.9,Oskar Schindler"
movies["The Lord of the Rings: The Return of the King"]="2003,Adventure, Peter Jackson, 8.9,Gandalf and Aragorn"
movies["Pulp Fiction"]="1994,Crime, Quentin Tarantino, 8.9,Jules Winnfield"
movies["The Good, the Bad and the Ugly"]="1966,Western, Sergio Leone, 8.8,Blondie, Angel Eyes"
movies["Fight Club"]="1999,Drama, David Fincher, 8.8,A nameless first person"
movies["Forrest Gump"]="1994,Drama, Robert Zemeckis, 8.8,Forrest Gump"
movies["Inception"]="2010,Action, Christopher Nolan, 8.8,Dom Cobb"
movies["The Lord of the Rings: The Fellowship of the Ring"]="2001,Adventure, Peter Jackson, 8.8,An ancient Ring"
movies["The Lord of the Rings: The Two Towers"]="2002,Adventure, Peter Jackson, 8.7,Frodo and Sam"
movies["Star Wars: Episode V - The Empire Strikes Back"]="1980,Action, Irvin Kershner, 8.7,While Luke takes"
movies["The Matrix"]="1999,Action, Lana Wachowski, 8.7,Thomas A. Anderson"
movies["Goodfellas"]="1990,Biography, Martin Scorsese, 8.7,Henry Hill"
movies["One Flew Over the Cuckoo's Nest"]="1975,Drama, Milos Forman, 8.7,McMurphy has a criminal"
movies["Se7en"]="1995,Crime, David Fincher, 8.6,A film about two"
movies["The Silence of the Lambs"]="1991,Crime, Jonathan Demme, 8.6,Clarice Starling"
movies["Titanic"]="1997,Drama, James Cameron, 7.8,84 years later"
movies["The Sixth Sense"]="1999,Drama, M. Night Shyamalan, 8.1,Malcom Crowe"
movies["The Green Mile"]="1999,Crime, Frank Darabont, 8.6,Paul Edgecomb"
movies["The Lion King"]="1994,Animation, Roger Allers, 8.5,A young lion"
movies["The Pianist"]="2002,Biography, Roman Polanski, 8.5,A Polish Jewish"
movies["Gladiator"]="2000,Action, Ridley Scott, 8.5,Maximus is a powerful"
movies["American History X"]="1998,Drama, Tony Kaye, 8.5,Derek Vinyard"
movies["The Departed"]="2006,Crime, Martin Scorsese, 8.5,An undercover cop and a mole in the police attempt to identify each other while infiltrating an Irish gang in South Boston."
movies["The Prestige"]="2006,Drama, Christopher Nolan, 8.5,In the end"
movies["The Intouchables"]="2011,Biography, Olivier Nakache, 8.5,After he becomes"
movies["The Usual Suspects"]="1995,Crime, Bryan Singer, 8.5,Following a truck"
movies["The Terminator"]="1984,Action, James Cameron, 8,In the post-apocalyptic"
movies["The Thing"]="1982,Horror, John Carpenter, 8,A research team"
movies["The Shining"]="1980,Drama, Stanley Kubrick, 8,Jack Torrance"
movies["The Exorcist"]="1973,Horror, William Friedkin, 8,When a teenage"
movies["The Thing"]="2011,Horror, Matthijs van Heijningen Jr., 6.2,At an Antarctica"
movies["The Thing"]="1951,Horror, Christian Nyby, 7.2,Scientists and American"
movies["Batman Begins"]="2005,Action, Christopher Nolan, 8.2,After training"
movies["The Dark Knight Rises"]="2012,Action, Christopher Nolan, 8.4,Despite his tarnished"
movies["The Lord of the Rings: The Two Towers"]="2002,Adventure, Peter Jackson, 8.7,Frodo and Sam"


for title in "${!movies[@]}"; do
    IFS=',' read -ra movie <<< "${movies[$title]}"
    curl --location 'http://localhost:4000/movies' \
    --header 'Content-Type: application/json' \
    --data '{
        "title": "'"$title"'",
        "genre": "'"${movie[1]}"'",
        "year": '"${movie[0]}"',
        "director": "'"${movie[2]}"'",
        "rating": '"${movie[3]}"',
        "description": "'"${movie[4]}"'",
        "poster_url": "'"${movie[5]}"'"
    }'
done
