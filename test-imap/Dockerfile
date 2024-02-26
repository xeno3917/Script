# Utilisation d'une image Docker contenant Dovecot
FROM alpine:latest

# Installation de Dovecot
RUN apk --no-cache add dovecot dovecot-sqlite sqlite

RUN mkdir /var/default

RUN openssl req -new -x509 -days 3650 -nodes -out /var/default/dovecot.pem -keyout /var/default/dovecot.key -subj "/C=FR/ST=None/L=None/O=None/CN=www.example.com"
RUN chmod 600 /var/default/dovecot.key

RUN echo "protocols = imap" >> /var/default/dovecot.conf \
    && echo "!include auth-sql.conf.ext" >> /var/default/dovecot.conf \
    && echo "mail_location = mbox:~/mail:INBOX=/var/mail/%u" >> /var/default/dovecot.conf \
    && echo "hostname = mail.creyx.fr" >> /var/default/dovecot.conf \
    && echo "log_path = /var/log/dovecot.log" >> /var/default/dovecot.conf \
    && echo "ssl = required" >> /var/default/dovecot.conf \
    && echo "ssl_cert = </etc/dovecot/dovecot.pem" >> /var/default/dovecot.conf \
    && echo "ssl_key = </etc/dovecot/dovecot.key" >> /var/default/dovecot.conf \
    && echo "protocol imap {" >> /var/default/dovecot.conf \
    && echo "    ssl = required" >> /var/default/dovecot.conf \
    && echo "}" >> /var/default/dovecot.conf \
    && echo "passdb {" >> /var/default/auth-sql.conf.ext \
    && echo "  driver = sql" >> /var/default/auth-sql.conf.ext \
    && echo "  args = /etc/dovecot/dovecot-sql.conf.ext" >> /var/default/auth-sql.conf.ext \
    && echo "}" >> /var/default/auth-sql.conf.ext \
    && echo "userdb {" >> /var/default/auth-sql.conf.ext \
    && echo "  driver = sql" >> /var/default/auth-sql.conf.ext \
    && echo "  args = /etc/dovecot/dovecot-sql.conf.ext" >> /var/default/auth-sql.conf.ext \
    && echo "}" >> /var/default/auth-sql.conf.ext \
    && echo "driver = sqlite" >> /var/default/dovecot-sql.conf.ext \
    && echo "connect = /etc/dovecot/mail.db" >> /var/default/dovecot-sql.conf.ext \
    && echo "password_query = SELECT userid AS username, domain, password FROM users WHERE userid = '%n' AND domain = '%d'" >> /var/default/dovecot-sql.conf.ext \
    && echo "user_query = SELECT home, uid, gid FROM users WHERE userid = '%n' AND domain = '%d'" >> /var/default/dovecot-sql.conf.ext \
    && echo "iterate_query = SELECT userid AS username, domain FROM users" >> /var/default/dovecot-sql.conf.ext

# Copie des fichiers de configuration et création de la base de données
RUN echo '#!/bin/sh' > /docker-entrypoint.sh && \
    echo 'if [ ! -f "/etc/dovecot/dovecot.conf" ]; then' >> /docker-entrypoint.sh && \
    echo '    echo "Création de /etc/dovecot/dovecot.conf..."' >> /docker-entrypoint.sh && \
    echo '    cp /var/default/dovecot.conf /etc/dovecot/dovecot.conf' >> /docker-entrypoint.sh && \
    echo 'fi' >> /docker-entrypoint.sh && \
    echo 'if [ ! -f "/etc/dovecot/auth-sql.conf.ext" ]; then' >> /docker-entrypoint.sh && \
    echo '    echo "Création de /etc/dovecot/auth-sql.conf.ext..."' >> /docker-entrypoint.sh && \
    echo '    cp /var/default/auth-sql.conf.ext /etc/dovecot/auth-sql.conf.ext' >> /docker-entrypoint.sh && \
    echo 'fi' >> /docker-entrypoint.sh && \
    echo 'if [ ! -f "/etc/dovecot/dovecot.pem" ]; then' >> /docker-entrypoint.sh && \
    echo '    echo "Création de /etc/dovecot/dovecot.pem..."' >> /docker-entrypoint.sh && \
    echo '    cp /var/default/dovecot.pem /etc/dovecot/dovecot.pem' >> /docker-entrypoint.sh && \
    echo '    cp /var/default/dovecot.key /etc/dovecot/dovecot.key' >> /docker-entrypoint.sh && \
    echo 'fi' >> /docker-entrypoint.sh && \
    echo 'if [ ! -f "/etc/dovecot/dovecot-sql.conf.ext" ]; then' >> /docker-entrypoint.sh && \
    echo '    echo "Création de /etc/dovecot/dovecot-sql.conf.ext..."' >> /docker-entrypoint.sh && \
    echo '    cp /var/default/dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext' >> /docker-entrypoint.sh && \
    echo 'fi' >> /docker-entrypoint.sh && \
    echo 'if [ ! -f "/etc/dovecot/mail.db" ]; then' >> /docker-entrypoint.sh && \
    echo '    echo "Création de /etc/dovecot/mail.db..."' >> /docker-entrypoint.sh && \
    echo '    sqlite3 /etc/dovecot/mail.db "CREATE TABLE IF NOT EXISTS users (userid VARCHAR(128) NOT NULL, domain VARCHAR(128) NOT NULL, password VARCHAR(64) NOT NULL, home VARCHAR(255) NOT NULL, uid INTEGER NOT NULL, gid INTEGER NOT NULL);"' >> /docker-entrypoint.sh && \
    echo 'fi' >> /docker-entrypoint.sh && \
    echo 'echo "Démarrage de Dovecot..."' >> /docker-entrypoint.sh && \
    echo 'exec dovecot -F' >> /docker-entrypoint.sh && \
    chmod +x /docker-entrypoint.sh

# Commande par défaut pour démarrer le conteneur
CMD ["/docker-entrypoint.sh"]
