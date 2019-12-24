FROM oraclelinux:latest
MAINTAINER michael.chanslor@gmail.com

RUN yum -y install openssh-server net-tools && \
    mkdir /var/run/sshd

ADD sshd_config /etc/ssh/sshd_config
ADD ssh_host_rsa_key.pub /etc/ssh/ssh_host_rsa_key.pub
ADD ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
ADD create.bash /usr/sbin/create.bash

RUN /usr/bin/chgrp ssh_keys /etc/ssh/ssh_host_rsa_key
RUN /usr/bin/chmod 640 /etc/ssh/ssh_host_rsa_key
RUN /usr/bin/chmod 644 /etc/ssh/ssh_host_rsa_key.pub
RUN /usr/sbin/create.bash


RUN echo root:root | chpasswd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

RUN ssh-keygen -t rsa -b 4096 -f /root/.ssh/id_rsa -C "My container key" -N ""

RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeitOJI+ncEww0dDCVrpL+unlUp+X1EIqzCT9ys+PmQTSZDwjLjBteQYqIoXrhFf51laHuYgwLZhBy46wHnn/Kpvl2PRhDSaNtTxnXk3ot0B/g8CI2z3/gs+tyxK1kITGf22tTeRKV1EhG24KjWRnEt/bi9V5da44Y9axGgmtiOBdZncSqq5Wap4Sgb1USNai6gQMUHhrw8uIzRDNTrwvKKZXZIzDMokFns75LhWj8CE6bRkwTZIKEtXO9GuXOUqyqHBCa8YtgK9o+J+I+U6xI9DA2sOePvQ62JMaYtEdbm39bcbwwjRQSrCbfCIqQSXczgXjjSsl92JEIB+Lu0g/r lsnahcdm@lnx" > /root/.ssh/authorized_keys

# docker build -t chanslor/sshd .
# docker run -d -it --name sshd --hostname sshd -p 2222:22 chanslor/sshd
# docker inspect -f '{{ .NetworkSettings.IPAddress }}' sshd
# ssh root@<ip from above command>

