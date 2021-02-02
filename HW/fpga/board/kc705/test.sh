cd examples/
make clean
cd ../
make tests
rm -rf lowrisc-chip-imp
make project
make bitstream
make program
