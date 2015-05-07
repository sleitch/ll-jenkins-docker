FROM ansible/centos7-ansible:stable

RUN yum -y update; yum clean all
RUN yum -y install tar openssh-server passwd; yum clean all


#
# Add manager user (I choose 1005 as the manager on host uses that)
#
RUN useradd  -u 1005 -m -s /bin/bash manager


ENV MANAGER_HOME /home/manager


ADD devops.tar.gz /home/manager/
ADD provision.tar.gz "$MANAGER_HOME"


#COPY devops.tar.gz /home/manager/devops.tar.gz
#COPY provision.tar.gz /home/manager/provision.tar.gz
#RUN echo "$MANAGER_HOME"
#RUN echo ls "$MANAGER_HOME"


#RUN tar -zxvf /home/manager/devops.tar.gz -C "$MANGER_HOME"/ && tar -zxvf $MANAGER_HOME/provision.tar.gz -C "$MANGER_HOME"/

RUN chown -R manager $MANAGER_HOME




ADD ./start.sh /start.sh
RUN mkdir /var/run/sshd

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

RUN chmod 755 /start.sh
# EXPOSE 22
RUN ./start.sh

USER manager 

ENTRYPOINT ["/usr/sbin/sshd", "-D"]




