Construire l’image Docker


docker build -t my-node-app .


-t my-node-app → donne un nom à ton image.

. → signifie “utilise le Dockerfile ici”.

👉 Tu dois voir des étapes comme :

Step 1/7 : FROM node:20

Step 4/7 : RUN npm install

Successfully built [ID]