# Packer templates for Mint Cinnamon

## Overview

This repository contains Packer templates for creating Linux Mint Cinnamon Vagrant boxes.

## Building the Vagrant boxes with Packer

To build the KVM boxes, you will need [KVM](https://help.ubuntu.com/community/KVM/Installation) and [Vagrant-libvirt](https://vagrant-libvirt.github.io/vagrant-libvirt/) installed.

To upload a box to [Vagrantup](https://app.vagrantup.com/), a new Vagrant box must first be created through the user interface.

To build a specific box use the appropriate command from the taskfile, for example:

```bash
task build:kvm:21.3
```

### Acknowledgments

- [r-a-p-a](https://github.com/r-a-p-a)

- [ajxb](https://github.com/ajxb/packer-linuxmint)

- [rmoesbergen](https://github.com/rmoesbergen/packer-linuxmint)
