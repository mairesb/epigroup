size_boot="500M"
size_swap="500M"
size_sys="5G"
size_home="3G"

read -p "Attention veuillez faire Attention a ce que votre disque pour arch soit bien sda et non sdb ou sdc ("$>lsblk")\n"
echo "o\nn\np\n\n\n+$size_sys\nn\np\n\n\n+$size_boot\nn\np\n\n\n+$size_swap\nn\np\n\n\n+$size_home\nw\n" > part
fdisk /dev/sda < part
