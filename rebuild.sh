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

# 0.4 配置编译链环境
export ARCH=arm
export CROSS_COMPILE=arm-none-eabi-

# 0.5  清除以前编译
make clean && make distclean


# 1.0 配置s5pv210默认配置
make s5pv210_fin_defconfig

# 1.1 编译 uImage
make LOADADDR=0x20004000 uImage -j$(nproc)

# 1.2 编译 modules 并安装至./output下
make modules -j$(nproc)
make INSTALL_MOD_PATH=./output modules_install

# 1.3 编译 dtbs 并安装至./output下
make dtbs -j$(nproc)
make INSTALL_DTBS_PATH=./output dtbs_install 


echo "copy to ../rootfs/"
sudo cp -vrf arch/arm/boot/uImage ../rootfs/
sudo cp -vrf arch/arm/boot/dts/s5pv210-smart210.dtb ../rootfs/
