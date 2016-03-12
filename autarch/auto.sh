size_boot="500M"
size_swap="500M"
size_sys="5G"
size_home="3G"
name_machine = "maires_b"
root_pd = "root"

loadkeys fr
echo "Attention veuillez faire Attention a ce que votre disque pour arch soit bien sda et non sdb ou sdc (\"$>lsblk\")\n"
sleep 5
echo "o\nn\np\n\n\n+$size_sys\nn\np\n\n\n+$size_boot\nn\np\n\n\n+$size_swap\nn\np\n\n\n+$size_home\nw\n" > part
fdisk /dev/sda < part
rm part
sleep 1
mkswap /dev/sda2
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4
swapon /dev/sda2
sleep 1
mount /dev/sda1 /mnt
mkdir /mnt/home
mount /dev/sda4 /mnt/home
mkdir /mnt/boot/
mount /dev/sda3 /mnt/boot
sleep 1
pacstrap base base-devel zip unzip p7zip vim mc alsa-utils syslog-ng
genfstab -U -p /mnt >> /mnt/etc/fstab
pacstrap /mnt grub os-prober
arch-chroot /mnt
/etc/hostname < echo $name_machine
locale.LANG=fr_FR.UTF-8
export LANG=fr_FR.UTF-8
export LC_TIME=fr_FR
echo "LANG=\"fr_FR.UTF-8\"" > /etc/locale.conf
echo "KEYMAP=fr" > /etc/vconsole.conf
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
mkinitcpio -p linux
sleep 1
grub-install --no-floppy --recheck /dev/sda
sleep 5
echo "$root_pd\n$root_pd\n" > passwd
exit
