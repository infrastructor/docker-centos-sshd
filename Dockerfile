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
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
#RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
#RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
ADD authorized_keys /root/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
