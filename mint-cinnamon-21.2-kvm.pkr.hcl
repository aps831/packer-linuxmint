_comment = "Built with `packer build -var-file=mint-cinnamon-21.2-kvm.pkr.hcl core-template-kvm.pkr.hcl`"
boot_command_prefix = "<esc><wait>c<wait>"
box_tag = "aps831/mint-cinnamon-21.2"
disk_size = 20000
iso_checksum = "sha256:116578dda0e03f1421c214acdd66043b586e7afc7474e0796c150ac164a90a2a"
iso_url = "https://mirrors.ukfast.co.uk/sites/linuxmint.com/isos/stable/21.2/linuxmint-21.2-cinnamon-64bit.iso"
preseed = "mint-21-kvm.seed"
vagrantfile_template = "tpl/vagrantfile-mint-cinnamon-21-libvirt.tpl"
version = "1.1.0"
version_description = "Linux Mint 21.2"
vm_name = "mint-cinnamon-21.2"
