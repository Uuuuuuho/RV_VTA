add_files -norecurse -scan_for_includes /home/uho/workspace/lowriscv_chip/HW/porting_src/src/main/verilog/debugging_module.v
import_files -norecurse /home/uho/workspace/lowriscv_chip/HW/porting_src/src/main/verilog/debugging_module.v

add_files -norecurse -scan_for_includes /home/uho/workspace/lowriscv_chip_wo_interconnect/HW/porting_src/src/main/verilog/debugging_module.v
import_files -norecurse /home/uho/workspace/lowriscv_chip_wo_interconnect/HW/porting_src/src/main/verilog/debugging_module.v




create_bd_cell -type module -reference debugging_module debugging_module_b4AXI_0
connect_bd_net [get_bd_pins debugging_module_b4AXI_0/clk] [get_bd_pins clk_wiz_0/clk_cpu]

connect_bd_net [get_bd_pins debugging_module_b4AXI_0/awvalid] [get_bd_pins chip_top_mod_wrapper_0/mmio_m_axi_awvalid	]
connect_bd_net [get_bd_pins debugging_module_b4AXI_0/arvalid] [get_bd_pins chip_top_mod_wrapper_0/mmio_m_axi_arvalid	]
connect_bd_net [get_bd_pins debugging_module_b4AXI_0/awaddr ] [get_bd_pins chip_top_mod_wrapper_0/mmio_m_axi_awaddr 	]
connect_bd_net [get_bd_pins debugging_module_b4AXI_0/araddr ] [get_bd_pins chip_top_mod_wrapper_0/mmio_m_axi_araddr 	]
connect_bd_net [get_bd_pins debugging_module_b4AXI_0/awready] [get_bd_pins axi_interconnect_1/S00_AXI_awready			]
connect_bd_net [get_bd_pins debugging_module_b4AXI_0/arready] [get_bd_pins axi_interconnect_1/S00_AXI_arready			]
connect_bd_net [get_bd_pins debugging_module_b4AXI_0/rst_x  ] [get_bd_pins mig_7series_0/mmcm_locked					]

connect_bd_net [get_bd_pins chip_top_mod_wrapper_0/mmio_m_axi_awvalid] [get_bd_pins axi_interconnect_1/S00_AXI_awvalid]
connect_bd_net [get_bd_pins chip_top_mod_wrapper_0/mmio_m_axi_arvalid] [get_bd_pins axi_interconnect_1/S00_AXI_arvalid]
connect_bd_net [get_bd_pins chip_top_mod_wrapper_0/mmio_m_axi_awaddr ] [get_bd_pins axi_interconnect_1/S00_AXI_awaddr ]
connect_bd_net [get_bd_pins chip_top_mod_wrapper_0/mmio_m_axi_araddr ] [get_bd_pins axi_interconnect_1/S00_AXI_araddr ]
connect_bd_net [get_bd_pins chip_top_mod_wrapper_0/mmio_m_axi_awready] [get_bd_pins axi_interconnect_1/S00_AXI_awready]
connect_bd_net [get_bd_pins chip_top_mod_wrapper_0/mmio_m_axi_arready] [get_bd_pins axi_interconnect_1/S00_AXI_arready]






create_bd_cell -type module -reference debugging_module debugging_module_afterAXI_0
connect_bd_net [get_bd_pins debugging_module_afterAXI_0/clk    ] [get_bd_pins clk_wiz_0/clk_cpu					]

connect_bd_net [get_bd_pins debugging_module_afterAXI_0/awvalid] [get_bd_pins axi_interconnect_1/M00_AXI_awvalid				]
connect_bd_net [get_bd_pins debugging_module_afterAXI_0/arvalid] [get_bd_pins axi_interconnect_1/M00_AXI_arvalid				]
connect_bd_net [get_bd_pins debugging_module_afterAXI_0/awaddr ] [get_bd_pins axi_interconnect_1/M00_AXI_awaddr 				]
connect_bd_net [get_bd_pins debugging_module_afterAXI_0/araddr ] [get_bd_pins axi_interconnect_1/M00_AXI_araddr 				]
connect_bd_net [get_bd_pins debugging_module_afterAXI_0/awready] [get_bd_pins chip_top_mod_wrapper_0/Inter_to_Bram_axi_awready	]
connect_bd_net [get_bd_pins debugging_module_afterAXI_0/arready] [get_bd_pins chip_top_mod_wrapper_0/Inter_to_Bram_axi_arready	]
connect_bd_net [get_bd_pins debugging_module_afterAXI_0/rst_x  ] [get_bd_pins mig_7series_0/mmcm_locked							]

connect_bd_net [get_bd_pins chip_top_mod_wrapper_0/Inter_to_Bram_axi_awvalid] [get_bd_pins axi_interconnect_1/M00_AXI_awvalid]
connect_bd_net [get_bd_pins chip_top_mod_wrapper_0/Inter_to_Bram_axi_arvalid] [get_bd_pins axi_interconnect_1/M00_AXI_arvalid]
connect_bd_net [get_bd_pins chip_top_mod_wrapper_0/Inter_to_Bram_axi_awaddr ] [get_bd_pins axi_interconnect_1/M00_AXI_awaddr ]
connect_bd_net [get_bd_pins chip_top_mod_wrapper_0/Inter_to_Bram_axi_araddr ] [get_bd_pins axi_interconnect_1/M00_AXI_araddr ]
connect_bd_net [get_bd_pins chip_top_mod_wrapper_0/Inter_to_Bram_axi_awready] [get_bd_pins axi_interconnect_1/M00_AXI_awready]
connect_bd_net [get_bd_pins chip_top_mod_wrapper_0/Inter_to_Bram_axi_arready] [get_bd_pins axi_interconnect_1/M00_AXI_arready]





create_bd_cell -type module -reference debugging_module debugging_module_for_AddBram
connect_bd_net [get_bd_pins debugging_module_for_AddBram/clk    ] [get_bd_pins clk_wiz_0/clk_cpu					]

connect_bd_net [get_bd_pins debugging_module_for_AddBram/awvalid] [get_bd_pins axi_interconnect_1/M01_AXI_awvalid]
connect_bd_net [get_bd_pins debugging_module_for_AddBram/arvalid] [get_bd_pins axi_interconnect_1/M01_AXI_arvalid]
connect_bd_net [get_bd_pins debugging_module_for_AddBram/awaddr ] [get_bd_pins axi_interconnect_1/M01_AXI_awaddr ]
connect_bd_net [get_bd_pins debugging_module_for_AddBram/araddr ] [get_bd_pins axi_interconnect_1/M01_AXI_araddr ]
connect_bd_net [get_bd_pins debugging_module_for_AddBram/awready] [get_bd_pins axi_bram_ctrl_0/S_AXI_awready]
connect_bd_net [get_bd_pins debugging_module_for_AddBram/arready] [get_bd_pins axi_bram_ctrl_0/S_AXI_arready]
connect_bd_net [get_bd_pins debugging_module_for_AddBram/rst_x  ] [get_bd_pins mig_7series_0/mmcm_locked			]

connect_bd_net [get_bd_pins axi_bram_ctrl_0/S_AXI_awvalid       ] [get_bd_pins axi_interconnect_1/M01_AXI_awvalid]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/S_AXI_arvalid       ] [get_bd_pins axi_interconnect_1/M01_AXI_arvalid]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/S_AXI_awaddr        ] [get_bd_pins axi_interconnect_1/M01_AXI_awaddr ]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/S_AXI_araddr        ] [get_bd_pins axi_interconnect_1/M01_AXI_araddr ]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/S_AXI_awready       ] [get_bd_pins axi_interconnect_1/M01_AXI_awready]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/S_AXI_arready       ] [get_bd_pins axi_interconnect_1/M01_AXI_arready]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn	    ] [get_bd_pins mig_7series_0/mmcm_locked		 ]





connect_bd_net [get_bd_pins debugging_module_for_AddBram/awvalid] [get_bd_pins axi_interconnect_1/M00_AXI_awvalid	]
connect_bd_net [get_bd_pins debugging_module_for_AddBram/arvalid] [get_bd_pins axi_interconnect_1/M00_AXI_arvalid	]
connect_bd_net [get_bd_pins debugging_module_for_AddBram/awaddr ] [get_bd_pins axi_interconnect_1/M00_AXI_awaddr 	]
connect_bd_net [get_bd_pins debugging_module_for_AddBram/araddr ] [get_bd_pins axi_interconnect_1/M00_AXI_araddr 	]
connect_bd_net [get_bd_pins debugging_module_for_AddBram/awready] [get_bd_pins axi_bram_ctrl_0/S_AXI_awready		]
connect_bd_net [get_bd_pins debugging_module_for_AddBram/arready] [get_bd_pins axi_bram_ctrl_0/S_AXI_arready		]
connect_bd_net [get_bd_pins debugging_module_for_AddBram/rst_x  ] [get_bd_pins mig_7series_0/mmcm_locked			]

connect_bd_net [get_bd_pins axi_bram_ctrl_0/S_AXI_awvalid       ] [get_bd_pins axi_interconnect_1/M00_AXI_awvalid	]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/S_AXI_arvalid       ] [get_bd_pins axi_interconnect_1/M00_AXI_arvalid	]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/S_AXI_awaddr        ] [get_bd_pins axi_interconnect_1/M00_AXI_awaddr 	]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/S_AXI_araddr        ] [get_bd_pins axi_interconnect_1/M00_AXI_araddr 	]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/S_AXI_awready       ] [get_bd_pins axi_interconnect_1/M00_AXI_awready	]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/S_AXI_arready       ] [get_bd_pins axi_interconnect_1/M00_AXI_arready	]
connect_bd_net [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn	    ] [get_bd_pins mig_7series_0/mmcm_locked		 	]


connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_awready 	] [get_bd_pins axi_bram_ctrl_0/s_axi_awready 	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_awvalid  ] [get_bd_pins axi_bram_ctrl_0/s_axi_awvalid  	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_awaddr   ] [get_bd_pins axi_bram_ctrl_0/s_axi_awaddr   	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_awlen    ] [get_bd_pins axi_bram_ctrl_0/s_axi_awlen    	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_awsize   ] [get_bd_pins axi_bram_ctrl_0/s_axi_awsize   	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_awburst  ] [get_bd_pins axi_bram_ctrl_0/s_axi_awburst  	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_awcache  ] [get_bd_pins axi_bram_ctrl_0/s_axi_awcache  	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_awprot   ] [get_bd_pins axi_bram_ctrl_0/s_axi_awprot   	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_wready   ] [get_bd_pins axi_bram_ctrl_0/s_axi_wready   	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_wvalid   ] [get_bd_pins axi_bram_ctrl_0/s_axi_wvalid   	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_wdata    ] [get_bd_pins axi_bram_ctrl_0/s_axi_wdata    	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_wstrb    ] [get_bd_pins axi_bram_ctrl_0/s_axi_wstrb    	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_wlast    ] [get_bd_pins axi_bram_ctrl_0/s_axi_wlast    	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_bready   ] [get_bd_pins axi_bram_ctrl_0/s_axi_bready   	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_bvalid   ] [get_bd_pins axi_bram_ctrl_0/s_axi_bvalid   	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_bresp    ] [get_bd_pins axi_bram_ctrl_0/s_axi_bresp    	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_arready  ] [get_bd_pins axi_bram_ctrl_0/s_axi_arready  	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_arvalid  ] [get_bd_pins axi_bram_ctrl_0/s_axi_arvalid  	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_araddr   ] [get_bd_pins axi_bram_ctrl_0/s_axi_araddr   	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_arlen    ] [get_bd_pins axi_bram_ctrl_0/s_axi_arlen    	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_arsize   ] [get_bd_pins axi_bram_ctrl_0/s_axi_arsize   	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_arburst  ] [get_bd_pins axi_bram_ctrl_0/s_axi_arburst  	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_arcache  ] [get_bd_pins axi_bram_ctrl_0/s_axi_arcache  	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_arprot   ] [get_bd_pins axi_bram_ctrl_0/s_axi_arprot   	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_rready   ] [get_bd_pins axi_bram_ctrl_0/s_axi_rready   	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_rvalid   ] [get_bd_pins axi_bram_ctrl_0/s_axi_rvalid   	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_rdata    ] [get_bd_pins axi_bram_ctrl_0/s_axi_rdata    	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_rresp    ] [get_bd_pins axi_bram_ctrl_0/s_axi_rresp    	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_rlast    ] [get_bd_pins axi_bram_ctrl_0/s_axi_rlast    	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_awlock	] [get_bd_pins axi_bram_ctrl_0/s_axi_awlock		]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_arlock	] [get_bd_pins axi_bram_ctrl_0/s_axi_arlock		]


connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_awqos    ] [get_bd_pins axi_bram_ctrl_0/s_axi_awqos    	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_arqos    ] [get_bd_pins axi_bram_ctrl_0/s_axi_arqos    	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_awid     ] [get_bd_pins axi_bram_ctrl_0/s_axi_awid     	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_bid      ] [get_bd_pins axi_bram_ctrl_0/s_axi_bid      	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_arid     ] [get_bd_pins axi_bram_ctrl_0/s_axi_arid     	]
connect_bd_net [get_bd_pins axi_interconnect_1/M00_AXI_rid      ] [get_bd_pins axi_bram_ctrl_0/s_axi_rid      	]


create_ip -name axi_bram_ctrl -vendor xilinx.com -library ip -module_name axi_bram_ctrl_tester

set_property -dict [list \
                        CONFIG.DATA_WIDTH {64} \
                        CONFIG.ID_WIDTH {4} \
                        CONFIG.MEM_DEPTH {32768} \
                        CONFIG.PROTOCOL {AXI4} \
                        CONFIG.BMG_INSTANCE {EXTERNAL} \
                        CONFIG.SINGLE_PORT_BRAM {1} \
                        CONFIG.SUPPORTS_NARROW_BURST {1} \
                       ] [get_ips axi_bram_ctrl_tester]



set_property -dict [list \
                        CONFIG.DATA_WIDTH {64} \
                        CONFIG.ID_WIDTH {4} \
                        CONFIG.MEM_DEPTH {32768} \
                        CONFIG.PROTOCOL {AXI4} \
                        CONFIG.BMG_INSTANCE {EXTERNAL} \
                        CONFIG.SINGLE_PORT_BRAM {1} \
                        CONFIG.SUPPORTS_NARROW_BURST {1} \
                       ] [get_bd_cells axi_bram_ctrl_0]




