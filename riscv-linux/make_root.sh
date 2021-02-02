#rm initramfs.cpio
rm vmlinux
if [ -f .config ]; then echo configured; else make ARCH=riscv defconfig; fi
#make -C ../debian-riscv64 cpio
scripts/dtc/dtc arch/riscv/kernel/lowrisc.dts -O dtb -o arch/riscv/kernel/lowrisc.dtb
rm -f arch/riscv/kernel/head.o
make ARCH=riscv -j 8 CROSS_COMPILE=riscv64-unknown-linux-gnu- CONFIG_INITRAMFS_SOURCE="initramfs.cpio"
mkdir -p ../HW/rocket-chip/riscv-tools/riscv-pk/build
( cd ../HW/rocket-chip/riscv-tools/riscv-pk/build; ../configure --prefix=$RISCV --host=riscv64-unknown-elf --with-payload=../../../../../riscv-linux/vmlinux --enable-logo --enable-print-device-tree)
rm -f ../HW/rocket-chip/riscv-tools/riscv-pk/build/payload.o
make -C ../HW/rocket-chip/riscv-tools/riscv-pk/build
cp -p ../HW/rocket-chip/riscv-tools/riscv-pk/build/bbl ../HW/fpga/board/kc705/boot.bin
riscv64-unknown-elf-strip ../HW/fpga/board/kc705/boot.bin
#riscv64-unknown-elf-objdump -d -S -l vmlinux >vmlinux.dis &
#riscv64-unknown-elf-objdump -d -l -S ../rocket-chip/riscv-tools/riscv-pk/build/bbl >../rocket-chip/riscv-tools/riscv-pk/build/bbl.dis
