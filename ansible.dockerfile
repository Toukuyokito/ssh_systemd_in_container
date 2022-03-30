FROM registry.fedoraproject.org/fedora:37

# Install ansible
RUN dnf install -y python3.10 python3-pip openssh-clients sshpass && \
    python3.10 -m pip install ansible && \
    dnf clean all

# Use systemd as command
CMD [ "tail", "-f", "/dev/null"]
