# Extreme-AP-7612-OpenWRT
Board files and config for compiling Extreme AP-7612 firmware OpenWRT

# 1.**boot initramfs
Connect to AP via uart on backside of device or port 2 telnet. Escape booting the Extreme OS via spamming any key in order to gain uboot prompt. 
setenv bootfile ipq.itb
setenv serverip [your tftp server ip] 
setenv ipaddress [another ip in the same subnet]
saveenv
tftpboot 0x85000000 ipq.itb 
bootm 0x85000000

After booting InitramFS, type the following (to make the wan port a LAN port.)
sed -i "/list ports 'lan'/a\        list ports 'wan'" /etc/config/network
/etc/init.d/network restart

#upload firmware through [gui](https://192.168.1.1/cgi-bin/luci/admin/system/flash)

# 2. Wipe and format rootfs1 as UBI
ubidetach -p /dev/mtd15 2>/dev/null
ubiformat /dev/mtd15 -y
ubiattach -p /dev/mtd15

# 3. Create the volumes U‑Boot expects
ubimkvol /dev/ubi0 -N kernel -s 6MiB #kernel volume
ubimkvol /dev/ubi0 -N rootfs -s 30MiB -t static #read only os
ubimkvol /dev/ubi0 -N rootfs_data -m -t dynamic #writable etc and stuff

# 4. Install the OS on the volumes
cd /tmp
tar -xf firmware.bin
ubiupdatevol /dev/ubi0_0 /tmp/sysupgrade-8dev_jalapeno/kernel
ubiupdatevol /dev/ubi0_1 /tmp/sysupgrade-8dev_jalapeno/root
sync
reboot -f
