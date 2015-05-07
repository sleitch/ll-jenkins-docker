FROM ansible/centos7-ansible:stable

RUN yum -y update; yum clean all
RUN yum -y install tar openssh-server passwd; yum clean all


#
# Add manager user (I choose 1005 as the manager on host uses that)
#
RUN groupadd manager
RUN useradd -g manager -u 1005 -m -s /bin/bash manager


ENV MANAGER_HOME /home/manager


ADD devops.tar.gz  $MANAGER_HOME 
ADD provision.tar.gz /home/manager/E


#COPY devops.tar.gz /home/manager/devops.tar.gz
#COPY provision.tar.gz /home/manager/provision.tar.gz
#RUN echo "$MANAGER_HOME"
#RUN echo ls "$MANAGER_HOME"


#RUN tar -zxvf /home/manager/devops.tar.gz -C "$MANGER_HOME"/ && tar -zxvf $MANAGER_HOME/provision.tar.gz -C "$MANGER_HOME"/

RUN chown -R manager $MANAGER_HOME


RUN  /etc/init.d/sshd start

RUN echo 'manager:secret' | chpasswd
RUN echo '%manager ALL=(ALL) ALL' >> /etc/sudoers

RUN mkdir -p /home/manager/.ssh
ADD authorized_keys /home/manager/.ssh/
RUN chown -R manager:manager /home/manager/.ssh; chmod 700 /home/manager/.ssh

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]

USER manager 

