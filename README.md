# Lab 4 AK

## Start qemu

```sh
>> PATH=$PATH:~/opt/xPacks/qemu-arm/2.8.0-7/bin/
>> make 
>> make qemu
```

## from another terminal

```sh
>> export KDIR=$HOME/repos/linux-stable                       
export INSTALL_MOD_PATH=~/repos/busybox/_install
export ARCH=arm
export PATH=/opt/gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf/bin:$PATH
export CROSS_COMPILE="ccache arm-linux-gnueabihf-"
>> gdb-multiarch firmware.elf
>> target extended-remote:1234
>> layout regs 
```
