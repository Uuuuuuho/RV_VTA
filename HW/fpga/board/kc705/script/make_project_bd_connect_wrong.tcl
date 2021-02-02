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

# Set 'sources_1' fileset object
set files [list \
               [file normalize $base_dir/../rocket-chip/vsim/generated-src/freechips.rocketchip.system.$CONFIG.v] \
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

# add include path
set_property include_dirs [list \
                               [file normalize $base_dir/src/main/verilog] \
                               [file normalize $origin_dir/src ]\
                               [file normalize $origin_dir/generated-src] \
                              ] [get_filesets sources_1]

add_files -norecurse -scan_for_includes -fileset [get_filesets sources_1] $files
import_files -norecurse -fileset [get_filesets sources_1] $files                              

set_property verilog_define [list FPGA FPGA_FULL KC705] [get_filesets sources_1]

# Set 'sources_1' fileset properties
# set_property "top" "chip_top" [get_filesets sources_1]

# added these files
add_files -norecurse -scan_for_includes /home/uho/workspace/lowriscv_chip/HW/porting_src/src/main/verilog/chip_top_modified.sv
import_files -norecurse /home/uho/workspace/lowriscv_chip/HW/porting_src/src/main/verilog/chip_top_modified.sv

add_files -norecurse -scan_for_includes /home/uho/workspace/lowriscv_chip/HW/porting_src/src/main/verilog/periph_soc_modified.sv
import_files -norecurse /home/uho/workspace/lowriscv_chip/HW/porting_src/src/main/verilog/periph_soc_modified.sv

add_files -norecurse -scan_for_includes /home/uho/workspace/lowriscv_chip/HW/porting_src/chip_top_wrapper.v
import_files -norecurse /home/uho/workspace/lowriscv_chip/HW/porting_src/chip_top_wrapper.v

add_files -norecurse -scan_for_includes /home/uho/workspace/lowriscv_chip/HW/porting_src/periph_soc_wrapper.v
import_files -norecurse /home/uho/workspace/lowriscv_chip/HW/porting_src/periph_soc_wrapper.v

set_property "top" "chip_top_wrapper" [get_filesets sources_1]

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

# AXI clock converter due to the clock difference
create_ip -name axi_clock_converter -vendor xilinx.com -library ip -version 2.1 -module_name axi_clock_converter_0
set_property -dict [list \
                        CONFIG.ADDR_WIDTH {30} \
                        CONFIG.DATA_WIDTH $mem_data_width \
                        CONFIG.ID_WIDTH $axi_id_width \
                        CONFIG.ACLK_ASYNC {1} \
                        CONFIG.SYNCHRONIZATION_STAGES {4}] \
    [get_ips axi_clock_converter_0]
generate_target {instantiation_template} [get_files $proj_dir/$project_name.srcs/sources_1/ip/axi_clock_converter_0/axi_clock_converter_0.xci]

# generate all IP source code
generate_target all [get_ips]

set_property generate_synth_checkpoint 0 [get_files axi_bram_ctrl_dummy.xci]
set_property generate_synth_checkpoint 0 [get_files axi_clock_converter_0.xci]
#set_property generate_synth_checkpoint 0 [get_files mig_7series_0.xci]
#set_property generate_synth_checkpoint 0 [get_files clk_wiz_0.xci]
#set_property generate_synth_checkpoint 0 [get_files clk_wiz_1.xci]

###############################################################################################################


if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set files [list [file normalize "$origin_dir/constraint/pin_plan.xdc"] \
          [file normalize "$origin_dir/constraint/timing.xdc"]]

set file_added [add_files -norecurse -fileset $obj $files]



update_compile_order -fileset sources_1

create_bd_design "RISC_V_SOC"
current_bd_design "RISC_V_SOC"

update_compile_order -fileset sources_1

startgroup

  create_bd_cell -type module -reference chip_top_wrapper chip_top_wrapper_0

  save_bd_design

  create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0
  create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_1
  create_bd_cell -type ip -vlnv xilinx.com:ip:mig_7series mig_7series_0

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

#make top wrapper port

  #ddr interface
  create_bd_port -dir IO  -from 63  -to 0         ddr_dq
  create_bd_port -dir IO  -from 7   -to 0         ddr_dqs_n
  create_bd_port -dir IO  -from 7   -to 0         ddr_dqs_p
  create_bd_port -dir O   -from 13  -to 0         ddr_addr
  create_bd_port -dir O   -from 2   -to 0         ddr_ba
  create_bd_port -dir O                           ddr_ras_n
  create_bd_port -dir O                           ddr_cas_n
  create_bd_port -dir O                           ddr_we_n
  create_bd_port -dir O                           ddr_reset_n
  create_bd_port -dir O                           ddr_ck_n
  create_bd_port -dir O                           ddr_ck_p
  create_bd_port -dir O                           ddr_cke
  create_bd_port -dir O                           ddr_cs_n
  create_bd_port -dir O   -from 7   -to 0         ddr_dm
  create_bd_port -dir O                           ddr_odt

  create_bd_port -dir I                           clk_p   
  create_bd_port -dir I                           clk_n   

  create_bd_port -dir I                           rst_top

  #chip_top interface
  create_bd_port -dir I                           rxd     
  create_bd_port -dir O                           txd     
  create_bd_port -dir O                           rts     
  create_bd_port -dir I                           cts     
                  
  create_bd_port -dir IO                          sd_sclk     
  create_bd_port -dir I                           sd_detect   
  create_bd_port -dir IO  -from 3   -to 0         sd_dat      
  create_bd_port -dir IO                          sd_cmd      
  create_bd_port -dir O                           sd_reset  
  
  create_bd_port -dir O   -from 7   -to 0         o_led   
  create_bd_port -dir I   -from 3   -to 0         i_dip   

  create_bd_port -dir I                           GPIO_SW_C   
  create_bd_port -dir I                           GPIO_SW_W   
  create_bd_port -dir I                           GPIO_SW_E   
  create_bd_port -dir I                           GPIO_SW_N   
  create_bd_port -dir I                           GPIO_SW_S   

  create_bd_port -dir IO                          PS2_CLK   
  create_bd_port -dir IO                          PS2_DATA  
        
  create_bd_port -dir I                           i_erx_dv  
  create_bd_port -dir I                           i_erx_er  
  create_bd_port -dir I                           i_emdint  
  create_bd_port -dir O -type data                o_erefclk 
  create_bd_port -dir O -type data                o_etx_en  
        
  create_bd_port -dir I   -from 3   -to 0         i_erxd    
  create_bd_port -dir O -type data -from 7 -to 0  o_etxd    
  create_bd_port -dir O -type data                o_etx_er  
  create_bd_port -dir I                           i_gmiiclk_p 
  create_bd_port -dir I                           i_gmiiclk_n 
  create_bd_port -dir I                           i_erx_clk 
  create_bd_port -dir I                           i_etx_clk 
        
  create_bd_port -dir O                           o_emdc    
  create_bd_port -dir IO                          io_emdio  
  create_bd_port -dir O                           o_erstn   

save_bd_design

#port mapping

  #Reset interface
  connect_bd_net  [get_bd_ports rst_top   ]  [get_bd_pins clk_wiz_0/reset           ]  
  connect_bd_net  [get_bd_ports rst_top   ]  [get_bd_pins chip_top_wrapper_0/rst_top]
  connect_bd_net  [get_bd_ports rst_top   ]  [get_bd_pins clk_wiz_1/reset           ]
  connect_bd_net  [get_bd_ports rst_top   ]  [get_bd_pins mig_7series_0/sys_rst     ]
  connect_bd_net  [get_bd_ports rst_top   ]  [get_bd_pins mig_7series_0/aresetn     ]
  connect_bd_net  [get_bd_ports rst_top   ]  [get_bd_pins mig_7series_0/mmcm_locked ]

#ddr interface
  connect_bd_net [get_bd_ports ddr_dq     ] [get_bd_pins mig_7series_0/ddr3_dq      ]
  connect_bd_net [get_bd_ports ddr_dqs_n  ] [get_bd_pins mig_7series_0/ddr3_dqs_n   ]
  connect_bd_net [get_bd_ports ddr_dqs_p  ] [get_bd_pins mig_7series_0/ddr3_dqs_p   ]
  connect_bd_net [get_bd_ports ddr_addr   ] [get_bd_pins mig_7series_0/ddr3_addr    ]
  connect_bd_net [get_bd_ports ddr_ba     ] [get_bd_pins mig_7series_0/ddr3_ba      ]
  connect_bd_net [get_bd_ports ddr_ras_n  ] [get_bd_pins mig_7series_0/ddr3_ras_n   ]
  connect_bd_net [get_bd_ports ddr_cas_n  ] [get_bd_pins mig_7series_0/ddr3_cas_n   ]
  connect_bd_net [get_bd_ports ddr_we_n   ] [get_bd_pins mig_7series_0/ddr3_we_n    ]
  connect_bd_net [get_bd_ports ddr_reset_n] [get_bd_pins mig_7series_0/ddr3_reset_n ]
  connect_bd_net [get_bd_ports ddr_ck_n   ] [get_bd_pins mig_7series_0/ddr3_ck_n    ]
  connect_bd_net [get_bd_ports ddr_ck_p   ] [get_bd_pins mig_7series_0/ddr3_ck_p    ]
  connect_bd_net [get_bd_ports ddr_cke    ] [get_bd_pins mig_7series_0/ddr3_cke     ]
  connect_bd_net [get_bd_ports ddr_cs_n   ] [get_bd_pins mig_7series_0/ddr3_cs_n    ]
  connect_bd_net [get_bd_ports ddr_dm     ] [get_bd_pins mig_7series_0/ddr3_dm      ]
  connect_bd_net [get_bd_ports ddr_odt    ] [get_bd_pins mig_7series_0/ddr3_odt     ]

  connect_bd_net [get_bd_ports clk_p      ] [get_bd_pins mig_7series_0/sys_clk_p    ]
  connect_bd_net [get_bd_ports clk_n      ] [get_bd_pins mig_7series_0/sys_clk_n    ]

save_bd_design

  #chip_top interface
  connect_bd_net [get_bd_ports rxd        ] [get_bd_pins chip_top_wrapper_0/rxd       ]
  connect_bd_net [get_bd_ports txd        ] [get_bd_pins chip_top_wrapper_0/txd       ]
  connect_bd_net [get_bd_ports rts        ] [get_bd_pins chip_top_wrapper_0/rts       ]
  connect_bd_net [get_bd_ports cts        ] [get_bd_pins chip_top_wrapper_0/cts       ]

  connect_bd_net [get_bd_ports sd_sclk    ] [get_bd_pins chip_top_wrapper_0/sd_sclk   ]
  connect_bd_net [get_bd_ports sd_detect  ] [get_bd_pins chip_top_wrapper_0/sd_detect ]
  connect_bd_net [get_bd_ports sd_dat     ] [get_bd_pins chip_top_wrapper_0/sd_dat    ]
  connect_bd_net [get_bd_ports sd_cmd     ] [get_bd_pins chip_top_wrapper_0/sd_cmd    ]
  connect_bd_net [get_bd_ports sd_reset   ] [get_bd_pins chip_top_wrapper_0/sd_reset  ]

  connect_bd_net [get_bd_ports o_led      ] [get_bd_pins chip_top_wrapper_0/o_led     ]
  connect_bd_net [get_bd_ports i_dip      ] [get_bd_pins chip_top_wrapper_0/i_dip     ]

  connect_bd_net [get_bd_ports GPIO_SW_C  ] [get_bd_pins chip_top_wrapper_0/GPIO_SW_C ]
  connect_bd_net [get_bd_ports GPIO_SW_W  ] [get_bd_pins chip_top_wrapper_0/GPIO_SW_W ]
  connect_bd_net [get_bd_ports GPIO_SW_E  ] [get_bd_pins chip_top_wrapper_0/GPIO_SW_E ]
  connect_bd_net [get_bd_ports GPIO_SW_N  ] [get_bd_pins chip_top_wrapper_0/GPIO_SW_N ]
  connect_bd_net [get_bd_ports GPIO_SW_S  ] [get_bd_pins chip_top_wrapper_0/GPIO_SW_S ]

  connect_bd_net [get_bd_ports PS2_CLK    ] [get_bd_pins chip_top_wrapper_0/PS2_CLK   ]
  connect_bd_net [get_bd_ports PS2_DATA   ] [get_bd_pins chip_top_wrapper_0/PS2_DATA  ]
  
  connect_bd_net [get_bd_ports i_erx_dv   ] [get_bd_pins chip_top_wrapper_0/i_erx_dv  ]
  connect_bd_net [get_bd_ports i_erx_er   ] [get_bd_pins chip_top_wrapper_0/i_erx_er  ]
  connect_bd_net [get_bd_ports i_emdint   ] [get_bd_pins chip_top_wrapper_0/i_emdint  ]
  connect_bd_net [get_bd_ports o_erefclk  ] [get_bd_pins chip_top_wrapper_0/o_erefclk ]
  connect_bd_net [get_bd_ports o_etx_en   ] [get_bd_pins chip_top_wrapper_0/o_etx_en  ]

  connect_bd_net [get_bd_ports i_erxd     ] [get_bd_pins chip_top_wrapper_0/i_erxd    ]
  connect_bd_net [get_bd_ports o_etxd     ] [get_bd_pins chip_top_wrapper_0/o_etxd    ]
  connect_bd_net [get_bd_ports o_etx_er   ] [get_bd_pins chip_top_wrapper_0/o_etx_er  ]
  connect_bd_net [get_bd_ports i_gmiiclk_p] [get_bd_pins chip_top_wrapper_0/i_gmiiclk_p]
  connect_bd_net [get_bd_ports i_gmiiclk_n] [get_bd_pins chip_top_wrapper_0/i_gmiiclk_n]
  connect_bd_net [get_bd_ports i_erx_clk  ] [get_bd_pins chip_top_wrapper_0/i_erx_clk ]
  connect_bd_net [get_bd_ports i_etx_clk  ] [get_bd_pins chip_top_wrapper_0/i_etx_clk ]
    
  connect_bd_net [get_bd_ports o_emdc     ] [get_bd_pins chip_top_wrapper_0/o_emdc    ]
  connect_bd_net [get_bd_ports io_emdio   ] [get_bd_pins chip_top_wrapper_0/io_emdio  ]
  connect_bd_net [get_bd_ports o_erstn    ] [get_bd_pins chip_top_wrapper_0/o_erstn   ]

save_bd_design

#connect pin

  # clk_wiz_0 <-> chip_top interface
  connect_bd_net  [get_bd_pins clk_wiz_0/locked          ]  [get_bd_pins chip_top_wrapper_0/locked           ]  
  connect_bd_net  [get_bd_pins clk_wiz_0/clk_mii         ]  [get_bd_pins chip_top_wrapper_0/clk_mii          ]
  connect_bd_net  [get_bd_pins clk_wiz_0/clk_cpu         ]  [get_bd_pins chip_top_wrapper_0/clk_cpu          ]
  connect_bd_net  [get_bd_pins clk_wiz_0/clk_out1        ]  [get_bd_pins chip_top_wrapper_0/clk_out1         ]
  connect_bd_net  [get_bd_pins clk_wiz_0/clk_pixel       ]  [get_bd_pins chip_top_wrapper_0/clk_pixel        ]

  # clk_wiz_0 <-> mig
  connect_bd_net  [get_bd_pins clk_wiz_0/clk_in1         ]  [get_bd_pins mig_7series_0/ui_clk                ]

  # clk_wiz_0 <-> clk_wiz_1
  connect_bd_net  [get_bd_pins clk_wiz_0/clk_cpu         ]  [get_bd_pins clk_wiz_1/clk_in1                   ]  
  connect_bd_net  [get_bd_pins clk_wiz_0/clk_cpu         ]  [get_bd_pins clk_wiz_1/dclk                      ]  

  # clk_wiz_1 <-> chip_top interface
  connect_bd_net  [get_bd_pins clk_wiz_1/clk_sdclk       ]  [get_bd_pins chip_top_wrapper_0/clk_sdclk        ]
  connect_bd_net  [get_bd_pins clk_wiz_1/daddr           ]  [get_bd_pins chip_top_wrapper_0/daddr            ]
  connect_bd_net  [get_bd_pins clk_wiz_1/den             ]  [get_bd_pins chip_top_wrapper_0/den              ]
  connect_bd_net  [get_bd_pins clk_wiz_1/din             ]  [get_bd_pins chip_top_wrapper_0/din              ]
  connect_bd_net  [get_bd_pins clk_wiz_1/dout            ]  [get_bd_pins chip_top_wrapper_0/dout             ]
  connect_bd_net  [get_bd_pins clk_wiz_1/drdy            ]  [get_bd_pins chip_top_wrapper_0/drdy             ]
  connect_bd_net  [get_bd_pins clk_wiz_1/dwe             ]  [get_bd_pins chip_top_wrapper_0/dwe              ] 
  connect_bd_net  [get_bd_pins clk_wiz_1/locked          ]  [get_bd_pins chip_top_wrapper_0/sd_clk_locked    ] 

  # mig <-> clock converter interface
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_awid    ]  [get_bd_pins chip_top_wrapper_0/clk_conv_aw_id      ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_awaddr  ]  [get_bd_pins chip_top_wrapper_0/clk_conv_aw_addr    ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_awlen   ]  [get_bd_pins chip_top_wrapper_0/clk_conv_aw_len     ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_awsize  ]  [get_bd_pins chip_top_wrapper_0/clk_conv_aw_size    ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_awburst ]  [get_bd_pins chip_top_wrapper_0/clk_conv_aw_burst   ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_awcache ]  [get_bd_pins chip_top_wrapper_0/clk_conv_aw_cache   ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_awprot  ]  [get_bd_pins chip_top_wrapper_0/clk_conv_aw_prot    ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_awqos   ]  [get_bd_pins chip_top_wrapper_0/clk_conv_aw_qos     ]
  connect_bd_net  [get_bd_pins mig_7series_0/ui_clk_sync_rst ]  [get_bd_pins chip_top_wrapper_0/ui_clk_sync_rst   ]

  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_awvalid ]  [get_bd_pins chip_top_wrapper_0/clk_conv_aw_valid   ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_wdata   ]  [get_bd_pins chip_top_wrapper_0/clk_conv_w_data     ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_wstrb   ]  [get_bd_pins chip_top_wrapper_0/clk_conv_w_strb     ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_wlast   ]  [get_bd_pins chip_top_wrapper_0/clk_conv_w_last     ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_wvalid  ]  [get_bd_pins chip_top_wrapper_0/clk_conv_w_valid    ]
  
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_bresp   ]  [get_bd_pins chip_top_wrapper_0/clk_conv_b_resp     ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_bready  ]  [get_bd_pins chip_top_wrapper_0/clk_conv_b_ready    ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_arid    ]  [get_bd_pins chip_top_wrapper_0/clk_conv_ar_id      ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_araddr  ]  [get_bd_pins chip_top_wrapper_0/clk_conv_ar_addr    ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_arlen   ]  [get_bd_pins chip_top_wrapper_0/clk_conv_ar_len     ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_arsize  ]  [get_bd_pins chip_top_wrapper_0/clk_conv_ar_size    ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_arburst ]  [get_bd_pins chip_top_wrapper_0/clk_conv_ar_burst   ]
  
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_arcache ]  [get_bd_pins chip_top_wrapper_0/clk_conv_ar_cache   ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_arprot  ]  [get_bd_pins chip_top_wrapper_0/clk_conv_ar_prot    ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_arqos   ]  [get_bd_pins chip_top_wrapper_0/clk_conv_ar_qos     ]
  
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_arvalid ]  [get_bd_pins chip_top_wrapper_0/clk_conv_ar_valid   ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_rready  ]  [get_bd_pins chip_top_wrapper_0/clk_conv_r_ready    ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_rlast   ]  [get_bd_pins chip_top_wrapper_0/clk_conv_r_last     ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_rvalid  ]  [get_bd_pins chip_top_wrapper_0/clk_conv_r_valid    ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_rresp   ]  [get_bd_pins chip_top_wrapper_0/clk_conv_r_resp     ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_rid     ]  [get_bd_pins chip_top_wrapper_0/clk_conv_r_id       ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_rdata   ]  [get_bd_pins chip_top_wrapper_0/clk_conv_r_data     ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_arready ]  [get_bd_pins chip_top_wrapper_0/clk_conv_ar_ready   ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_bvalid  ]  [get_bd_pins chip_top_wrapper_0/clk_conv_b_valid    ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_bid     ]  [get_bd_pins chip_top_wrapper_0/clk_conv_b_id       ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_wready  ]  [get_bd_pins chip_top_wrapper_0/clk_conv_w_ready    ]
  connect_bd_net  [get_bd_pins mig_7series_0/s_axi_awready ]  [get_bd_pins chip_top_wrapper_0/clk_conv_aw_ready   ]

save_bd_design

endgroup

#startgroup
#
#create_bd_cell -type module -reference chip_top_wrapper chip_top_wrapper_0
#
#update_compile_order -fileset sources_1
#
#create_bd_cell -type module -reference chip_top_wrapper chip_top_wrapper_0
#
#update_compile_order -fileset sources_1
















# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
set files [list \
               [file normalize $base_dir/src/test/verilog/host_behav.sv] \
               [file normalize $base_dir/src/test/verilog/nasti_ram_behav.sv] \
               [file normalize $base_dir/src/test/verilog/chip_top_tb.sv] \
              ]
add_files -norecurse -fileset $obj $files

# add include path
set_property include_dirs [list \
                               [file normalize $base_dir/src/main/verilog] \
                               [file normalize $origin_dir/src] \
                               [file normalize $origin_dir/generated-src] \
                               [file normalize $proj_dir/$project_name.srcs/sources_1/ip/mig_7series_0/mig_7series_0/example_design/sim] \
                              ] $obj
#set_property verilog_define [list FPGA FPGA_FULL NEXYS4] $obj
set_property verilog_define [list FPGA] $obj

set_property -name {xsim.elaborate.xelab.more_options} -value {-cc gcc -sv_lib dpi} -objects $obj
set_property "top" "tb" $obj

# force create the sim_1/behav path (need to make soft link in Makefile)
#launch_simulation -scripts_only



update_compile_order -fileset sim_1