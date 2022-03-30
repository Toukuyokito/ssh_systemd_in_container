## Context

This projet contain a set of two images. These images was create to speed up the learning of ansible.

ansible.dockerfile : this image embeted ansible 

fedora_systemd_and_ssh.dockerfile : this image simulate target machine with systemd and ssh.

## Requirement
podman version 3.0.1 =>

Why podman and not docker : beacause podman is more friendly whith systemd in container
## Build

```
podman  build -t fedora:fedora_systemd_and_ssh -f fedora_systemd_and_ssh.dockerfile
podman  build -t fedora:ansible_core -f ansible.dockerfile
```

## Test
## 