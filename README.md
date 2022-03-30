# Context

This projet contains a set of two images. These images was create to speed up the learning of ansible.

ansible.dockerfile : this image embedded ansible_core 

fedora_systemd_and_ssh.dockerfile : this image simulates target machine with systemd and ssh

# Warning

Don't use it in production. Using systemd and multiple services in container is not a good practice. Just use it for learning purpose.
# Requirement
podman version 3.0.1 =>

Why podman and not docker : because podman is more friendly with systemd in container
# Build images

```
# podman build -t fedora:fedora_systemd_and_ssh -f fedora_systemd_and_ssh.dockerfile
podman build -t fedora:ansible_core -f ansible.dockerfile
```
> Default user for fedora_systemd_and_ssh is ansible and password is default
# Run containers
## ansible_core
```
# podman container run -d registry.fedoraproject.org/fedora:ansible_core
```

## fedora_systemd_and_ssh 
```
# podman container run --cap-add AUDIT_WRITE -d registry.fedoraproject.org/fedora:systemd_and_ssh 
```

# Test

## Start containers
```
# podman container run registry.fedoraproject.org/fedora:ansible_core
64514d73e1c00113b8f5e1f7548551af1015c5287ea899b2f7d6714a505d3f47
```

```
podman container run --cap-add AUDIT_WRITE  -d --name machine --rm  registry.fedoraproject.org/fedora:systemd_and_ssh
f8917b4ce7986cdaec0bee0dbfe9491f533c20a04fe87ffa7c4d821952f041cd 
```

## Get ip of container machine

```json
# podman inspect machine | grep IP

           get ip here ->  "IPAddress": "172.16.16.36",
           "IPPrefixLen": 24,
           "IPv6Gateway": "",
           "GlobalIPv6Address": "",
           "GlobalIPv6PrefixLen": 0,
           "LinkLocalIPv6Address": "",
           "LinkLocalIPv6PrefixLen": 0,
           "IPAddress": "172.16.16.36",
           "IPPrefixLen": 24,
           "IPv6Gateway": "",
           "GlobalIPv6Address": "",
           "GlobalIPv6PrefixLen": 0,
           "IPAMConfig": null,
```
## Configure ansible

```
# podman exec -it ansible bash
```

```
# vi inventory

[test]
172.16.16.36

[test:vars]
ansible_ssh_user=ansible
ansible_ssh_pass=default
```

```
# export ANSIBLE_HOST_KEY_CHECKING=False
# ansible test -m ping -i inventory

expected results :

172.16.16.36 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

You can now deploy container for your test.