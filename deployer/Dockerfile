FROM ansible/centos7-ansible:stable

RUN yum -y install tar

#
# Add manager user (I choose 1005 as the manager on host uses that)
#
RUN useradd  -u 1005 -m -s /bin/bash manager


ENV MANAGER_HOME /home/manager


COPY devops.tar.gz "$MANAGER_HOME"/devops.tar.gz
COPY provision.tar.gz "$MANAGER_HOME"/provision.tar.gz


RUN tar -zxvf  devops.tar.gz -C "$MANAGER_HOME" / && utar -zxvf  provision.tar.gz -C "$MANAGER_HOME"/
    
    
USER manager

