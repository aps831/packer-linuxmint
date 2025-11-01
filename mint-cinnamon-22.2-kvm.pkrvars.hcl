_comment                = "Built with `packer build -var-file=mint-cinnamon-22.2-kvm.pkrvars.hcl .`"
box_tag                 = "aps831/mint-cinnamon-22.2"
box_version             = "1.0.0"
os_name                 = "linux-mint"
os_version              = "22.2"
os_version_description  = "Linux Mint 22.2"
os_arch                 = "x86_64"
iso_url                 = "https://mirrors.ukfast.co.uk/sites/linuxmint.com/isos/stable/22.2/linuxmint-22.2-cinnamon-64bit.iso"
iso_checksum            = "file:https://mirrors.edge.kernel.org/linuxmint/stable/22.2/sha256sum.txt"
boot_command            = [
    "<tab>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
    "<bs><bs><bs><bs><bs><bs><bs><bs>",
    "/casper/vmlinuz ",
    "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/mint-22-kvm.seed ",
    "boot=casper ",
    "initrd=/casper/initrd.lz ",
    "debug-ubiquity ",
    "automatic-ubiquity ",
    "noprompt ",
    "-- <enter>",
    "initrd /casper/initrd.lz<enter>",
    "boot<enter>"
]
