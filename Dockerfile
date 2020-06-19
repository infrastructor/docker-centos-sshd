FROM centos:7
MAINTAINER infrastructor.io

RUN yum install sudo openssh-server openssh-client -y
RUN mkdir /var/run/sshd
RUN useradd -ms /bin/bash devops
RUN useradd -ms /bin/bash sudops

RUN echo 'devops:devops' | chpasswd
RUN echo 'sudops:sudops' | chpasswd
RUN echo 'root:infra' | chpasswd

ADD sudoers /etc/sudoers

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
RUN sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config
RUN sed -i 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/' /etc/ssh/sshd_config

ADD authorized_keys /root/.ssh/authorized_keys
ADD authorized_keys /home/devops/.ssh/authorized_keys
ADD authorized_keys /home/sudops/.ssh/authorized_keys

RUN chown -R devops:devops /home/devops
RUN chown -R sudops:sudops /home/sudops

RUN chmod 600 /root/.ssh/authorized_keys
RUN chmod 600 /home/devops/.ssh/authorized_keys
RUN chmod 600 /home/sudops/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
