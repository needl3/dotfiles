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
useradd -aG wheel,audio,optical,video,storage -s /bin/bash $username
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
sudo pacman -S mesa xf86-video-intel xf86-video-amd git iwd dhcpcd python vim --noconfirm
systemctl enable iwd dhcpcd

read -p "${green}Done Installing Arch linux. Reboot?(Y/N)${reset}" reboot
if [ $reboot == "y" || $reboot == "Y" ];then
	reboot
fi

# PostEnds
