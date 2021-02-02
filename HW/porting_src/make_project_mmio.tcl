# Xilinx Vivado script
# Version: Vivado 2015.4
# Function:
#   Generate a vivado project for the lowRISC SoC

set mem_data_width {64}
set io_data_width {32}
set axi_id_width {4}

set origin_dir "."
set base_dir "../../../porting_src"
set common_dir "../../common"

set project_name [lindex $argv 0]
set CONFIG [lindex $argv 1]

# Set the directory path for the original project from where this script was exported
set orig_proj_dir [file normalize $origin_dir/$project_name]

# Create project
create_project $project_name $origin_dir/$project_name

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# # Set project properties
# set obj [current_project]
# set_property "default_lib" "xil_defaultlib" $obj

set obj [get_projects $project_name]
set_property "default_lib" "xil_defaultlib" $obj
set_property "board_part" "xilinx.com:kc705:part0:1.1" $obj
set_property "simulator_language" "Mixed" $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# ###############################################################################
# included below
               # [file normalize $base_dir/src/main/verilog/chip_top.sv] \
               # [file normalize $base_dir/src/main/verilog/periph_soc.sv] \
# ###############################################################################

            # [file normalize $base_dir/src/main/verilog/RISC_V_TOP_wrapper.sv] \
			# [file normalize $base_dir/src/main/verilog/chip_top_mod_wrapper_wrapper.v] \
# ###############################################################################


# Set 'sources_1' fileset object
set files [list \
               [file normalize $base_dir/../rocket-chip/vsim/generated-src/freechips.rocketchip.system.$CONFIG.v] \
               [file normalize $base_dir/src/main/verilog/chip_top_mmio_port.sv] \
               [file normalize $base_dir/src/main/verilog/periph_soc_mod.sv] \
               [file normalize $base_dir/src/main/verilog/framing_top_mii.sv] \
               [file normalize $base_dir/src/main/verilog/axis_gmii_rx.v] \
               [file normalize $base_dir/src/main/verilog/axis_gmii_tx.v] \
               [file normalize $base_dir/src/main/verilog/lfsr.v] \
               [file normalize $base_dir/src/main/verilog/rx_delay.v] \
               [file normalize $base_dir/src/main/verilog/ps2.v] \
               [file normalize $base_dir/src/main/verilog/ps2_keyboard.v] \
               [file normalize $base_dir/src/main/verilog/ps2_translation_table.v] \
               [file normalize $base_dir/src/main/verilog/my_fifo.v] \
               [file normalize $base_dir/src/main/verilog/fstore2.v] \
               [file normalize $base_dir/src/main/verilog/dualmem.v] \
               [file normalize $base_dir/src/main/verilog/uart.v] \
               [file normalize $base_dir/src/main/verilog/sd_top.sv] \
               [file normalize $base_dir/src/main/verilog/sd_crc_7.v] \
               [file normalize $base_dir/src/main/verilog/sd_crc_16.v] \
               [file normalize $base_dir/src/main/verilog/sd_cmd_serial_host.v] \
               [file normalize $base_dir/src/main/verilog/sd_data_serial_host.sv] \
               [file normalize $base_dir/src/main/verilog/nasti_channel.sv] \
               [file normalize $base_dir/vsrc/AsyncResetReg.v ] \
               [file normalize $base_dir/vsrc/plusarg_reader.v ] \
               [file normalize $base_dir/src/main/verilog/ascii_code.v] \
               [file normalize $base_dir/src/main/verilog/axis_gmii_rx.v] \
               [file normalize $base_dir/src/main/verilog/axis_gmii_tx.v] \
               [file normalize $base_dir/src/main/verilog/dualmem_32K_64.sv] \
               [file normalize $base_dir/src/main/verilog/dualmem.v] \
               [file normalize $base_dir/src/main/verilog/dualmem_widen.v] \
               [file normalize $base_dir/src/main/verilog/dualmem_widen8.v] \
               [file normalize $base_dir/src/main/verilog/eth_lfsr.v] \
               [file normalize $base_dir/src/main/verilog/fpga_srams_generate.sv] \
               [file normalize $base_dir/src/main/verilog/my_fifo.v] \
               [file normalize $base_dir/src/main/verilog/rachelset.v] \
               [file normalize $base_dir/src/main/verilog/stubs.sv] \
            ]
add_files -norecurse -fileset [get_filesets sources_1] $files

# add include path
set_property include_dirs [list \
                               [file normalize $base_dir/src/main/verilog] \
                               [file normalize $origin_dir/src ]\
                               [file normalize $origin_dir/generated-src] \
                              ] [get_filesets sources_1]

set_property verilog_define [list FPGA FPGA_FULL KC705] [get_filesets sources_1]

# Set 'sources_1' fileset properties
# set_property "top" "chip_top_without_mig_clkwiz" [get_filesets sources_1]
# set_property "top" "RISC_V_TOP_wrapper" [get_filesets sources_1]



#Dummy BRAM Controller
create_ip -name axi_bram_ctrl -vendor xilinx.com -library ip -module_name axi_bram_ctrl_dummy
set_property -dict [list \
                        CONFIG.DATA_WIDTH $mem_data_width \
                        CONFIG.ID_WIDTH $axi_id_width \
                        CONFIG.MEM_DEPTH {32768} \
                        CONFIG.PROTOCOL {AXI4} \
                        CONFIG.BMG_INSTANCE {EXTERNAL} \
                        CONFIG.SINGLE_PORT_BRAM {1} \
                        CONFIG.SUPPORTS_NARROW_BURST {1} \
                       ] [get_ips axi_bram_ctrl_dummy]
generate_target {instantiation_template} \
    [get_files $proj_dir/$project_name.srcs/sources_1/ip/axi_bram_ctrl_dummy/axi_bram_ctrl_dummy.xci]



# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set files [list [file normalize "$origin_dir/constraint/pin_plan.xdc"] \
          [file normalize "$origin_dir/constraint/timing.xdc"]]

set file_added [add_files -norecurse -fileset $obj $files]

# generate all IP source code
generate_target all [get_ips]

# force create the synth_1 path (need to make soft link in Makefile)
launch_runs -scripts_only synth_1



# suppress some not very useful messages
# warning partial connection
set_msg_config -id "\[Synth 8-350\]" -suppress
# info do synthesis
set_msg_config -id "\[Synth 8-256\]" -suppress
set_msg_config -id "\[Synth 8-638\]" -suppress
# BRAM mapped to LUT due to optimization
set_msg_config -id "\[Synth 8-3969\]" -suppress
# BRAM with no output register
set_msg_config -id "\[Synth 8-4480\]" -suppress
# DSP without input pipelining
set_msg_config -id "\[Drc 23-20\]" -suppress
# Update IP version
set_msg_config -id "\[Netlist 29-345\]" -suppress

# do not flatten design
set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]

#synth_design -verilog_define name=FPGA -verilog_define name=FPGA_FULL -verilog_define name=KC705





# ####################
#  Block Design start 
#  create Clock generator & memory controller ip together at the same time.
# ####################

create_bd_design "RISC_V_SOC"
current_bd_design "RISC_V_SOC"


set_property generate_synth_checkpoint 0 [get_files axi_bram_ctrl_dummy.xci]
# set_property generate_synth_checkpoint 0 [get_files axi_clock_converter_0.xci]

# add_files -norecurse -scan_for_includes /home/uho/workspace/lowriscv_chip/HW/porting_src/src/main/verilog/chip_top_mod_wrapper.v
# import_files -norecurse /home/uho/workspace/lowriscv_chip/HW/porting_src/src/main/verilog/chip_top_mod_wrapper.v
add_files -norecurse -scan_for_includes /home/uho/workspace/lowriscv_chip_wo_interconnect/HW/porting_src/src/main/verilog/chip_top_mod_wrapper_mmio_port.v
import_files -norecurse /home/uho/workspace/lowriscv_chip_wo_interconnect/HW/porting_src/src/main/verilog/chip_top_mod_wrapper_mmio_port.v
update_compile_order -fileset sources_1

set_property "top" "chip_top_mod_wrapper" [get_filesets sources_1]

# update_compile_order -fileset sources_1

startgroup
  set_property source_mgmt_mode All [current_project]

  #create block module cells
  create_bd_cell -type module -reference chip_top_mod_wrapper_mmio_port chip_top_mod_wrapper_0
  create_bd_cell -type ip -vlnv xilinx.com:ip:mig_7series mig_7series_0
  create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
  create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_1
  
  
  #create external ports(described in .xdc file)
  create_bd_port -dir I                        clk_p    
  create_bd_port -dir I                        clk_n    
  create_bd_port -dir I                        rst_top      

  #Mig interface
  create_bd_port -dir IO  -from 63    -to 0    ddr_dq
  create_bd_port -dir IO  -from 7     -to 0    ddr_dqs_n
  create_bd_port -dir IO  -from 7     -to 0    ddr_dqs_p
  create_bd_port -dir O   -from 13    -to 0    ddr_addr
  create_bd_port -dir O   -from 2     -to 0    ddr_ba
  create_bd_port -dir O                        ddr_ras_n
  create_bd_port -dir O                        ddr_cas_n
  create_bd_port -dir O                        ddr_we_n
  create_bd_port -dir O                        ddr_reset_n
  create_bd_port -dir O                        ddr_ck_n
  create_bd_port -dir O                        ddr_ck_p
  create_bd_port -dir O                        ddr_cke
  create_bd_port -dir O                        ddr_cs_n
  create_bd_port -dir O   -from 7     -to 0    ddr_dm
  create_bd_port -dir O                        ddr_odt

  #Simple UART interface
  create_bd_port -dir I                        rxd         
  create_bd_port -dir O                        txd         
  create_bd_port -dir O                        rts         
  create_bd_port -dir I                        cts

  #4-bit full SD interface
  create_bd_port -dir IO                       sd_sclk     
  create_bd_port -dir I                        sd_detect   
  create_bd_port -dir IO  -from 3     -to 0    sd_dat      
  create_bd_port -dir IO                       sd_cmd      
  create_bd_port -dir O                        sd_reset 
  
  # LED and DIP switch
  create_bd_port -dir O   -from 7     -to 0    o_led    
  create_bd_port -dir I   -from 3     -to 0    i_dip    
  
  #push button array
  create_bd_port -dir I                        GPIO_SW_C      
  create_bd_port -dir I                        GPIO_SW_W      
  create_bd_port -dir I                        GPIO_SW_E      
  create_bd_port -dir I                        GPIO_SW_N      
  create_bd_port -dir I                        GPIO_SW_S      

  #keyboard
  create_bd_port -dir IO                       PS2_CLK     
  create_bd_port -dir IO                       PS2_DATA 

  #Ethernet MAC PHY interface signals
  create_bd_port -dir I                        i_erx_dv 
  create_bd_port -dir I                        i_erx_er 
  create_bd_port -dir I                        i_emdint 
  create_bd_port -dir O -type data             o_erefclk   
  create_bd_port -dir O -type data             o_etx_en 
  
  #KC705   
  create_bd_port -dir I   -from 3     -to 0       i_erxd      
  create_bd_port -dir O -type data -from 7 -to 0  o_etxd      
  create_bd_port -dir O -type data                o_etx_er 
  create_bd_port -dir I                           i_gmiiclk_p 
  create_bd_port -dir I                           i_gmiiclk_n 
  create_bd_port -dir I                           i_erx_clk   
  create_bd_port -dir I                           i_etx_clk   
           
  create_bd_port -dir O                           o_emdc      
  create_bd_port -dir IO                          io_emdio    
  create_bd_port -dir O                           o_erstn  

set_property CONFIG.XML_INPUT_FILE [file normalize /home/uho/workspace/lowriscv_chip/HW/fpga/board/kc705/script/mig_config.prj] [get_bd_cells mig_7series_0]

set_property -dict [list \
  CONFIG.RESET_BOARD_INTERFACE {Custom} \
  CONFIG.CLK_IN1_BOARD_INTERFACE {Custom} \
  CONFIG.CLK_IN2_BOARD_INTERFACE {Custom} \
  CONFIG.PRIM_SOURCE {Global_buffer} \
  CONFIG.RESET_BOARD_INTERFACE {reset} \
  CONFIG.RESET_TYPE {ACTIVE_HIGH} \
  CONFIG.PRIM_SOURCE {GLobal_buffer} \
  CONFIG.PRIM_IN_FREQ {200.000} \
  CONFIG.MMCM_DIVCLK_DIVIDE {1} \
  CONFIG.RESET_PORT {reset} \
  CONFIG.PRIMITIVE {PLL} \
  CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {200.000} \
  CONFIG.RESET_TYPE {ACTIVE_HIGH} \
  CONFIG.CLKOUT1_DRIVES {BUFG} \
  CONFIG.MMCM_DIVCLK_DIVIDE {1} \
  CONFIG.MMCM_COMPENSATION {ZHOLD} \
  CONFIG.RESET_PORT {reset} \
  CONFIG.CLKOUT2_DRIVES {BUFG} \
  CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {50.000} \
  CONFIG.CLKOUT2_USED {1} \
  CONFIG.CLK_OUT2_PORT {clk_cpu} \
  CONFIG.CLKOUT3_DRIVES {BUFG} \
  CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {120.000} \
  CONFIG.CLKOUT3_USED {1} \
  CONFIG.CLK_OUT3_PORT {clk_pixel} \
  CONFIG.CLKOUT4_USED {1} \
  CONFIG.CLKOUT4_DRIVES {BUFG} \
  CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {25.000} \
  CONFIG.CLK_OUT4_PORT {clk_mii} \
  CONFIG.CLKOUT5_USED {1} \
  CONFIG.CLKOUT5_DRIVES {BUFG} \
  CONFIG.CLKOUT5_REQUESTED_OUT_FREQ {25.000} \
  CONFIG.CLKOUT5_REQUESTED_PHASE {90.000} \
  ] [get_bd_cells clk_wiz_0]

  # CONFIG.PRIM_IN_FREQ {25.000} \

set_property -dict [list \
  CONFIG.PRIMITIVE {MMCM} \
  CONFIG.USE_DYN_RECONFIG {true} \
  CONFIG.INTERFACE_SELECTION {Enable_DRP} \
  CONFIG.PRIM_IN_FREQ {50.000} \
  CONFIG.CLK_OUT1_PORT {clk_sdclk} \
  CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {5.000} \
  CONFIG.PHASE_DUTY_CONFIG {false} \
  CONFIG.CLKIN1_JITTER_PS {400.0} \
  CONFIG.CLKOUT1_DRIVES {BUFG} \
  CONFIG.CLKOUT2_DRIVES {BUFG} \
  CONFIG.CLKOUT3_DRIVES {BUFG} \
  CONFIG.CLKOUT4_DRIVES {BUFG} \
  CONFIG.CLKOUT5_DRIVES {BUFG} \
  CONFIG.CLKOUT6_DRIVES {BUFG} \
  CONFIG.CLKOUT7_DRIVES {BUFG} \
  CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
  CONFIG.MMCM_DIVCLK_DIVIDE {1} \
  CONFIG.MMCM_CLKFBOUT_MULT_F {25.500} \
  CONFIG.MMCM_CLKIN1_PERIOD {40.0} \
  CONFIG.MMCM_COMPENSATION {ZHOLD} \
  CONFIG.MMCM_CLKOUT0_DIVIDE_F {127.500} \
  CONFIG.CLKOUT1_JITTER {652.674} \
  CONFIG.CLKOUT1_PHASE_ERROR {319.966}
  ] [get_bd_cells clk_wiz_1]
  
save_bd_design

  # port mapping
  # external<=>mig_7
  connect_bd_net [get_bd_ports clk_p        ] [get_bd_pins mig_7series_0/sys_clk_p   		]
  connect_bd_net [get_bd_ports clk_n        ] [get_bd_pins mig_7series_0/sys_clk_n   		]
  connect_bd_net [get_bd_ports rst_top      ] [get_bd_pins mig_7series_0/sys_rst     		]
  connect_bd_net [get_bd_ports ddr_dq       ] [get_bd_pins mig_7series_0/ddr3_dq      		]
  connect_bd_net [get_bd_ports ddr_dqs_n    ] [get_bd_pins mig_7series_0/ddr3_dqs_n   		]
  connect_bd_net [get_bd_ports ddr_dqs_p    ] [get_bd_pins mig_7series_0/ddr3_dqs_p   		]
  connect_bd_net [get_bd_ports ddr_addr     ] [get_bd_pins mig_7series_0/ddr3_addr    		]
  connect_bd_net [get_bd_ports ddr_ba       ] [get_bd_pins mig_7series_0/ddr3_ba      		]
  connect_bd_net [get_bd_ports ddr_ras_n    ] [get_bd_pins mig_7series_0/ddr3_ras_n   		]
  connect_bd_net [get_bd_ports ddr_cas_n    ] [get_bd_pins mig_7series_0/ddr3_cas_n   		]
  connect_bd_net [get_bd_ports ddr_we_n     ] [get_bd_pins mig_7series_0/ddr3_we_n    		]
  connect_bd_net [get_bd_ports ddr_reset_n  ] [get_bd_pins mig_7series_0/ddr3_reset_n 		]
  connect_bd_net [get_bd_ports ddr_ck_n     ] [get_bd_pins mig_7series_0/ddr3_ck_n    		]
  connect_bd_net [get_bd_ports ddr_ck_p     ] [get_bd_pins mig_7series_0/ddr3_ck_p    		]
  connect_bd_net [get_bd_ports ddr_cke      ] [get_bd_pins mig_7series_0/ddr3_cke     		]
  connect_bd_net [get_bd_ports ddr_cs_n     ] [get_bd_pins mig_7series_0/ddr3_cs_n    		]
  connect_bd_net [get_bd_ports ddr_dm       ] [get_bd_pins mig_7series_0/ddr3_dm      		]
  connect_bd_net [get_bd_ports ddr_odt      ] [get_bd_pins mig_7series_0/ddr3_odt     		]

  # external<=>chip_top_mod_wrapper
  connect_bd_net [get_bd_ports rst_top      ] [get_bd_pins chip_top_mod_wrapper_0/rst_top	]
  connect_bd_net [get_bd_ports rxd          ] [get_bd_pins chip_top_mod_wrapper_0/rxd     	]
  connect_bd_net [get_bd_ports txd          ] [get_bd_pins chip_top_mod_wrapper_0/txd     	]
  connect_bd_net [get_bd_ports rts          ] [get_bd_pins chip_top_mod_wrapper_0/rts     	]
  connect_bd_net [get_bd_ports cts          ] [get_bd_pins chip_top_mod_wrapper_0/cts     	]
  connect_bd_net [get_bd_ports sd_sclk      ] [get_bd_pins chip_top_mod_wrapper_0/sd_sclk   ]
  connect_bd_net [get_bd_ports sd_detect    ] [get_bd_pins chip_top_mod_wrapper_0/sd_detect ]
  connect_bd_net [get_bd_ports sd_dat       ] [get_bd_pins chip_top_mod_wrapper_0/sd_dat    ]
  connect_bd_net [get_bd_ports sd_cmd       ] [get_bd_pins chip_top_mod_wrapper_0/sd_cmd    ]
  connect_bd_net [get_bd_ports sd_reset     ] [get_bd_pins chip_top_mod_wrapper_0/sd_reset  ]
  connect_bd_net [get_bd_ports o_led        ] [get_bd_pins chip_top_mod_wrapper_0/o_led     ]
  connect_bd_net [get_bd_ports i_dip        ] [get_bd_pins chip_top_mod_wrapper_0/i_dip     ]
  connect_bd_net [get_bd_ports GPIO_SW_C    ] [get_bd_pins chip_top_mod_wrapper_0/GPIO_SW_C ]
  connect_bd_net [get_bd_ports GPIO_SW_W    ] [get_bd_pins chip_top_mod_wrapper_0/GPIO_SW_W ]
  connect_bd_net [get_bd_ports GPIO_SW_E    ] [get_bd_pins chip_top_mod_wrapper_0/GPIO_SW_E ]
  connect_bd_net [get_bd_ports GPIO_SW_N    ] [get_bd_pins chip_top_mod_wrapper_0/GPIO_SW_N ]
  connect_bd_net [get_bd_ports GPIO_SW_S    ] [get_bd_pins chip_top_mod_wrapper_0/GPIO_SW_S ]
  connect_bd_net [get_bd_ports PS2_CLK      ] [get_bd_pins chip_top_mod_wrapper_0/PS2_CLK   ]
  connect_bd_net [get_bd_ports PS2_DATA     ] [get_bd_pins chip_top_mod_wrapper_0/PS2_DATA  ]
  connect_bd_net [get_bd_ports i_erx_dv     ] [get_bd_pins chip_top_mod_wrapper_0/i_erx_dv  ]
  connect_bd_net [get_bd_ports i_erx_er     ] [get_bd_pins chip_top_mod_wrapper_0/i_erx_er  ]
  connect_bd_net [get_bd_ports i_emdint     ] [get_bd_pins chip_top_mod_wrapper_0/i_emdint  ]
  connect_bd_net [get_bd_ports o_erefclk    ] [get_bd_pins chip_top_mod_wrapper_0/o_erefclk ]
  connect_bd_net [get_bd_ports o_etx_en     ] [get_bd_pins chip_top_mod_wrapper_0/o_etx_en  ]
  connect_bd_net [get_bd_ports i_erxd       ] [get_bd_pins chip_top_mod_wrapper_0/i_erxd     ]
  connect_bd_net [get_bd_ports o_etxd       ] [get_bd_pins chip_top_mod_wrapper_0/o_etxd     ]
  connect_bd_net [get_bd_ports o_etx_er     ] [get_bd_pins chip_top_mod_wrapper_0/o_etx_er   ]
  connect_bd_net [get_bd_ports i_gmiiclk_p  ] [get_bd_pins chip_top_mod_wrapper_0/i_gmiiclk_p]
  connect_bd_net [get_bd_ports i_gmiiclk_n  ] [get_bd_pins chip_top_mod_wrapper_0/i_gmiiclk_n]
  connect_bd_net [get_bd_ports i_erx_clk    ] [get_bd_pins chip_top_mod_wrapper_0/i_erx_clk  ]
  connect_bd_net [get_bd_ports i_etx_clk    ] [get_bd_pins chip_top_mod_wrapper_0/i_etx_clk  ]
  connect_bd_net [get_bd_ports o_emdc       ] [get_bd_pins chip_top_mod_wrapper_0/o_emdc     ]
  connect_bd_net [get_bd_ports io_emdio     ] [get_bd_pins chip_top_mod_wrapper_0/io_emdio   ]
  connect_bd_net [get_bd_ports o_erstn      ] [get_bd_pins chip_top_mod_wrapper_0/o_erstn    ]


  
  # mig_7 & chip_top_mod_wrapper
  connect_bd_net [get_bd_pins mig_7series_0/aresetn    				] [get_bd_pins chip_top_mod_wrapper_0/rstn   		 	]
  connect_bd_net [get_bd_pins mig_7series_0/mmcm_locked             ] [get_bd_pins chip_top_mod_wrapper_0/rstn 	    		]

  # clk_wiz0<=>chip_top_mod_wrapper
  # external<=>clk_wiz0&1
  connect_bd_net [get_bd_pins clk_wiz_0/reset            	] [get_bd_ports rst_top      						]	 
  connect_bd_net [get_bd_pins clk_wiz_0/clk_in1             ] [get_bd_pins mig_7series_0/ui_clk				    ]
  connect_bd_net [get_bd_pins clk_wiz_0/clk_mii             ] [get_bd_pins chip_top_mod_wrapper_0/clk_mii       ]
  connect_bd_net [get_bd_pins clk_wiz_0/clk_cpu             ] [get_bd_pins chip_top_mod_wrapper_0/clk           ]
  connect_bd_net [get_bd_pins clk_wiz_0/clk_out1            ] [get_bd_pins chip_top_mod_wrapper_0/mig_sys_clk   ]  
  connect_bd_net [get_bd_pins clk_wiz_0/clk_pixel     		] [get_bd_pins chip_top_mod_wrapper_0/clk_pixel     ]  
  connect_bd_net [get_bd_pins clk_wiz_0/locked        		] [get_bd_pins chip_top_mod_wrapper_0/clk_locked_wiz]  

  # connect_bd_net [get_bd_ports clk_wiz_0/clk_mii_quad            ] [get_bd_pins chip_top_mod_wrapper_0/clk_mii_quad  	] useless
  # connect_bd_net [get_bd_ports rst_top      				] [get_bd_pins clk_wiz_1/reset          			]



  #clk_wiz1<->chip_top_mod_wrapper
  connect_bd_net [get_bd_pins clk_wiz_1/clk_in1             ] [get_bd_pins chip_top_mod_wrapper_0/clk             	]
  connect_bd_net [get_bd_pins clk_wiz_1/clk_sdclk           ] [get_bd_pins chip_top_mod_wrapper_0/sd_clk_o  		]
  connect_bd_net [get_bd_pins clk_wiz_1/daddr               ] [get_bd_pins chip_top_mod_wrapper_0/sd_clk_daddr      ]
  connect_bd_net [get_bd_pins clk_wiz_1/dclk                ] [get_bd_pins chip_top_mod_wrapper_0/clk             	]
  connect_bd_net [get_bd_pins clk_wiz_1/den             	] [get_bd_pins chip_top_mod_wrapper_0/sd_clk_den        ]
  connect_bd_net [get_bd_pins clk_wiz_1/din             	] [get_bd_pins chip_top_mod_wrapper_0/sd_clk_din        ]
  connect_bd_net [get_bd_pins clk_wiz_1/dout            	] [get_bd_pins chip_top_mod_wrapper_0/sd_clk_dout       ]
  connect_bd_net [get_bd_pins clk_wiz_1/drdy            	] [get_bd_pins chip_top_mod_wrapper_0/sd_clk_drdy       ]
  connect_bd_net [get_bd_pins clk_wiz_1/dwe             	] [get_bd_pins chip_top_mod_wrapper_0/sd_clk_dwe        ]
  connect_bd_net [get_bd_pins clk_wiz_1/locked          	] [get_bd_pins chip_top_mod_wrapper_0/sd_clk_locked     ]


  # ###################################################
  #  trying pull out clock converter tcl source part
  # ###################################################
  
  create_bd_cell -type ip -vlnv xilinx.com:ip:axi_clock_converter:2.1 axi_clock_converter_0
  # create AXI interconnect BD cell
  create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0
  set_property -dict [list CONFIG.NUM_MI {1}] [get_bd_cells axi_interconnect_0]

  # mig reset
  create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0
  set_property -dict [list CONFIG.C_SIZE {1} CONFIG.C_OPERATION {not} CONFIG.LOGO_FILE {data/sym_notgate.png}] [get_bd_cells util_vector_logic_0]
  connect_bd_net [get_bd_pins util_vector_logic_0/Op1] [get_bd_pins mig_7series_0/ui_clk_sync_rst]

  # reset polarity configuration
  set_property -dict [list CONFIG.POLARITY {ACTIVE_HIGH}] [get_bd_pins chip_top_mod_wrapper_0/clk_wiz1_rst]
  connect_bd_net [get_bd_pins chip_top_mod_wrapper_0/clk_wiz1_rst] [get_bd_pins clk_wiz_1/reset]



  # chip_top <=> clock converter
  connect_bd_intf_net 	[get_bd_intf_pins chip_top_mod_wrapper_0/mem_m_axi	] [get_bd_intf_pins axi_clock_converter_0/S_AXI		]
  connect_bd_net		[get_bd_pins clk_wiz_0/clk_cpu						] [get_bd_pins axi_clock_converter_0/s_axi_aclk		]
  connect_bd_net	 	[get_bd_pins mig_7series_0/mmcm_locked				] [get_bd_pins axi_clock_converter_0/s_axi_aresetn	]
  connect_bd_net	 	[get_bd_pins mig_7series_0/ui_clk					] [get_bd_pins axi_clock_converter_0/m_axi_aclk		]
  connect_bd_net 	  	[get_bd_pins axi_clock_converter_0/m_axi_aresetn	] [get_bd_pins util_vector_logic_0/Res				]
  
  # clock converter <=> AXI interconnect
  connect_bd_intf_net [get_bd_intf_pins axi_clock_converter_0/M_AXI	] -boundary_type upper [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_net [get_bd_pins axi_interconnect_0/ARESETN			] [get_bd_pins util_vector_logic_0/Res	]
  connect_bd_net [get_bd_pins axi_interconnect_0/S00_ARESETN		] [get_bd_pins util_vector_logic_0/Res	]
  connect_bd_net [get_bd_pins axi_interconnect_0/M00_ARESETN		] [get_bd_pins util_vector_logic_0/Res	]  
  connect_bd_net [get_bd_pins axi_interconnect_0/ACLK				] [get_bd_pins mig_7series_0/ui_clk		]
  connect_bd_net [get_bd_pins axi_interconnect_0/S00_ACLK			] [get_bd_pins mig_7series_0/ui_clk		]
  connect_bd_net [get_bd_pins axi_interconnect_0/M00_ACLK			] [get_bd_pins mig_7series_0/ui_clk		]  

  # AXI interconnect <=> mig 7
  connect_bd_intf_net [get_bd_intf_pins mig_7series_0/S_AXI] -boundary_type upper [get_bd_intf_pins axi_interconnect_0/M00_AXI]

  # address assignment
  assign_bd_address [get_bd_addr_segs {mig_7series_0/memmap/memaddr }]

  # align block design
  regenerate_bd_layout

save_bd_design
endgroup












# ###################
# adding VTA modules
# ###################

startgroup

# Paths to IP library of VTA modules
# need to copy this whole directory later..................!
  set_property  ip_repo_paths  /home/uho/workspace/incubator-tvm/3rdparty/vta-hw/build/hardware/xilinx/hls/kc705_1x16_i8w8a32_15_15_18_17 [current_project]
  update_ip_catalog


# #################
# HLS IP
# #################
  create_bd_cell -type ip -vlnv xilinx.com:hls:fetch:1.0 fetch_0
  create_bd_cell -type ip -vlnv xilinx.com:hls:compute:1.0 compute_0
  create_bd_cell -type ip -vlnv xilinx.com:hls:load:1.0 load_0
  create_bd_cell -type ip -vlnv xilinx.com:hls:store:1.0 store_0

# ########## ip library path setting #############

  set vta_config "/home/uho/workspace/lowriscv_chip_wo_interconnect/HW/vta-hw/config/vta_config.py"
  
  # Get the VTA configuration paramters
  set target            [exec python $vta_config --target]
  set device_family     [exec python $vta_config --get-fpga-family]
  set clock_freq        [exec python $vta_config --get-fpga-freq]

  # SRAM dimensions
  set inp_part          [exec python $vta_config --get-inp-mem-banks]
  set inp_mem_width     [exec python $vta_config --get-inp-mem-width]
  set inp_mem_depth     [exec python $vta_config --get-inp-mem-depth]
  set wgt_part          [exec python $vta_config --get-wgt-mem-banks]
  set wgt_mem_width     [exec python $vta_config --get-wgt-mem-width]
  set wgt_mem_depth     [exec python $vta_config --get-wgt-mem-depth]
  set out_part          [exec python $vta_config --get-out-mem-banks]
  set out_mem_width     [exec python $vta_config --get-out-mem-width]
  set out_mem_depth     [exec python $vta_config --get-out-mem-depth]
  
  # AXI bus signals
  set axi_cache         [exec python $vta_config --get-axi-cache-bits]
  set axi_prot          [exec python $vta_config --get-axi-prot-bits]
  
  # Address map
  set ip_reg_map_range  [exec python $vta_config --get-ip-reg-map-range]
  set fetch_base_addr   [exec python $vta_config --get-fetch-base-addr]
  set load_base_addr    [exec python $vta_config --get-load-base-addr]
  set compute_base_addr [exec python $vta_config --get-compute-base-addr]
  set store_base_addr   [exec python $vta_config --get-store-base-addr]



  # Procedure to initialize FIFO
  proc init_fifo_property {fifo width_bytes depth} {
    set_property -dict [ list \
      CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
      CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
      CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
      CONFIG.Full_Flags_Reset_Value {1} \
      CONFIG.INTERFACE_TYPE {AXI_STREAM} \
      CONFIG.Input_Depth_axis $depth \
      CONFIG.Reset_Type {Asynchronous_Reset} \
      CONFIG.TDATA_NUM_BYTES $width_bytes \
    ] $fifo
  }
  
  # Procedure to initialize BRAM
  proc init_bram_property {bram width depth} {
    set_property -dict [ list \
      CONFIG.Assume_Synchronous_Clk {true} \
      CONFIG.Byte_Size {8} \
      CONFIG.Enable_32bit_Address {true} \
      CONFIG.Enable_B {Use_ENB_Pin} \
      CONFIG.Memory_Type {True_Dual_Port_RAM} \
      CONFIG.Read_Width_A $width \
      CONFIG.Read_Width_B $width \
      CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
      CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
      CONFIG.Use_Byte_Write_Enable {true} \
      CONFIG.Use_RSTA_Pin {true} \
      CONFIG.Use_RSTB_Pin {true} \
      CONFIG.Write_Depth_A $depth \
      CONFIG.Write_Width_A $width \
      CONFIG.Write_Width_B $width \
    ] $bram
  }
  
  
  # Create instance: proc_sys_reset, and set properties
  set proc_sys_reset \
    [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset ]
  
#  # Create instance: pll_clk, and set properties
#    set pll_clk [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 pll_clk ]
#    set_property -dict [ list \
#      CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {100} \
#      CONFIG.RESET_PORT {resetn} \
#      CONFIG.RESET_TYPE {ACTIVE_LOW} \
#      CONFIG.USE_LOCKED {false} \
#    ] $pll_clk


  # Create instance: axi_smc0, and set properties
  set axi_smc0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_smc0 ]
  set_property -dict [ list \
    CONFIG.NUM_MI {1} \
    CONFIG.NUM_SI {5} \
  ] $axi_smc0


  # Create instance: axi_xbar, and set properties
  set axi_xbar \
    [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_xbar ]
  set_property -dict [ list \
    CONFIG.NUM_MI {4} \
    CONFIG.NUM_SI {1} \
  ] $axi_xbar




# ##############
# CMD Queues
# ##############

  # Create command queues and set properties
  set cmd_queue_list {load_queue gemm_queue store_queue}
  foreach cmd_queue $cmd_queue_list {
    set tmp_cmd_queue [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 $cmd_queue ]
    # Width is 16B (128b, as set in hw_spec.h), depth is 512 (depth of FIFO on Zynq 7000 and Zynq Ultrascale+)
    # TODO: derive it from vta_config.h
    [ init_fifo_property $tmp_cmd_queue 16 512 ]
  }

#   create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 load_queue
#   create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 gemm_queue
#   create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 store_queue
#   
#   # Width is 16B (128b, as set in hw_spec.h), depth is 512 (depth of FIFO on Zynq 7000 and Zynq Ultrascale+)
#   # TODO: derive it from vta_config.h
#   foreach cmd_queue $cmd_queue_list {
#     [ init_fifo_property $tmp_cmd_queue 16 512 ]
#   }
#   
#   set property load_queue 16 512
#   set property gemm_queue 16 512
#   set property store_queue 16 512


# Create dependence queues and set properties
set dep_queue_list {l2g_queue g2l_queue g2s_queue s2g_queue}
foreach dep_queue $dep_queue_list {
  set tmp_dep_queue [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 $dep_queue ]
  # Width is 1B (min width), depth is 1024
  # TODO: derive it from vta_config.h
  [ init_fifo_property $tmp_dep_queue 1 1024 ]
}




# #################
# mem generation
# #################

  # Create and connect inp_mem partitions
  for {set i 0} {$i < $inp_part} {incr i} {
    # Create instance: inp_mem, and set properties
    set inp_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 inp_mem_${i} ]
    [ init_bram_property $inp_mem $inp_mem_width $inp_mem_depth ]
    # If module has more than 1 mem port, the naming convention changes
    if {$inp_part > 1} {
      set porta [get_bd_intf_pins load_0/inp_mem_${i}_V_PORTA]
      set portb [get_bd_intf_pins compute_0/inp_mem_${i}_V_PORTA]
    } else {
      set porta [get_bd_intf_pins load_0/inp_mem_V_PORTA]
      set portb [get_bd_intf_pins compute_0/inp_mem_V_PORTA]
    }
    # Create interface connections
    connect_bd_intf_net -intf_net load_0_inp_mem_V_PORTA \
      [get_bd_intf_pins $inp_mem/BRAM_PORTA] \
      $porta
    connect_bd_intf_net -intf_net compute_0_inp_mem_V_PORTA \
      [get_bd_intf_pins $inp_mem/BRAM_PORTB] \
      $portb
  }
  
  # Create and connect wgt_mem partitions
  for {set i 0} {$i < $wgt_part} {incr i} {
    # Create instance: wgt_mem, and set properties
    set wgt_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 wgt_mem_${i} ]
    [ init_bram_property $wgt_mem $wgt_mem_width $wgt_mem_depth ]
    # If module has more than 1 mem port, the naming convention changes
    if {$wgt_part > 1} {
      set porta [get_bd_intf_pins load_0/wgt_mem_${i}_V_PORTA]
      set portb [get_bd_intf_pins compute_0/wgt_mem_${i}_V_PORTA]
    } else {
      set porta [get_bd_intf_pins load_0/wgt_mem_V_PORTA]
      set portb [get_bd_intf_pins compute_0/wgt_mem_V_PORTA]
    }
    # Create interface connections
    connect_bd_intf_net -intf_net load_0_wgt_mem_${i}_V_PORTA \
      [get_bd_intf_pins $wgt_mem/BRAM_PORTA] \
      $porta
    connect_bd_intf_net -intf_net compute_0_wgt_mem_${i}_V_PORTA \
      [get_bd_intf_pins $wgt_mem/BRAM_PORTB] \
      $portb
  }
  
  # Create and connect out_mem partitions
  for {set i 0} {$i < $out_part} {incr i} {
    # Create instance: out_mem, and set properties
    set out_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 out_mem_${i} ]
    [ init_bram_property $out_mem $out_mem_width $out_mem_depth ]
    # If module has more than 1 mem port, the naming convention changes
    if {$out_part > 1} {
      set porta [get_bd_intf_pins compute_0/out_mem_${i}_V_PORTA]
      set portb [get_bd_intf_pins store_0/out_mem_${i}_V_PORTA]
    } else {
      set porta [get_bd_intf_pins compute_0/out_mem_V_PORTA]
      set portb [get_bd_intf_pins store_0/out_mem_V_PORTA]
    }
    # Create interface connections
    connect_bd_intf_net -intf_net compute_0_out_mem_${i}_V_PORTA \
      [get_bd_intf_pins $out_mem/BRAM_PORTA] \
      $porta
    connect_bd_intf_net -intf_net store_0_out_mem_${i}_V_PORTA \
      [get_bd_intf_pins $out_mem/BRAM_PORTB] \
      $portb
  }

# ##############
# port mapping
# ##############

  # Create interface connections
  connect_bd_intf_net -intf_net axi_xbar_M00_AXI [get_bd_intf_pins axi_xbar/M00_AXI] [get_bd_intf_pins fetch_0/s_axi_CONTROL_BUS]
  connect_bd_intf_net -intf_net axi_xbar_M01_AXI [get_bd_intf_pins axi_xbar/M01_AXI] [get_bd_intf_pins load_0/s_axi_CONTROL_BUS]
  connect_bd_intf_net -intf_net axi_xbar_M02_AXI [get_bd_intf_pins axi_xbar/M02_AXI] [get_bd_intf_pins compute_0/s_axi_CONTROL_BUS]
  connect_bd_intf_net -intf_net axi_xbar_M03_AXI [get_bd_intf_pins axi_xbar/M03_AXI] [get_bd_intf_pins store_0/s_axi_CONTROL_BUS]
  connect_bd_intf_net -intf_net fetch_0_l2g_dep_queue_V [get_bd_intf_pins l2g_queue/S_AXIS] [get_bd_intf_pins load_0/l2g_dep_queue_V]
  connect_bd_intf_net -intf_net fetch_0_load_queue_V_V [get_bd_intf_pins fetch_0/load_queue_V_V] [get_bd_intf_pins load_queue/S_AXIS]
  connect_bd_intf_net -intf_net fetch_0_gemm_queue_V_V [get_bd_intf_pins fetch_0/gemm_queue_V_V] [get_bd_intf_pins gemm_queue/S_AXIS]
  connect_bd_intf_net -intf_net fetch_0_store_queue_V_V [get_bd_intf_pins fetch_0/store_queue_V_V] [get_bd_intf_pins store_queue/S_AXIS]
  connect_bd_intf_net -intf_net compute_0_g2l_dep_queue_V [get_bd_intf_pins compute_0/g2l_dep_queue_V] [get_bd_intf_pins g2l_queue/S_AXIS]
  connect_bd_intf_net -intf_net compute_0_g2s_dep_queue_V [get_bd_intf_pins compute_0/g2s_dep_queue_V] [get_bd_intf_pins g2s_queue/S_AXIS]
  connect_bd_intf_net -intf_net store_0_s2g_dep_queue_V [get_bd_intf_pins s2g_queue/S_AXIS] [get_bd_intf_pins store_0/s2g_dep_queue_V]
  connect_bd_intf_net -intf_net load_queue_M_AXIS [get_bd_intf_pins load_0/load_queue_V_V] [get_bd_intf_pins load_queue/M_AXIS]
  connect_bd_intf_net -intf_net gemm_queue_M_AXIS [get_bd_intf_pins compute_0/gemm_queue_V_V] [get_bd_intf_pins gemm_queue/M_AXIS]
  connect_bd_intf_net -intf_net store_queue_M_AXIS [get_bd_intf_pins store_0/store_queue_V_V] [get_bd_intf_pins store_queue/M_AXIS]
  connect_bd_intf_net -intf_net l2g_queue_M_AXIS [get_bd_intf_pins compute_0/l2g_dep_queue_V] [get_bd_intf_pins l2g_queue/M_AXIS]
  connect_bd_intf_net -intf_net g2l_queue_M_AXIS [get_bd_intf_pins g2l_queue/M_AXIS] [get_bd_intf_pins load_0/g2l_dep_queue_V]
  connect_bd_intf_net -intf_net g2s_queue_M_AXIS [get_bd_intf_pins g2s_queue/M_AXIS] [get_bd_intf_pins store_0/g2s_dep_queue_V]
  connect_bd_intf_net -intf_net s2g_queue_M_AXIS [get_bd_intf_pins compute_0/s2g_dep_queue_V] [get_bd_intf_pins s2g_queue/M_AXIS]
  connect_bd_intf_net -intf_net fetch_0_m_axi_ins_port [get_bd_intf_pins axi_smc0/S00_AXI] [get_bd_intf_pins fetch_0/m_axi_ins_port]
  connect_bd_intf_net -intf_net load_0_m_axi_data_port [get_bd_intf_pins axi_smc0/S01_AXI] [get_bd_intf_pins load_0/m_axi_data_port]
  connect_bd_intf_net -intf_net compute_0_m_axi_uop_port [get_bd_intf_pins axi_smc0/S02_AXI] [get_bd_intf_pins compute_0/m_axi_uop_port]
  connect_bd_intf_net -intf_net compute_0_m_axi_data_port [get_bd_intf_pins axi_smc0/S03_AXI] [get_bd_intf_pins compute_0/m_axi_data_port]
  connect_bd_intf_net -intf_net store_0_m_axi_data_port [get_bd_intf_pins axi_smc0/S04_AXI] [get_bd_intf_pins store_0/m_axi_data_port]


	
  connect_bd_net -net proc_sys_reset_interconnect_aresetn \
    [get_bd_pins axi_xbar/ARESETN] \
    [get_bd_pins proc_sys_reset/interconnect_aresetn]
  connect_bd_net -net proc_sys_reset_peripheral_aresetn \
    [get_bd_pins proc_sys_reset/peripheral_aresetn] \
    [get_bd_pins axi_smc0/aresetn] \
    [get_bd_pins axi_xbar/M00_ARESETN] \
    [get_bd_pins axi_xbar/M01_ARESETN] \
    [get_bd_pins axi_xbar/M02_ARESETN] \
    [get_bd_pins axi_xbar/M03_ARESETN] \
    [get_bd_pins axi_xbar/S00_ARESETN] \
    [get_bd_pins fetch_0/ap_rst_n] \
    [get_bd_pins load_0/ap_rst_n] \
    [get_bd_pins store_0/ap_rst_n] \
    [get_bd_pins compute_0/ap_rst_n] \
    [get_bd_pins load_queue/s_aresetn] \
    [get_bd_pins gemm_queue/s_aresetn] \
    [get_bd_pins store_queue/s_aresetn] \
    [get_bd_pins l2g_queue/s_aresetn] \
    [get_bd_pins g2l_queue/s_aresetn] \
    [get_bd_pins g2s_queue/s_aresetn] \
    [get_bd_pins s2g_queue/s_aresetn]
  connect_bd_net [get_bd_ports rst_top] [get_bd_pins proc_sys_reset/ext_reset_in]
  connect_bd_net \
    [get_bd_pins clk_wiz_0/clk_cpu] \
    [get_bd_pins proc_sys_reset/slowest_sync_clk] \
    [get_bd_pins axi_smc0/aclk] \
    [get_bd_pins axi_xbar/ACLK] \
    [get_bd_pins axi_xbar/M00_ACLK] \
    [get_bd_pins axi_xbar/M01_ACLK] \
    [get_bd_pins axi_xbar/M02_ACLK] \
    [get_bd_pins axi_xbar/M03_ACLK] \
    [get_bd_pins axi_xbar/S00_ACLK] \
    [get_bd_pins fetch_0/ap_clk] \
    [get_bd_pins load_0/ap_clk] \
    [get_bd_pins compute_0/ap_clk] \
    [get_bd_pins store_0/ap_clk] \
    [get_bd_pins load_queue/s_aclk] \
    [get_bd_pins gemm_queue/s_aclk] \
    [get_bd_pins store_queue/s_aclk] \
    [get_bd_pins l2g_queue/s_aclk] \
    [get_bd_pins g2l_queue/s_aclk] \
    [get_bd_pins g2s_queue/s_aclk] \
    [get_bd_pins s2g_queue/s_aclk] 

  set_property -dict [list CONFIG.NUM_SI {2} CONFIG.NUM_MI {1}] [get_bd_cells axi_interconnect_0]
  create_bd_cell -type ip -vlnv xilinx.com:ip:axi_clock_converter:2.1 axi_clock_converter_1
  connect_bd_intf_net [get_bd_intf_pins axi_smc0/M00_AXI] [get_bd_intf_pins axi_clock_converter_1/S_AXI]
  connect_bd_intf_net [get_bd_intf_pins axi_clock_converter_1/M_AXI] -boundary_type upper [get_bd_intf_pins axi_interconnect_0/S01_AXI]
  connect_bd_net [get_bd_pins axi_clock_converter_1/m_axi_aclk] [get_bd_pins mig_7series_0/ui_clk]
  connect_bd_net [get_bd_pins axi_clock_converter_1/m_axi_aresetn] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net [get_bd_pins axi_clock_converter_1/s_axi_aclk] [get_bd_pins clk_wiz_0/clk_cpu]
  connect_bd_net [get_bd_pins axi_clock_converter_1/s_axi_aresetn] [get_bd_pins mig_7series_0/mmcm_locked]
  
  connect_bd_net [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins mig_7series_0/ui_clk]
  connect_bd_net [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins util_vector_logic_0/Res]
  

  create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_1
  connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_interconnect_1/M00_AXI] [get_bd_intf_pins chip_top_mod_wrapper_0/Inter_to_Bram_axi]
  connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_interconnect_1/M01_AXI] [get_bd_intf_pins axi_xbar/S00_AXI]
  connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_interconnect_1/S00_AXI] [get_bd_intf_pins chip_top_mod_wrapper_0/mmio_m_axi] 
  
  connect_bd_net [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] -boundary_type upper
  connect_bd_net [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN] -boundary_type upper
  connect_bd_net [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins clk_wiz_0/clk_cpu]
  connect_bd_net [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins proc_sys_reset/peripheral_aresetn]
  connect_bd_net [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins clk_wiz_0/clk_cpu]
  connect_bd_net [get_bd_pins axi_interconnect_1/S00_ARESETN] [get_bd_pins mig_7series_0/mmcm_locked]
  connect_bd_net [get_bd_pins mig_7series_0/mmcm_locked] [get_bd_pins axi_interconnect_1/ARESETN]
  connect_bd_net [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins clk_wiz_0/clk_cpu]
  connect_bd_net [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins mig_7series_0/mmcm_locked]
  
  
  create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1
  set_property -dict [list CONFIG.C_SIZE {1} CONFIG.C_OPERATION {not} CONFIG.LOGO_FILE {data/sym_notgate.png}] [get_bd_cells util_vector_logic_1]







  # ##########################################################   
  # arbitrariliy assigned. need to reconsider this later...
  # ##########################################################

   assign_bd_address
   regenerate_bd_layout

save_bd_design


# ########################
# wrap the block design
# ########################


  make_wrapper -files [get_files /home/uho/workspace/lowriscv_chip/HW/fpga/board/kc705/lowrisc-chip-imp/lowrisc-chip-imp.srcs/sources_1/bd/RISC_V_SOC/RISC_V_SOC.bd] -top
  add_files -norecurse /home/uho/workspace/lowriscv_chip/HW/fpga/board/kc705/lowrisc-chip-imp/lowrisc-chip-imp.srcs/sources_1/bd/RISC_V_SOC/hdl/RISC_V_SOC_wrapper.v
  update_compile_order -fileset sources_1
  set_property top RISC_V_SOC_wrapper [current_fileset]
  update_compile_order -fileset sources_1


