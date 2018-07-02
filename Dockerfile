FROM centos:7
MAINTAINER infrastructor.io

#RUN yum update
RUN yum install sudo openssh-server openssh-client -y
RUN mkdir /var/run/sshd
RUN useradd -ms /bin/bash devops

RUN echo 'devops:devops' | chpasswd
RUN echo 'root:infra' | chpasswd
RUN echo 'devops    ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
ADD authorized_keys /root/.ssh/authorized_keys
ADD authorized_keys /home/devops/.ssh/authorized_keys
RUN chown -R devops:devops /home/devops
RUN chmod 600 /root/.ssh/authorized_keys
RUN chmod 600 /home/devops/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
