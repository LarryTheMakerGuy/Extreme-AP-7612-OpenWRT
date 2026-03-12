# Extreme-AP-7612-OpenWRT
Board files and config for compiling Extreme AP-7612 firmware OpenWRT and compiled images.

# 1.Getting started
Connect to AP via uart on backside of device. The side closest to LEDS goes to Rx, the next pin over is empty, then TX, then ground.
Next connect your computer to the AP on the wan port (closest to the LEDs).

# 1.Get booted to initramfs
Powrer up the AP and escape to uboot prompt by spamming any key. Enter the following commands.
setenv serverip [your tftp server ip]

setenv ipaddress [another ip in the same subnet]

setenv bootargs 'root=/dev/ubiblock0_1 rootfstype=squashfs ubi.mtd=rootfs1'

setenv bootcmd 'ubi part rootfs1; ubi read 0x85000000 kernel 4952064; bootm 0x85000000;'

setenv mtdparts mtdparts=nand0:0xa480000@0x1b80000(rootfs1)

setenv mtdids nand0=nand0

setenv fdt_high 0x87000000

setenv fileaddr 85000000

setenv filesize 6AE12B

setenv mtddevname rootfs1

nand erase.part rootfs1 

saveenv

tftpboot 0x85000000 openwrt-ipq40xx-generic-ap7612-initramfs-uImage.itb

bootm 0x85000000


# 2. Install the OpenWRT on the AP
Open up your browser to https://192.168.1.1/cgi-bin/luci/admin/system/flash and select 'flash image.' Follow the prompts to upload the sysupgrade.bin image and click 'continue' to install Openwrt.
