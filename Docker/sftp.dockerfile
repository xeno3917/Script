FROM alpine:latest

RUN apk add --no-cache openssh && \
    rm -rf /var/cache/apk/* /tmp/* && \
    echo "Subsystem sftp internal-sftp" >> /etc/ssh/sshd_config && \
    mkdir /sftp/keepass -p && \
    adduser -D -h /sftp/keepass keepass && \
    chown root:root /sftp/keepass && chmod 755 /sftp/keepass && \
    mkdir -p /sftp/keepass/keepass && chown keepass:keepass /sftp/keepass/keepass && \
    echo "Match User keepass" >> /etc/ssh/sshd_config && \
    echo "    ChrootDirectory /sftp/sftp" >> /etc/ssh/sshd_config && \
    echo "    ForceCommand internal-sftp" >> /etc/ssh/sshd_config && \
    echo "    AllowTcpForwarding no" >> /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    echo 'keepass:$6$kgsqrLvJorL62Ox6$T7TkR4i7JF2eEv2g7aiuZroBkFfwEsTHrqXQAoYl7phwEmUuxG.r3IjPUiNoiOXxwnuS8ngFRJqyo2sf/0pGy/' | chpasswd -e

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
