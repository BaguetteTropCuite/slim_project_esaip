document.getElementById('fetchButton').addEventListener('click', () => {
    fetch('http://localhost:5000/get-data') // Adapte l'URL si nécessaire
        .then(response => response.json())
        .then(data => {
            document.getElementById('displayData').textContent = data.data;
        });
});


/// BLOC LOGIN
document.getElementById("loginForm").addEventListener("submit", async (event) => {
    event.preventDefault();
  
    // Récupération des valeurs des champs de formulaire
    const username = document.querySelector("input[name='uname']").value;
    const password = document.querySelector("input[name='psw']").value;
  
    try {
      // Envoi de la requête au serveur
      const response = await fetch("http://localhost:5000/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ username, password }),
      });
  
      const data = await response.json();
  
      // Gestion de la réponse
      const responseMessage = document.createElement("p");
      responseMessage.id = "responseMessage";
      const formContainer = document.querySelector(".container");
  
      if (response.ok) {
        responseMessage.style.color = "green";
        responseMessage.innerText = "Login successful!";
      } else {
        responseMessage.style.color = "red";
        responseMessage.innerText = data.message || "Login failed!";
      }
  
      // Ajout du message de réponse sous le formulaire
      formContainer.appendChild(responseMessage);
    } catch (error) {
      // Gestion des erreurs réseau
      console.error("Error:", error);
      const errorMessage = document.createElement("p");
      errorMessage.id = "responseMessage";
      errorMessage.style.color = "red";
      errorMessage.innerText = "An error occurred!";
      document.querySelector(".container").appendChild(errorMessage);
    }
  });
  