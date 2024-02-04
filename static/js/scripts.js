// scripts.js

document.addEventListener('DOMContentLoaded', function() {
    // Add event listener for form submission
    const form = document.getElementById('movieForm');
    if (form) {
        form.addEventListener('submit', function(event) {
            event.preventDefault(); // Prevent default form submission

            // Get form data
            const formData = new FormData(form);
            const requestData = {};
            formData.forEach((value, key) => {
                requestData[key] = value;
            });

            // Make POST request to create a new movie
            fetch('/movies', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(requestData),
            })
            .then(response => {
                if (response.ok) {
                    alert('Movie created successfully!');
                    window.location.href = '/movies'; // Redirect to movie list
                } else {
                    alert('Error creating movie');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error creating movie');
            });
        });
    }
});
