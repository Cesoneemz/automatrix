FROM debian:latest

RUN apt-get update && apt-get install -y openssh-server python3-pip supervisor
RUN mkdir -p /var/run/sshd /var/log/supervisor
COPY nginx.conf /etc/nginx/nginx.conf

# Конфигурация supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY ssh/* /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa

RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

CMD ["/usr/bin/supervisord"]