ARG ALPINE_VERSION=3.20
FROM alpine:$ALPINE_VERSION
LABEL maintainer="Andrea Zuccherelli <andrea@zuccherelli.net>"
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache \
    python3 \
    py3-pip \
    openssh \
    bash \
    sudo \
    && python3 --version \
    && pip --version \
    && ssh-keygen -A \
    && adduser vagrant -h /home/vagrant -s /bin/sh -D vagrant \
    && mkdir /home/vagrant/work

# Setup Vagrant pubkey
WORKDIR /home/vagrant/work
COPY sshd_config sshsetup.sh vagrant.pub .
RUN ./sshsetup.sh \
    /home/vagrant \
    "$(cat vagrant.pub)" \
    vagrant vagrant \
    && mv -f sshd_config /etc/ssh/sshd_config	
# https://www.engineyard.com/blog/building-a-vagrant-box-from-start-to-finish/
# no password for vagrant user sudo
RUN echo "vagrant ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers.d/vagrant
RUN sed -Ei 's|(vagrant):([^:]*):(.*)|\1:\*:\3|g' /etc/shadow \
    && rm -rf /home/vagrant/work \
    && chmod u+s /usr/sbin/sshd
EXPOSE 22

USER vagrant
WORKDIR /home/vagrant

# Install Ansible
RUN mkdir ansible-ee \
    && python3 -m venv ansible-ee \
    && . ansible-ee/bin/activate \
    && echo "VIRTUAL_ENV=$VIRTUAL_ENV" \
    && pip install ansible-core \
    && pip list

ENTRYPOINT [ "/bin/bash", "-c", "/usr/sbin/sshd -D & source ansible-ee/bin/activate && eval $@", "shellinit" ]
CMD [ "/bin/bash" ]
