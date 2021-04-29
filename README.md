# Lab 4 AK

## Start qemu

```sh
>> export KDIR=$HOME/repos/linux-stable                       
export INSTALL_MOD_PATH=~/repos/busybox/_install
export ARCH=arm
export PATH=/opt/gcc-arm-8.3-2019.03-x86_64-arm-linux-gnueabihf/bin:$PATH
export CROSS_COMPILE="ccache arm-linux-gnueabihf-"
>> make 
>> make qemu
```

## from another terminal

```sh
>> gdb-multiarch firmware.elf
>> target extended-remote:1234
>> layout regs 
```
