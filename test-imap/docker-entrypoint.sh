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

if [ ! -f "/etc/dovecot/dovecot.pem" ]; then
    # Copier le fichier SSL s'il n'existe pas
    cp /var/default/dovecot.pem /etc/dovecot/dovecot.pem
    cp /var/default/dovecot.key /etc/dovecot/dovecot.key
fi

if [ ! -f "/etc/dovecot/dovecot-sql.conf.ext" ]; then
    # Copier le fichier dovecot-sql.conf.ext s'il n'existe pas
    cp /var/default/dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext
fi

if [ ! -f "/etc/dovecot/mail.db" ]; then
    # Création de la base de données SQLite et de la table
    sqlite3 /etc/dovecot/mail.db 'CREATE TABLE IF NOT EXISTS users (userid VARCHAR(128) NOT NULL, domain VARCHAR(128) NOT NULL, password VARCHAR(64) NOT NULL, home VARCHAR(255) NOT NULL, uid INTEGER NOT NULL, gid INTEGER NOT NULL);'
fi

# Démarrer Dovecot
exec dovecot -F
