# Étape 1 : Choisir une image de base
FROM node:20

# Étape 2 : Définir le dossier de travail dans le conteneur
WORKDIR /app

# Étape 3 : Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Étape 4 : Installer les dépendances
RUN npm install

# Étape 5 : Copier le reste du code
COPY . .

# Étape 6 : Exposer le port (optionnel si tu veux tester en local)
EXPOSE 3000

# Étape 7 : Commande de démarrage
CMD ["npm", "start"]

