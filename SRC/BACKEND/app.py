"""

API SLIM PROJET

Documentation : https://flask.palletsprojects.com/en/stable/quickstart/

Pour éxécuter l'api : 
    (Plus d'utilisation de venv pour l'instant)
- se placer dans le dossier avec app.py
- dans le cmd: python app.py




"""

# IMPORT
from flask import Flask, jsonify, request
from markupsafe import escape
import mysql.connector
from flask_cors import CORS



# API SETUP

app = Flask(__name__)
CORS(app)

# CONFIF à éditer pour la base de données MARIADB (changer les valeurs précédé par un @)   <== Implémenter un .env 
db_config = {
    'host': '@ip',
    'user': '@utilisateur',
    'password': '@password',
    'database': '@db_name'
}


# FONCTIONS de TEST ( Vérifier le bon lancement de l'api : ip:5000/test)

@app.route("/")
# Fonction de test
def hello_world():
    return "<p>Salut les zgeg</p>"


@app.route("/<test>")
def hello(test):
    return f"TEST, {escape(test)}!"



# FONCTION pour récupérer des informations dans la base de données.
@app.route('/get-data', methods=['GET'])
def data():
    # Connexion à la DB
    connexion = mysql.connector.connect(**db_config)
    cursor = connexion.cursor()

    # Rekekete éxecuté
    cursor.execute('Requete SQL')
    resultat = cursor.fetchone()

    # Fermeture (on est pas des cochons haram)
    cursor.close()
    connexion.close()

    # Retour de la data : (Gestion d'erreur si pas de data)
    return jsonify({'data': resultat[0]}) if resultat else jsonify({'data': 'No data'})




# FONCTION LOGIN (NON CONNECTE A LA DATABASE)

users = {
    "admin": "test",
    "user1": "test",
}

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    if username in users and users[username] == password:
        return jsonify({"message": "Login successful"}), 200
    else:
        return jsonify({"message": "Invalid username or password"}), 401


#si vous faites methodes windows
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)