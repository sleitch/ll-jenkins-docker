FROM ansible/centos7-ansible:stable

RUN yum -y install tar

#
# Add manager user (I choose 1005 as the manager on host uses that)
#
RUN useradd  -u 1005 -m -s /bin/bash manager


ENV MANAGER_HOME /home/manager


ADD devops.tar.gz "$MANAGER_HOME"
ADD provision.tar.gz :$MANAGER_HOME"


COPY devops.tar.gz /home/manager/devops.tar.gz
COPY provision.tar.gz /home/manager/provision.tar.gz
RUN echo "$MANAGER_HOME"
RUN echo ls "$MANAGER_HOME"


RUN tar -zxvf /home/manager/devops.tar.gz -C "$MANGER_HOME"/ && tar -zxvf $MANAGER_HOME/provision.tar.gz -C "$MANGER_HOME"/

RUN chown -R manager $MANAGER_HOME

USER manager 

CMD ["bash"]    


