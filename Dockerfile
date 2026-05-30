# On utilise l'image officielle du projet pingtunnel
# Cette image est déjà construite, il n'y a rien à compiler ou à télécharger.
FROM ghcr.io/esrrhs/pingtunnel:latest

# On expose le port par défaut (souvent 53 ou 5000, on laisse l'image le gérer)
EXPOSE 53/udp

# On définit la commande pour lancer le serveur.
# -type server : pour être en mode serveur
# -key ton_mot_de_passe : pour sécuriser ta connexion (remplace "MonSuperMotDePasse")
ENTRYPOINT ["./pingtunnel"]
CMD ["-type", "server", "-key", "MonSuperMotDePasse"]
