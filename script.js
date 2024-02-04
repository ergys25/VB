document.addEventListener('DOMContentLoaded', function() {
    const moviesContainer = document.getElementById('movies-container');

    // Fetch movies from the server
    fetch('http://localhost:4000/movies')
        .then(response => response.json())
        .then(movies => {
            movies.forEach(movie => {
                // Create HTML elements for each movie
                const movieDiv = document.createElement('div');
                movieDiv.classList.add('movie');

                const img = document.createElement('img');
                img.src = movie.poster_url;
                img.alt = movie.title;

                const title = document.createElement('h2');
                title.textContent = movie.title;

                const genre = document.createElement('p');
                genre.textContent = 'Genre: ' + movie.genre;

                const year = document.createElement('p');
                year.textContent = 'Year: ' + movie.year;

                const director = document.createElement('p');
                director.textContent = 'Director: ' + movie.director;

                const rating = document.createElement('p');
                rating.textContent = 'Rating: ' + movie.rating;

                const description = document.createElement('p');
                description.textContent = 'Description: ' + movie.description;

                // Append elements to movie div
                movieDiv.appendChild(img);
                movieDiv.appendChild(title);
                movieDiv.appendChild(genre);
                movieDiv.appendChild(year);
                movieDiv.appendChild(director);
                movieDiv.appendChild(rating);
                movieDiv.appendChild(description);

                // Append movie div to movies container
                moviesContainer.appendChild(movieDiv);
            });
        })
        .catch(error => console.error('Error fetching movies:', error));
});
