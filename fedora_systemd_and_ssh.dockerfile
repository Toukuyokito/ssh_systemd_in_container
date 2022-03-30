FROM registry.fedoraproject.org/fedora:37

RUN dnf install -y systemd openssh-server iproute sudo openssl && dnf clean all
RUN adduser ansible -p `openssl passwd default` && \
    echo -n "ansible ALL=(ALL:ALL) ALL" > /etc/sudoers.d/ansible

#Allow ssh in container
RUN sed -i -E 's/session\s+required\s+pam_loginuid\.so/#session required pam_loginuid.so/g' /etc/pam.d/sshd

RUN systemctl enable sshd
EXPOSE 22

CMD [ "/usr/sbin/init" ]

