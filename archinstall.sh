ping google.com -c 2 && timedatectl set-ntp true && fdisk /dev/sda && mkfs.fat -F32 /dev/sda1 && mkfs.btrfs /dev/sda2  && mount /dev/sda2 /mnt &&
btrfs su cr /mnt/@
&&
btrfs su cr /mnt/@home
&&
btrfs su cr /mnt/@var
&&
btrfs su cr /mnt/@opt
&&
btrfs su cr /mnt/@tmp
&&
btrfs su cr /mnt/@.snapshots
&&
umount /mnt
&&
mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@ /dev/sda2 /mnt
&&
mkdir /mnt/{boot,home,var,opt,tmp,.snapshots}
&&
mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@home /dev/sda2 /mnt/home
&&
mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@opt /dev/sda2 /mnt/opt
&&
mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@tmp /dev/sda2 /mnt/tmp
&&
mount -o noatime,commit=120,compress=zstd,space_cache,subvol=@.snapshots /dev/sda2 /mnt/.snapshots
&&
mount -o subvol=@var /dev/sda2 /mnt/var
&&
mount /dev/sda1 /mnt/boot
&&
pacstrap /mnt base linux linux-firmware nano amd-ucode btrfs-progs
&& 
genfstab -U /mnt >> /mnt/etc/fstab
&&
arch-chroot /mnt
&&
ln -sf /usr/share/zoneinfo/Europe/Belgrade /etc/localtime
&&
hwclock --systohc
&&
nano /etc/locale.gen
&&
locale-gen
