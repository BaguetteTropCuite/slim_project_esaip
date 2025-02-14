document.getElementById("loginForm").addEventListener("submit", async (event) => {
    event.preventDefault();
  
    const username = document.querySelector("input[name='uname']").value;
    const password = document.querySelector("input[name='psw']").value;

    console.log("Envoi de la requête avec :", { username, password });

    try {
        const response = await fetch("http://localhost:5000/login", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ username, password }),
        });

        console.log("Réponse brute:", response);

        const data = await response.json();
        console.log("Données reçues:", data);

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

        formContainer.appendChild(responseMessage);
    } catch (error) {
        console.error("Erreur:", error);
        const errorMessage = document.createElement("p");
        errorMessage.id = "responseMessage";
        errorMessage.style.color = "red";
        errorMessage.innerText = "An error occurred!";
        document.querySelector(".container").appendChild(errorMessage);
    }
});
