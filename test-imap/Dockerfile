# Utilisation d'une image Docker contenant Dovecot
FROM alpine:latest

# Installation de Dovecot
RUN apk --no-cache add dovecot dovecot-pop3d

# Copie des fichiers de configuration et de la base de données uniquement s'ils n'existent pas déjà
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Commande par défaut pour démarrer le conteneur
CMD ["/docker-entrypoint.sh"]
