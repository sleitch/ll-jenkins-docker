#########################################################################################
#
#
#			Docker for: Leisurelink - Deployer - Anisble PLaybooks
#
#		    Installs:	ansible/ubuntu14.04; Java JDK; Jenkins; Ruby; Saas
#
#
#########################################################################################
FROM ansible/ubuntu14.04-ansible:stable
MAINTAINER Stuart Leitch <sleitch@credera.com>

#
# Add manager user (I choose 1005 as the manager on host uses that)
#
RUN groupadd manager
RUN useradd -g manager -u 1005 -m -s /bin/bash manager

ENV MANAGER_HOME /home/manager

#
# NB: tar files are automatically extracted by ADD cmd
#
ADD devops.tar.gz  $MANAGER_HOME 
ADD provision.tar.gz $MANAGER_HOME


#RUN  -zxvf /home/manager/devops.tar.gz -C "$MANGER_HOME"/ && tar -zxvf $MANAGER_HOME/provision.tar.gz -C "$MANGER_HOME"/

RUN  tar -xvf $MANAGER_HOME/provision/dev/dev-manager.tar && $MANAGER_HOME/provision/dev/create-manager.sh

RUN chown -R manager $MANAGER_HOME

#USER manager 

#
# Get SSH running - might come in handy...
#
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:testing' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]