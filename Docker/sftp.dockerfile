FROM alpine:latest

RUN apk add --no-cache openssh && \
    rm -rf /var/cache/apk/* /tmp/* && \
    echo "Subsystem sftp internal-sftp" >> /etc/ssh/sshd_config && \
    mkdir /sftp/sftp -p && \
    adduser -D -h /sftp/sftp sftp && \
    chown root:root /sftp/sftp && chmod 755 /sftp/sftp && \
    mkdir -p /sftp/sftp/keepass && chown sftp:sftp /sftp/sftp/keepass && \
    echo "Match User sftp" >> /etc/ssh/sshd_config && \
    echo "    ChrootDirectory /sftp/sftp" >> /etc/ssh/sshd_config && \
    echo "    ForceCommand internal-sftp" >> /etc/ssh/sshd_config && \
    echo "    AllowTcpForwarding no" >> /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    echo "sftp:\$6\$kgsqrLvJorL62Ox6\$T7TkR4i7JF2eEv2g7aiuZroBkFfwEsTHrqXQAoYl7phwEmUuxG.r3IjPUiNoiOXxwnuS8ngFRJqyo2sf/0pGy/" | chpasswd -e

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
