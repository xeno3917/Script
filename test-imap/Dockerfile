# Utilisation d'une image Docker contenant Dovecot
FROM alpine:latest

# Installation de Dovecot
RUN apk --no-cache add dovecot sqlite

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

# Copie des fichiers de configuration et de la base de données uniquement s'ils n'existent pas déjà
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Commande par défaut pour démarrer le conteneur
CMD ["/docker-entrypoint.sh"]
