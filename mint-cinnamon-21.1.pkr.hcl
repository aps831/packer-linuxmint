_comment = "Built with `packer build -var-file=mint-cinnamon-21.1.pkr.hcl core_template.pkr.hcl`"
boot_command_prefix = "<esc><wait>c<wait>"
box_tag = "aps831/mint-21.1"
disk_size = 20000
iso_checksum = "sha256:2df322f030d8ff4633360930a92d78829d10e515d2f6975b9bdfd1c0de769aca"
iso_url = "https://www.mirrorservice.org/sites/www.linuxmint.com/pub/linuxmint.com/stable/21.1/linuxmint-21.1-cinnamon-64bit.iso"
preseed = "mint-21.seed"
vagrantfile_template = "tpl/vagrantfile-mint-cinnamon-21.tpl"
version = "1.1.0"
version_description = "Linux Mint 21.1 with VirtualBox Guest Additions 6.1.38"
vm_name = "mint-cinnamon-21.1"