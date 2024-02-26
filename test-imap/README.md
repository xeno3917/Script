Image pour Docker-compose :
```
version: '3'

services:
  dovecot-backup:
    build: https://raw.githubusercontent.com/xeno3917/Script/main/test-imap/Dockerfile
    container_name: dovecot-backup
    ports:
      - "993:993"
    volumes:
      -  /path/conf:/etc/dovecot
      -  /path/mail:/var/mail
    restart: always
```

Pour ajouter un user (avec sqlite3) :
- `sqlite3 <chemin>/mail.db INSERT INTO users (userid, domain, password, home, uid, gid) VALUES ('user','exemple.com','<MD5-Password>','/var/mail/user.exemple.com',1000,1000)`

pour tester la connexion (depuis le conteneur) :
- `doveadm auth test <mail> <password>`

Journaux (deux emplacements) :
- Importants : `docker logs <nom>`
- les infos : /var/log/dovecot.log

Pour faire des backup/resto de mails (BAL Complete/incrementiel) :
```
docker run --rm gilleslamiral/imapsync imapsync \
--host1 <IP/Domaine>  --user1 <User/Mail>  --password1 '<Password>' \
--host2 <IP/Domaine>  --user2 <User/Mail>  --password2 '<Password>'
```
