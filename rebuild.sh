#!/bin/bash

## ubuntu 22.04 lts
## 0.1 Install corss-compile-toochain
# sudo apt install gcc-arm-none-eabi

## 0.2 Dep
# sudo apt install flex bison
# sudo apt-get install libssl-dev
# sudo apt install u-boot-tools 

## 0.3 issue
# fdt error
# sudo apt-get purge -y --auto-remove libfdt-dev
export ARCH=arm
export CROSS_COMPILE=arm-none-eabi-

make clean && make distclean 
make s5pv210_fin_defconfig 
make LOADADDR=0x20004000 uImage -j$(nproc)
make dtbs -j$(nproc)

echo "copy to ../rootfs/"
sudo cp -vrf arch/arm/boot/uImage ../rootfs/
sudo cp -vrf arch/arm/boot/dts/s5pv210-smart210.dtb ../rootfs/
