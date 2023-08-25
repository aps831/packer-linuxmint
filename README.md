# Packer templates for Mint Cinnamon

## Overview

This repository contains Packer templates for creating Linux Mint Cinnamon Vagrant boxes.

## Current boxes

- [Linux Mint 18.2 (64-bit)](https://app.vagrantup.com/ajxb/boxes/mint-18.2)
- [Linux Mint 18.3 (64-bit)](https://app.vagrantup.com/ajxb/boxes/mint-18.3)
- [Linux Mint 19.0 (64-bit)](https://app.vagrantup.com/ajxb/boxes/mint-19.0)

## Building the Vagrant boxes with Packer

To build all the boxes, you will need [VirtualBox](https://www.virtualbox.org/wiki/Downloads). To build a specific box use the appropriate command from the taskfile, for example:

```bash
task build:21.1
```

## Contributing

1. Fork and clone the repo.
2. Create a new branch, please don't work in your `master` branch directly.
3. Fix stuff.
4. Update `README.md` and `AUTHORS` to reflect any changes.
5. If you have a large change in mind, it is still preferred that you split them into small commits. Good commit messages are important. The git documentation project has some nice guidelines on [writing descriptive commit messages](http://git-scm.com/book/ch5-2.html#Commit-Guidelines).
6. Push to your fork and submit a pull request.

### Acknowledgments

[r-a-p-a](https://github.com/r-a-p-a) for their work in providing the code on which this is based.
