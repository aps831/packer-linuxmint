# Packer templates for Mint Cinnamon

## Overview

This repository contains Packer templates for creating Linux Mint Cinnamon Vagrant boxes.

## Building the Vagrant boxes with Packer

To build the KVM boxes, you will need [KVM](https://help.ubuntu.com/community/KVM/Installation) and [Vagrant-libvirt](https://vagrant-libvirt.github.io/vagrant-libvirt/) installed.

To upload a box to [Vagrantup](https://app.vagrantup.com/), a new Vagrant box must first be created through the user interface.

To build a specific box use the appropriate command from the taskfile, for example:

```bash
task build:kvm:22.2
```

## Updates

A search and replace on the Linux Mint version number will do the majority of the heavy lifting. In `http/mint-22-kvm.seed` there is a hack to add a task to `rc.local` which installs `openssh-server` once the network becomes available after reboot. It may be necessary to update this script to correctly identify the network.

## Acknowledgments

Updated using chef/bento project from other projects.

- [bento](https://github.com/chef/bento)

- [r-a-p-a](https://github.com/r-a-p-a)

- [ajxb](https://github.com/ajxb/packer-linuxmint)

- [rmoesbergen](https://github.com/rmoesbergen/packer-linuxmint)
