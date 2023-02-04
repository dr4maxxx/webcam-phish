#!/bin/bash

# Installation de Pygame
pip install pygame

# Génération du code HTML pour la page de demande d'autorisation de la webcam
html_code='
<html>
  <head>
    <title>Autorisation de la webcam</title>
  </head>
  <body>
    <h1>Demande d'autorisation de la webcam</h1>
    <p>Voulez-vous autoriser l'accès à votre webcam ?</p>
    <form action="http://localhost:8080/capture" method="post">
      <input type="submit" name="submit" value="Autoriser">
      <input type="submit" name="submit" value="Refuser">
    </form>
  </body>
</html>
'

# Enregistrement du code HTML dans un fichier
echo "$html_code" > index.html

# Création d'un script Python pour capturer une image à partir de la webcam
capture_script='
import pygame
import pygame.camera

def capture_image():
    pygame.camera.init()
    cam = pygame.camera.Camera("/dev/video0",(640,480))
    cam.start()
    image = cam.get_image()
    pygame.image.save(image, "captured_image.jpg")
    cam.stop()
    pygame.camera.quit()

capture_image()
'

# Enregistrement du script Python dans un fichier
echo "$capture_script" > capture.py

# Démarrage d'un serveur web local pour héberger la page web et le script de capture d'image
python3 -m http.server 8080 &

# Affichage de l'URL Cloudflare de la page web
echo "http://cloudflare.com/index.html"
