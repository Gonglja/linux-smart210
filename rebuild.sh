#!/bin/bash
export ARCH=arm
export CROSS_COMPILE=arm-none-eabi-

make clean && make distclean 
make s5pv210_fin_defconfig 
make LOADADDR=0x20008000 uImage -j12
make dtbs

echo "copy to ../rootfs/"
sudo cp -vrf arch/arm/boot/uImage ../rootfs/
sudo cp -vrf arch/arm/boot/dts/s5pv210-smart210.dtb ../rootfs/
