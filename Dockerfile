FROM alpine
MAINTAINER Byron Sorgdrager <null@null.null>

RUN apk --update add sudo
RUN apk --update add python py-pip openssl ca-certificates
RUN apk --update add --virtual build-dependencies python-dev libffi-dev openssl-dev build-base
RUN apk --update add sshpass openssh-client nginx
RUN pip install --upgrade pip cffi
RUN pip install ansible         
RUN apk add --no-cache openssh
RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config 
RUN echo "root:root" | chpasswd
RUN ssh-keygen -A
RUN /usr/sbin/sshd 
RUN mkdir -p /etc/ansible
RUN echo 'localhost' > /etc/ansible/hosts

ENTRYPOINT /usr/sbin/sshd && /bin/sh
