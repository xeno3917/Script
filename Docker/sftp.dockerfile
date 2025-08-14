FROM alpine:latest

RUN apk add --no-cache openssh && \
    mkdir -p /sftp/keepass/keepass && \
    adduser -D -h /keepass keepass && \
    chown root:root /sftp /sftp/keepass && \
    chmod 755 /sftp /sftp/keepass && \
    chown keepass:keepass /sftp/keepass/keepass && \
    echo "Subsystem sftp internal-sftp" >> /etc/ssh/sshd_config && \
    echo "Match User keepass" >> /etc/ssh/sshd_config && \
    echo "    ChrootDirectory /sftp/keepass" >> /etc/ssh/sshd_config && \
    echo "    ForceCommand internal-sftp" >> /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    echo 'keepass:$6$kgsqrLvJorL62Ox6$T7TkR4i7JF2eEv2g7aiuZroBkFfwEsTHrqXQAoYl7phwEmUuxG.r3IjPUiNoiOXxwnuS8ngFRJqyo2sf/0pGy/' | chpasswd -e

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
