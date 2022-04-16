#!/bin/sh
# Color Definitions
green=$'\e[0;92m'
red=$'\e[0;91m'
blue=$'\e[0;34m'
reset=$'\e[0m'

# Connect to a network
echo "${blue}Configuring network connection${reset}"
iwctl station wlan0 scan
read -p "${blue}Enter your wifi name: ${reset}" wifi
while ! iwctl station wlan0 connect $wifi;do
	read -p "${red}Invalid wifi credentials. Enter wifi name again.${reset}" wifi
done
echo "${green}Successfully connected to wifi network $wifi ${reset}"

# Prepare drives for installation
echo "${blue}Preparing drives for installation${reset}"
echo "${blue}Enter your main drive from the list${reset}"
fdisk -l
read main_drive
fdisk $main_drive

read -p "${blue}Enter root partition: ${reset}" root
read -p "${blue}Enter efi partition: ${reset}" efi
mkfs.ext4 $root
mkfs.fat -F32 $efi
mount $root /mnt

# Prepare mirrors for installation
echo "${blue}Preparing mirrors for installation${reset}"
reflector -c india --protocol https --save /etc/pacman.d/mirrorlist
pacman -Syy archlinux-keyring --noconfirm
timedatectl set-ntp true

# Install base packages
echo "${blue}Installing basic packages${reset}"
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

echo "${blue}Generating post chroot installation script${reset}"
sed -n '/^# Post/,/^# PostEnds/p' $0 > /mnt/home/post_chroot.sh
chmod +x /mnt/home/post_chroot.sh
exit
# PreEnds

# Post

# Set timezone
ln -sf /usr/share/zoneinfo/Asia/Kathmandu /etc/localtime
hwclock --systohc

# Set locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

read -p "${blue}Enter your hostname: ${reset}" hostname

echo $hostname > /etc/hostname
echo "\
127.0.0.1	localhost
::1		localhost
127.0.0.1	$hostname.localdomain	$hostname" >> /etc/hosts

# Configure root and non root accounts
echo "${blue}Set root user password${reset}"
passwd
read -p "${blue}Enter your new username:${reset}" username
useradd -m $username
echo "${blue}Set your password${reset}"
passwd $username
useradd -aG wheel,audio,optical,video,storage $username
pacman -S sudo --noconfirm
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

# Configure boot options
pacman -S grub efibootmgr os-prober --noconfirm
mkdir /boot/EFI
read -p "Enter EFI partition: " efi
mount $efi /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

# Configure miscellaneous programs
echo "${blue}Installing miscellaneous programs${reset}"
sudo pacman -S mesa xf86-video-intel xf86-video-amdgpu git iwd dhcpcd python vim --noconfirm
systemctl enable iwd dhcpcd

read -p "${green}Done Installing Arch linux. Reboot?(Y/N)${reset}" reboot
if [ $reboot == "y" || $reboot == "Y" ];then
	reboot
fi

# PostEnds
