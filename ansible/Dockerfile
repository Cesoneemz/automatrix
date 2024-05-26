FROM debian:latest
RUN apt-get update && apt-get install -y \
    ansible \
    pacemaker \
    corosync \
    pcs \
    ruby \
    ruby-dev \
    build-essential \
#    supervisor \
    ssh \
    nginx \
    python3-pip \ 
    && gem install daemons \
    && apt-get clean
    
#RUN wget https://www.python.org/ftp/python/3.12.3/Python-3.12.3.tgz

#RUN tar xvf Python-3.12.3.tgz
#WORKDIR /Python-3.12.3/
#RUN ./configure --enable-optimization
#RUN make install
#WORKDIR /

RUN pip install supervisor --break-system-packages

COPY ./playbooks /ansible/playbooks

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN mkdir /var/run/sshd  # Создание необходимой директории

COPY ssh/* /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/corosync.conf /corosync.conf

COPY supervisord.conf /etc/supervisor/supervisord.conf

RUN /usr/bin/supervisord -c /etc/supervisor/supervisord.conf &

CMD ["/entrypoint.sh"]
# CMD ["ansible-playbook", "/ansible/playbooks/playbook_main.yml"]
# RUN ansible-playbook /ansible/playbooks/playbook_main.yml