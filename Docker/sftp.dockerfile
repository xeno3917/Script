FROM alpine:latest

RUN apk add --no-cache openssh && \
    rm -rf /var/cache/apk/* /tmp/* && \
    echo "Subsystem sftp internal-sftp" >> /etc/ssh/sshd_config

EXPOSE 22

CMD adduser -D -h /sftp/$SFTP_USER $SFTP_USER && \
    chown root:root /sftp/$SFTP_USER && chmod 755 /sftp/$SFTP_USER && \
    mkdir -p /sftp/$SFTP_USER/$SFTP_USER && chown $SFTP_USER:$SFTP_USER /sftp/$SFTP_USER/$SFTP_USER && \
    echo "Match User $SFTP_USER" >> /etc/ssh/sshd_config && \
    echo "    ChrootDirectory /sftp/$SFTP_USER" >> /etc/ssh/sshd_config && \
    echo "    ForceCommand internal-sftp" >> /etc/ssh/sshd_config && \
    echo "    AllowTcpForwarding no" >> /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    echo "$SFTP_USER:$SFTP_PASSWORD_HASH" | chpasswd -e && \
    exec /usr/sbin/sshd -D
