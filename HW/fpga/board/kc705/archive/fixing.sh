#remove the previous project
rm -rf lowrisc-chip-imp/

#make a new one
make project

#synthesize the created design
#reset_run synth_1
#launch_runs impl_1 -to_step write_bitstream -jobs 8


#vivado lowrisc-chip-imp/lowrisc-chip-imp.xpr

