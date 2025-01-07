"""

API SLIM PROJET

Documentation : https://flask.palletsprojects.com/en/stable/quickstart/

Pour éxécuter l'api : 
- Créer un environnement virtuel
- Installer Flask
- pip install mysql-connector-python
- > flask --app NomDuFichier run
- > flask --app hello run --debug



"""

# IMPORT

from flask import Flask, jsonify
from markupsafe import escape
import _mysql_connector



# API SETUP

app = Flask(__name__)

# CONFIF à éditer pour la base de données MARIADB (changer les valeurs précédé par un @)
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
    return "<p>Hello, World!</p>"


@app.route("/<test>")
def hello(test):
    return f"TEST, {escape(test)}!"



# FONCTION pour récupérer des informations dans la base de données.
@app.route('/get-data', methods=['GET'])
def data():
    # Connexion à la DB
    connexion = _mysql_connector.connect(**db_config)
    cursor = connexion.cursor()

    # Rekekete éxecuté
    cursor.execute('Requete SQL')
    resultat = cursor.fetchone()

    # Fermeture (on est pas des cochons haram)
    cursor.close()
    connexion.close()

    # Retour de la data : (Gestion d'erreur si pas de data)
    return jsonify({'data': resultat[0]}) if resultat else jsonify({'data': 'No data'})


