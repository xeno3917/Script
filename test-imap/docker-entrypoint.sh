#!/bin/sh

# Vérifier si les fichiers existent déjà
if [ ! -f "/etc/dovecot/dovecot.conf" ]; then
    # Copier le fichier de configuration Dovecot s'il n'existe pas
    cp /var/default/dovecot.conf /etc/dovecot/dovecot.conf
fi

if [ ! -f "/etc/dovecot/auth-sql.conf.ext" ]; then
    # Copier le fichier auth-sql.conf.ext s'il n'existe pas
    cp /var/default/auth-sql.conf.ext /etc/dovecot/auth-sql.conf.ext
fi

if [ ! -f "/etc/dovecot/dovecot-sql.conf.ext" ]; then
    # Copier le fichier dovecot-sql.conf.ext s'il n'existe pas
    cp /var/default/dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext
fi

if [ ! -f "/etc/dovecot/mail.db" ]; then
    # Création de la base de données SQLite et de la table
    sqlite3 /etc/dovecot/mail.db \
    && echo "CREATE TABLE users (" \
    && echo "  userid VARCHAR(128) NOT NULL," \
    && echo "  domain VARCHAR(128) NOT NULL," \
    && echo "  password VARCHAR(64) NOT NULL," \
    && echo "  home VARCHAR(255) NOT NULL," \
    && echo "  uid INTEGER NOT NULL," \
    && echo "  gid INTEGER NOT NULL" \
    && echo ");" \
    | sqlite3 /etc/dovecot/mail.db
fi

# Démarrer Dovecot
exec "$@"