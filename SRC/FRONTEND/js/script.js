document.getElementById('fetchButton').addEventListener('click', () => {
    fetch('http://localhost:5000/get-data') // Adapte l'URL si nécessaire
        .then(response => response.json())
        .then(data => {
            document.getElementById('displayData').textContent = data.data;
        });
});