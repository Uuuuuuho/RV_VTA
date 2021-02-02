// See LICENSE for license details.

`include "consts.vh"
`include "config.vh"

// Allow ISA regression test to use proper FPGA configuration
`ifdef ADD_HOST
`ifndef FPGA
`undef ADD_BRAM
`undef ADD_UART
`undef ADD_FLASH
`undef ADD_SPI
`undef ADD_ETH
`endif
`endif

module chip_top_modified
  (
// `ifdef ADD_PHY_DDR
 // `ifdef KC705
   // DDR3 RAM
   // inout wire [63:0]  ddr_dq,
   // inout wire [7:0]   ddr_dqs_n,
   // inout wire [7:0]   ddr_dqs_p,
   // input wire [13:0] ddr_addr,
   // input wire [2:0]  ddr_ba,
   // input wire        ddr_ras_n,
   // input wire        ddr_cas_n,
   // input wire        ddr_we_n,
   // input wire        ddr_reset_n,
   // input wire        ddr_ck_n,
   // input wire        ddr_ck_p,
   // input wire        ddr_cke,
   // input wire        ddr_cs_n,
   // input wire [7:0]  ddr_dm,
   // input wire        ddr_odt,

	
	
	// // DDR3 RAM
   // output wire [63:0]  	ddr_dq,
   // output wire [7:0]   	ddr_dqs_n,
   // output wire [7:0]   	ddr_dqs_p,
   // output wire [13:0] 	ddr_addr,
   // output wire [2:0]  	ddr_ba,
   // output wire        	ddr_ras_n,
   // output wire        	ddr_cas_n,
   // output wire        	ddr_we_n,
   // output wire        	ddr_reset_n,
   // output wire        	ddr_ck_n,
   // output wire        	ddr_ck_p,
   // output wire        	ddr_cke,
   // output wire        	ddr_cs_n,
   // output wire [7:0]  	ddr_dm,
   // output wire        	ddr_odt,



	//=============================
	// interface between clock converter & mig_7
	//=============================
	
	output wire 		clk_conv_aw_id     	, 
    output wire 		clk_conv_aw_addr   	, 
    output wire 		clk_conv_aw_len    	, 
    output wire 		clk_conv_aw_size   	, 
    output wire 		clk_conv_aw_burst  	, 
    output wire 		clk_conv_aw_cache  	, 
    output wire 		clk_conv_aw_prot   	, 
    output wire 		clk_conv_aw_qos    	, 
    output wire 		clk_conv_aw_region 	, 
    output wire 		clk_conv_aw_valid  	, 
    output wire 		clk_conv_w_data    	, 
    output wire 		clk_conv_w_strb    	, 
    output wire 		clk_conv_w_last    	, 
    output wire 		clk_conv_w_valid   	, 
    output wire 		clk_conv_b_ready   	, 
    output wire 		clk_conv_ar_id     	, 
    output wire 		clk_conv_ar_addr   	,
    output wire 		clk_conv_ar_len    	, 
    output wire 		clk_conv_ar_size   	, 
    output wire 		clk_conv_ar_burst  	, 
    output wire 		clk_conv_ar_cache  	, 
    output wire 		clk_conv_ar_prot   	, 
    output wire 		clk_conv_ar_qos    	, 
    output wire 		clk_conv_ar_region 	, 
    output wire 		clk_conv_ar_valid  	, 
    output wire 		clk_conv_r_ready   	, 
						
						
						
						
	input wire [1:0]	clk_conv_b_resp    	, 					
    input wire 			clk_conv_r_last     ,
    input wire 			clk_conv_r_valid    ,
    input wire 			clk_conv_r_resp     ,
	input wire 			clk_conv_r_id       ,
	input wire 			clk_conv_r_data     ,
	input wire 			clk_conv_ar_ready   ,
	input wire 			clk_conv_b_valid    ,
	input wire 			clk_conv_b_id       ,
	input wire 			clk_conv_w_ready    ,
	input wire 			clk_conv_aw_ready   ,
	
	input wire			ui_clk_sync_rst		,


	//=============================
	// clk_wiz_0 interface
	//=============================

	input wire 			clk_mii       	,	// 25 MHz MII
	input wire 			clk_cpu       	,	// 50 MHz
	input wire 			clk_out1		   	,	// 200 MHz
	input wire 			clk_pixel     	,	// 120 MHz
	input wire			locked			,

	// output wire 		clk_in1	    	, 	// 100 MHz from MIG
	// output wire 		reset 	       	,
	
	
//====================
//  in case clk_wiz_1 should be removed
//====================

	// Clock in ports
	// output wire 		clk_in1			,   // input clk_in1
	// Clock out ports	
	input wire 			clk_sdclk		,   // output clk_sdclk
	// Dynamic reconfiguration ports	
	output wire 		daddr			, 	// input [6:0] daddr
	// output wire 		dclk			,	// input dclk
	output wire 		den				,	// input den
	output wire 		din				, 	// input [15:0] din
	input wire 			dout			, 	// output [15:0] dout
	input wire 			drdy			, 	// output drdy
	output wire 		dwe				, 	// input dwe
	// Status and control signals	
	output wire 		reset			,	//(~(sd_clk_rst&rstn))		, 	// input reset
	input wire 			sd_clk_locked	,





	
	
	
	
	//=============================
	//  interface between Rocket & clock converter
	//=============================
	
	//was input to be output
	
	// output wire 		clk_conv_to_rocket_s_axi_awid      	,
	// output wire 		clk_conv_to_rocket_s_axi_awaddr    	,
	// output wire 		clk_conv_to_rocket_s_axi_awlen     	,
	// output wire 		clk_conv_to_rocket_s_axi_awsize    	,
	// output wire 		clk_conv_to_rocket_s_axi_awburst   	,
	// output wire 		clk_conv_to_rocket_s_axi_awcache   	,
	// output wire 		clk_conv_to_rocket_s_axi_awprot    	,
	// output wire 		clk_conv_to_rocket_s_axi_awqos     	,
	// output wire 		clk_conv_to_rocket_s_axi_awvalid   	,
	// output wire 		clk_conv_to_rocket_s_axi_wdata     	,
	// output wire 		clk_conv_to_rocket_s_axi_wstrb     	,
	// output wire 		clk_conv_to_rocket_s_axi_wlast     	,
	// output wire 		clk_conv_to_rocket_s_axi_wvalid    	,
	// output wire 		clk_conv_to_rocket_s_axi_bready    	,
	// output wire 		clk_conv_to_rocket_s_axi_arid      	,
	// output wire 		clk_conv_to_rocket_s_axi_araddr    	,
	// output wire 		clk_conv_to_rocket_s_axi_arlen     	,
	// output wire 		clk_conv_to_rocket_s_axi_arsize    	,
	// output wire 		clk_conv_to_rocket_s_axi_arburst   	,
	// output wire 		clk_conv_to_rocket_s_axi_arcache   	,
	// output wire 		clk_conv_to_rocket_s_axi_arprot    	,
	// output wire 		clk_conv_to_rocket_s_axi_arqos     	,
	// output wire 		clk_conv_to_rocket_s_axi_arvalid   	,
	// output wire 		clk_conv_to_rocket_s_axi_rready    	,
	// output wire 		clk_conv_to_rocket_m_axi_aclk      	,
	// output wire 		clk_conv_to_rocket_m_axi_aresetn   	,
	// output wire 		clk_conv_to_rocket_m_axi_wdata     	,
	// output wire 		clk_conv_to_rocket_m_axi_wstrb     	,
	// output wire 		clk_conv_to_rocket_m_axi_wlast     	,
	// output wire 		clk_conv_to_rocket_m_axi_wvalid    	,
	// output wire 		clk_conv_to_rocket_m_axi_bresp     	,
	// output wire 		clk_conv_to_rocket_m_axi_bready    	,
	// output wire 		clk_conv_to_rocket_m_axi_arid      	,
	// output wire 		clk_conv_to_rocket_m_axi_araddr    	,
	// output wire 		clk_conv_to_rocket_m_axi_arlen     	,
	// output wire 		clk_conv_to_rocket_m_axi_arsize    	,
	// output wire 		clk_conv_to_rocket_m_axi_arburst   	,
	// output wire 		clk_conv_to_rocket_m_axi_arcache   	,
	// output wire 		clk_conv_to_rocket_m_axi_arprot    	,
	// output wire 		clk_conv_to_rocket_m_axi_arqos     	,
	// output wire 		clk_conv_to_rocket_m_axi_arregion  	,
	// output wire 		clk_conv_to_rocket_m_axi_arvalid   	,
	// output wire 		clk_conv_to_rocket_m_axi_rready    	,
	// output wire 		clk_conv_to_rocket_m_axi_rlast     	,


	
	// //was output to be input
	
	// input wire 			clk_conv_to_rocket_s_axi_awready   	,
	// input wire 			clk_conv_to_rocket_s_axi_wready    	,
	// input wire 			clk_conv_to_rocket_s_axi_bid       	,
	// input wire 			clk_conv_to_rocket_s_axi_bresp     	,
	// input wire 			clk_conv_to_rocket_s_axi_bvalid    	,
	// input wire 			clk_conv_to_rocket_s_axi_arready   	,
	// input wire 			clk_conv_to_rocket_s_axi_rid       	,
	// input wire 			clk_conv_to_rocket_s_axi_rdata     	,
	// input wire 			clk_conv_to_rocket_s_axi_rresp     	,
	// input wire 			clk_conv_to_rocket_s_axi_rlast     	,
	// input wire 			clk_conv_to_rocket_s_axi_rvalid    	,
	// input wire 			clk_conv_to_rocket_m_axi_awid      	,
	// input wire 			clk_conv_to_rocket_m_axi_awaddr    	,
	// input wire 			clk_conv_to_rocket_m_axi_awlen     	,
	// input wire 			clk_conv_to_rocket_m_axi_awsize    	,
	// input wire 			clk_conv_to_rocket_m_axi_awburst   	,
	// input wire 			clk_conv_to_rocket_m_axi_awcache   	,
	// input wire 			clk_conv_to_rocket_m_axi_awprot    	,
	// input wire 			clk_conv_to_rocket_m_axi_awqos     	,
	// input wire 			clk_conv_to_rocket_m_axi_awregion  	,
	// input wire 			clk_conv_to_rocket_m_axi_awvalid   	,
	
	
	
	
	//=============================
	//  interface between psoc & clock converter
	//=============================
	
	
	
	// //=============================
	// //  for Bram controller
	// //=============================
	
	
	// //was input to be output
	// output wire 		to_bram_s_axi_aclk      			,    
	// output wire 		to_bram_s_axi_aresetn   			,
	// output wire 		to_bram_s_axi_awid      			,
	// output wire 		to_bram_s_axi_awaddr    			,
	// output wire 		to_bram_s_axi_awlen     			,
	// output wire 		to_bram_s_axi_awsize    			,
	// output wire 		to_bram_s_axi_awburst   			,
	// output wire 		to_bram_s_axi_awlock    			,
	// output wire 		to_bram_s_axi_awcache   			,
	// output wire 		to_bram_s_axi_awprot    			,
	// output wire 		to_bram_s_axi_wdata     			,
	// output wire 		to_bram_s_axi_wstrb     			,
	// output wire 		to_bram_s_axi_wlast     			,
	// output wire 		to_bram_s_axi_wvalid    			,
	// output wire 		to_bram_s_axi_bready    			,
	// output wire 		to_bram_s_axi_arid      			,
	// output wire 		to_bram_s_axi_araddr    			,
	// output wire 		to_bram_s_axi_arlen     			,
	// output wire 		to_bram_s_axi_arsize    			,
	// output wire 		to_bram_s_axi_arburst   			,
	// output wire 		to_bram_s_axi_arlock    			,
	// output wire 		to_bram_s_axi_arcache   			,
	// output wire 		to_bram_s_axi_arprot    			,
	// output wire 		to_bram_s_axi_rready    			,
	// output wire 		to_bram_s_axi_rvalid    			,
	
	// //was output to be input
	
	// input wire 			from_bram_s_axi_arready   			,
	// input wire 			from_bram_s_axi_arvalid   			,
	// input wire 			from_bram_s_axi_rid       			,
	// input wire 			from_bram_s_axi_rdata     			,
	// input wire 			from_bram_s_axi_rresp     			,
	// input wire 			from_bram_s_axi_rlast     			,
	// input wire 			from_bram_s_axi_awready   			,
	// input wire 			from_bram_s_axi_awvalid   			,
	// input wire 			from_bram_s_axi_wready    			,
	// input wire 			from_bram_s_axi_bid       			,
	// input wire 			from_bram_s_axi_bresp     			,
	// input wire 			from_bram_s_axi_bvalid    			,
	// input wire 			from_bram_bram_rst_a      			,
	// input wire 			from_bram_bram_clk_a      			,
	// input wire 			from_bram_bram_en_a       			,
	// input wire 			from_bram_bram_we_a       			,
	// input wire 			from_bram_bram_addr_a     			,
	// input wire 			from_bram_bram_wrdata_a   			,
	// input wire 			from_bram_bram_rddata_a   			,
	
	
	
	
	
	
	
	//=============================
	//  previous try
	//=============================
	
	
	
	//was input to be output
	// output wire 		clk_cpu	      		,    
	// output wire 		rstn                        ,
	
	// output wire 		bramctl_aw_id     			,
	// output wire 		bram_aw_addr[17:0]          ,
	// output wire 		mmio_master_nasti.aw_len    ,
	// output wire 		mmio_master_nasti.aw_size   ,
	// output wire 		mmio_master_nasti.aw_burst  ,
	// output wire 		mmio_master_nasti.aw_lock   ,
	// output wire 		mmio_master_nasti.aw_cache  ,
	// output wire 		mmio_master_nasti.aw_prot   ,
	// output wire 		mmio_master_nasti.w_data    ,
	// output wire 		mmio_master_nasti.w_strb    ,
	// output wire 		mmio_master_nasti.w_last    ,
	// output wire 		mmio_master_nasti.w_valid   ,
	// output wire 		mmio_master_nasti.b_ready   ,
	// output wire 		mmio_master_nasti.ar_id     ,
	// output wire 		bram_ar_addr[17:0]          ,
	// output wire 		mmio_master_nasti.ar_len    ,
	// output wire 		mmio_master_nasti.ar_size   ,
	// output wire 		mmio_master_nasti.ar_burst  ,
	// output wire 		mmio_master_nasti.ar_lock   ,
	// output wire 		mmio_master_nasti.ar_cache  ,
	// output wire 		mmio_master_nasti.ar_prot   ,
	// output wire 		mmio_master_nasti.r_ready   ,
	// output wire 		mmio_master_nasti.r_valid   ,
	
	// //was output to be input
	
	// input wire 			mmio_master_nasti.ar_ready  ,
	// input wire 			mmio_master_nasti.ar_valid  ,
	// input wire 			mmio_master_nasti.r_id      ,
	// input wire 			mmio_master_nasti.r_data    ,
	// input wire 			mmio_master_nasti.r_resp    ,
	// input wire 			mmio_master_nasti.r_last    ,
	// input wire 			mmio_master_nasti.aw_ready  ,
	// input wire 			mmio_master_nasti.aw_valid  ,
	// input wire 			mmio_master_nasti.w_ready   ,
	// input wire 			mmio_master_nasti.b_id      ,
	// input wire 			mmio_master_nasti.b_resp    ,
	// input wire 			mmio_master_nasti.b_valid   ,
	// input wire 			hid_rst                     ,
	// input wire 			hid_clk                     ,
	// input wire 			hid_en                      ,
	// input wire 			hid_we                      ,
	// input wire 			hid_addr                    ,
	// input wire 			hid_wrdata                  ,
	// input wire 			hid_rddata                  ,
	
	
	
	
	
	
	
	
	
/*
   inout wire [63:0]  ddr_dq,
   inout wire [7:0]   ddr_dqs_n,
   inout wire [7:0]   ddr_dqs_p,
   output wire [13:0] ddr_addr,
   output wire [2:0]  ddr_ba,
   output wire        ddr_ras_n,
   output wire        ddr_cas_n,
   output wire        ddr_we_n,
   output wire        ddr_reset_n,
   output wire        ddr_ck_n,
   output wire        ddr_ck_p,
   output wire        ddr_cke,
   output wire        ddr_cs_n,
   output wire [7:0]  ddr_dm,
   output wire        ddr_odt,
  */ 
   
   
   
   
   
 // `endif
// `endif 
//  `ifdef ADD_DDR_IO

`ifdef ADD_FLASH
   inout wire         flash_ss,
   inout wire [3:0]   flash_io,
`endif

`ifdef ADD_SPI
   inout wire         spi_cs,
   inout wire         spi_sclk,
   inout wire         spi_mosi,
   inout wire         spi_miso,
   output wire        sd_reset,
`endif

// `ifdef ADD_HID
   // Simple UART interface
   input wire         rxd,
   output wire        txd,
   output wire        rts,
   input wire         cts,

   // 4-bit full SD interface
   inout wire         sd_sclk,
   input wire         sd_detect,
   inout wire [3:0]   sd_dat,
   inout wire         sd_cmd,
   output wire        sd_reset,

   // // LED and DIP switch
 // `ifdef NEXYS4_COMMON
 // `else
   output wire [7:0]  o_led,
   input wire  [3:0]  i_dip,
 // `endif
   // // push button array
   input wire         GPIO_SW_C,
   input wire         GPIO_SW_W,
   input wire         GPIO_SW_E,
   input wire         GPIO_SW_N,
   input wire         GPIO_SW_S,
   //keyboard
   inout wire         PS2_CLK,
   inout wire         PS2_DATA,

 // //! Ethernet MAC PHY interface signals
	input wire         i_erx_dv, // PHY data valid
	input wire         i_erx_er, // PHY coding error
	input wire         i_emdint, // PHY interrupt in active low
	output reg         o_erefclk, // RMII clock out
	output reg         o_etx_en, // RMII transmit enable
// `ifdef KC705   
	input wire [3:0]   i_erxd, // RMII receive data
	output reg [7:0]   o_etxd, // RMII transmit data
	output reg         o_etx_er, // RMII transmit enable
	input wire         i_gmiiclk_p,
	input wire         i_gmiiclk_n,
	input wire         i_erx_clk,
	input wire         i_etx_clk,
// `else
	// input wire [1:0]   i_erxd, // RMII receive data
	// output reg [1:0]   o_etxd, // RMII transmit data
// `endif   
	output wire        o_emdc, // MDIO clock
	inout wire         io_emdio, // MDIO inout
	output wire        o_erstn, // PHY reset active low
// `endif
	// // clock and reset
	// input wire         clk_p,
	// input wire         clk_n,
	input wire         rst_top
	
	
	
   );
   
   
   
   
//=================================
//input/output settings till here
//=================================




   wire               clk_locked;
   // logic clk_mii, clk_mii_quad;
   logic clk_mii_quad;
              
`ifdef KC705
   wire        VGA_HS_O;
   wire        VGA_VS_O;
   wire [3:0]  VGA_RED_O;
   wire [3:0]  VGA_BLUE_O;
   wire [3:0]  VGA_GREEN_O;
   logic [3:0]  eth_rxd;
   logic [7:0] unused_led;
`else
   logic [1:0]  eth_rxd;
 // RMII receive data
   wire clk_rmii, clk_rmii_quad;
`endif

   genvar        i;

   // internal clock and reset signals
   logic  clk, rst, rstn;
   assign rst = !rstn;

   // Debug controlled reset of the Rocket system
   logic  sys_rst;
   // Interrupts
   logic spi_irq, sd_irq, eth_irq, uart_irq;
   // Miscellaneous
   logic TDO_driven;
   /////////////////////////////////////////////////////////////
   // NASTI/Lite on-chip interconnects

   // Rocket memory nasti bus
   nasti_channel
     #(
       .ID_WIDTH    ( `MEM_ID_WIDTH   ),
       .ADDR_WIDTH  ( `MEM_ADDR_WIDTH ),
       .DATA_WIDTH  ( `MEM_DATA_WIDTH ))
   mem_nasti();
wire io_emdio_i, phy_emdio_o, phy_emdio_t, clk_locked_wiz;
reg phy_emdio_i, io_emdio_o, io_emdio_t;

`ifdef ADD_PHY_DDR

   // the NASTI bus for off-FPGA DRAM, converted to High frequency
   nasti_channel   
     #(
       .ID_WIDTH    ( `MEM_ID_WIDTH   ),
       .ADDR_WIDTH  ( `MEM_ADDR_WIDTH ),
       .DATA_WIDTH  ( `MEM_DATA_WIDTH ))
   mem_mig_nasti();

 `ifdef ZED
   // Clock is generated by PS7, and reset as well.
   // So there is no need to clock generator,
   // just use the inputs to the module
   assign clk = clk_p;
   assign rstn = !rst_top;

   assign mem_nasti_dram_araddr       = mem_nasti.ar_addr      ;
   assign mem_nasti_dram_arburst      = mem_nasti.ar_burst     ;
   assign mem_nasti_dram_arcache      = mem_nasti.ar_cache     ;
   assign mem_nasti_dram_arid         = mem_nasti.ar_id        ;
   assign mem_nasti_dram_arlen        = mem_nasti.ar_len       ;
   assign mem_nasti_dram_arlock       = mem_nasti.ar_lock      ;
   assign mem_nasti_dram_arprot       = mem_nasti.ar_prot      ;
   assign mem_nasti_dram_arqos        = mem_nasti.ar_qos       ;
   assign mem_nasti_dram_arready      = mem_nasti.ar_ready     ;
   assign mem_nasti_dram_arsize       = mem_nasti.ar_size      ;
   assign mem_nasti_dram_arvalid      = mem_nasti.ar_valid     ;
   assign mem_nasti_dram_arregion     = mem_nasti.ar_region    ;
   assign mem_nasti_dram_awaddr       = mem_nasti.aw_addr      ;
   assign mem_nasti_dram_awburst      = mem_nasti.aw_burst     ;
   assign mem_nasti_dram_awcache      = mem_nasti.aw_cache     ;
   assign mem_nasti_dram_awid         = mem_nasti.aw_id        ;
   assign mem_nasti_dram_awlen        = mem_nasti.aw_len       ;
   assign mem_nasti_dram_awlock       = mem_nasti.aw_lock      ;
   assign mem_nasti_dram_awprot       = mem_nasti.aw_prot      ;
   assign mem_nasti_dram_awqos        = mem_nasti.aw_qos       ;
   assign mem_nasti_dram_awready      = mem_nasti.aw_ready     ;
   assign mem_nasti_dram_awsize       = mem_nasti.aw_size      ;
   assign mem_nasti_dram_awvalid      = mem_nasti.aw_valid     ;
   assign mem_nasti_dram_awregion     = mem_nasti.aw_region    ;
   assign mem_nasti_dram_bid          = mem_nasti.b_id         ;
   assign mem_nasti_dram_bready       = mem_nasti.b_ready      ;
   assign mem_nasti_dram_bresp        = mem_nasti.b_resp       ;
   assign mem_nasti_dram_bvalid       = mem_nasti.b_valid      ;
   assign mem_nasti_dram_rdata        = mem_nasti.r_data       ;
   assign mem_nasti_dram_rid          = mem_nasti.r_id         ;
   assign mem_nasti_dram_rlast        = mem_nasti.r_last       ;
   assign mem_nasti_dram_rready       = mem_nasti.r_ready      ;
   assign mem_nasti_dram_rresp        = mem_nasti.r_resp       ;
   assign mem_nasti_dram_rvalid       = mem_nasti.r_valid      ;
   assign mem_nasti_dram_wdata        = mem_nasti.w_data       ;
   assign mem_nasti_dram_wlast        = mem_nasti.w_last       ;
   assign mem_nasti_dram_wready       = mem_nasti.w_ready      ;
   assign mem_nasti_dram_wstrb        = mem_nasti.w_strb       ;
   assign mem_nasti_dram_wvalid       = mem_nasti.w_valid      ;

 `else // !`ifndef ZED

   // MIG clock
   logic mig_ui_clk, mig_ui_rst, mig_ui_rstn;

	// //added this line
	// assign mig_ui_rst = ui_clk_sync_rst;

   // assign mig_ui_rstn = !mig_ui_rst;
   assign mig_ui_rstn = !ui_clk_sync_rst;

`ifdef NEXYS4DDR
`define MEM_NASTI mem_mig_nasti
assign clk = mig_ui_clk;
`else
`define MEM_NASTI mem_nasti

   // clock converter
   axi_clock_converter_0 clk_conv
     (
      .s_axi_aclk           ( clk_cpu			),
      .s_axi_aresetn        ( rstn                     ),


      .s_axi_awid           ( mem_nasti.aw_id          ),
      .s_axi_awaddr         ( mem_nasti.aw_addr        ),
      .s_axi_awlen          ( mem_nasti.aw_len         ),
      .s_axi_awsize         ( mem_nasti.aw_size        ),
      .s_axi_awburst        ( mem_nasti.aw_burst       ),
      // .s_axi_awlock         ( 1'b0                     ), // not supported in AXI4
      .s_axi_awcache        ( mem_nasti.aw_cache       ),
      .s_axi_awprot         ( mem_nasti.aw_prot        ),
      .s_axi_awqos          ( mem_nasti.aw_qos         ),
      // .s_axi_awregion       ( 4'b0                     ), // not supported in AXI4
      .s_axi_awvalid        ( mem_nasti.aw_valid       ),
      .s_axi_awready        ( mem_nasti.aw_ready       ),
      .s_axi_wdata          ( mem_nasti.w_data         ),
      .s_axi_wstrb          ( mem_nasti.w_strb         ),
      .s_axi_wlast          ( mem_nasti.w_last         ),
      .s_axi_wvalid         ( mem_nasti.w_valid        ),
      .s_axi_wready         ( mem_nasti.w_ready        ),
      .s_axi_bid            ( mem_nasti.b_id           ),
      .s_axi_bresp          ( mem_nasti.b_resp         ),
      .s_axi_bvalid         ( mem_nasti.b_valid        ),
      .s_axi_bready         ( mem_nasti.b_ready        ),
      .s_axi_arid           ( mem_nasti.ar_id          ),
      .s_axi_araddr         ( mem_nasti.ar_addr        ),
      .s_axi_arlen          ( mem_nasti.ar_len         ),
      .s_axi_arsize         ( mem_nasti.ar_size        ),
      .s_axi_arburst        ( mem_nasti.ar_burst       ),
      // .s_axi_arlock         ( 1'b0                     ), // not supported in AXI4
      .s_axi_arcache        ( mem_nasti.ar_cache       ),
      .s_axi_arprot         ( mem_nasti.ar_prot        ),
      .s_axi_arqos          ( mem_nasti.ar_qos         ),
      // .s_axi_arregion       ( 4'b0                     ), // not supported in AXI4
      .s_axi_arvalid        ( mem_nasti.ar_valid       ),
      .s_axi_arready        ( mem_nasti.ar_ready       ),
      .s_axi_rid            ( mem_nasti.r_id           ),
      .s_axi_rdata          ( mem_nasti.r_data         ),
      .s_axi_rresp          ( mem_nasti.r_resp         ),
      .s_axi_rlast          ( mem_nasti.r_last         ),
      .s_axi_rvalid         ( mem_nasti.r_valid        ),
      .s_axi_rready         ( mem_nasti.r_ready        ),
	  
	  
	  
      .m_axi_aclk           ( mig_ui_clk               ),
      .m_axi_aresetn        ( mig_ui_rstn              ),
	  
	  
		// //interface between clock converter & dram controller
      // .m_axi_awid           ( mem_mig_nasti.aw_id      ),
      // .m_axi_awaddr         ( mem_mig_nasti.aw_addr    ),
      // .m_axi_awlen          ( mem_mig_nasti.aw_len     ),
      // .m_axi_awsize         ( mem_mig_nasti.aw_size    ),
      // .m_axi_awburst        ( mem_mig_nasti.aw_burst   ),
      // .m_axi_awlock         (                          ), // not supported in AXI4
      // .m_axi_awcache        ( mem_mig_nasti.aw_cache   ),
      // .m_axi_awprot         ( mem_mig_nasti.aw_prot    ),
      // .m_axi_awqos          ( mem_mig_nasti.aw_qos     ),
      // .m_axi_awregion       ( mem_mig_nasti.aw_region  ),
      // .m_axi_awvalid        ( mem_mig_nasti.aw_valid   ),
      
      // .m_axi_wdata          ( mem_mig_nasti.w_data     ),
      // .m_axi_wstrb          ( mem_mig_nasti.w_strb     ),
      // .m_axi_wlast          ( mem_mig_nasti.w_last     ),
      // .m_axi_wvalid         ( mem_mig_nasti.w_valid    ),
      
      
      // .m_axi_bresp          ( mem_mig_nasti.b_resp     ),
      
      // .m_axi_bready         ( mem_mig_nasti.b_ready    ),
      // .m_axi_arid           ( mem_mig_nasti.ar_id      ),
      // .m_axi_araddr         ( mem_mig_nasti.ar_addr    ),
      // .m_axi_arlen          ( mem_mig_nasti.ar_len     ),
      // .m_axi_arsize         ( mem_mig_nasti.ar_size    ),
      // .m_axi_arburst        ( mem_mig_nasti.ar_burst   ),
      // .m_axi_arlock         (                          ), // not supported in AXI4
      // .m_axi_arcache        ( mem_mig_nasti.ar_cache   ),
      // .m_axi_arprot         ( mem_mig_nasti.ar_prot    ),
      // .m_axi_arqos          ( mem_mig_nasti.ar_qos     ),
      // .m_axi_arregion       ( mem_mig_nasti.ar_region  ),
      // .m_axi_arvalid        ( mem_mig_nasti.ar_valid   ),
      
      // .m_axi_rready         ( mem_mig_nasti.r_ready    ),
	  
	  
	  
	  // //input ports
	  
	  // .m_axi_rlast          ( mem_mig_nasti.r_last     ),
	  // // .m_axi_rvalid         ( mem_mig_nasti.r_valid    ),
	  
	  // // .m_axi_rresp          ( mem_mig_nasti.r_resp     ),
	  // // .m_axi_rid            ( mem_mig_nasti.r_id       ),
      // // .m_axi_rdata          ( mem_mig_nasti.r_data     ),
	  
	  // // .m_axi_arready        ( mem_mig_nasti.ar_ready   ),
	  // // .m_axi_bvalid         ( mem_mig_nasti.b_valid    ),
	  // // .m_axi_bid            ( mem_mig_nasti.b_id       ),
	  // // .m_axi_wready         ( mem_mig_nasti.w_ready    ),
	  // // .m_axi_awready        ( mem_mig_nasti.aw_ready   )

	  
	  
	  
	  
	  
	  //interface between clock converter & dram controller
      .m_axi_awid           ( clk_conv_aw_id     		),	
      .m_axi_awaddr         ( clk_conv_aw_addr   		),
      .m_axi_awlen          ( clk_conv_aw_len    		),
      .m_axi_awsize         ( clk_conv_aw_size   		),
      .m_axi_awburst        ( clk_conv_aw_burst  		),
      // .m_axi_awlock         (                          	), // not supported in AXI4
      .m_axi_awcache        ( clk_conv_aw_cache  		),
      .m_axi_awprot         ( clk_conv_aw_prot   		),
      .m_axi_awqos          ( clk_conv_aw_qos    		),

      .m_axi_awregion       ( clk_conv_aw_region 		),
      .m_axi_awvalid        ( clk_conv_aw_valid  		),
      .m_axi_wdata          ( clk_conv_w_data    		),
      .m_axi_wstrb          ( clk_conv_w_strb    		),
      .m_axi_wlast          ( clk_conv_w_last    		),
      .m_axi_wvalid         ( clk_conv_w_valid   		),
      .m_axi_bresp          ( clk_conv_b_resp    		),
      .m_axi_bready         ( clk_conv_b_ready   		),
      .m_axi_arid           ( clk_conv_ar_id     		),
      .m_axi_araddr         ( clk_conv_ar_addr   		),
      .m_axi_arlen          ( clk_conv_ar_len    		),
      .m_axi_arsize         ( clk_conv_ar_size   		),
      .m_axi_arburst        ( clk_conv_ar_burst  		),
      // .m_axi_arlock         (                          	), // not supported in AXI4
      .m_axi_arcache        ( clk_conv_ar_cache  		),
      .m_axi_arprot         ( clk_conv_ar_prot   		),
      .m_axi_arqos          ( clk_conv_ar_qos    		),
      // .m_axi_arregion       ( clk_conv_ar_region 		),
      .m_axi_arvalid        ( clk_conv_ar_valid  		),
      .m_axi_rready         ( clk_conv_r_ready   		),
	  
	  
	  
	  //input ports
	  
	  .m_axi_rlast          ( clk_conv_r_last     		),
	  .m_axi_rvalid         ( clk_conv_r_valid    		),
	  .m_axi_rresp          ( clk_conv_r_resp     		),
	  .m_axi_rid            ( clk_conv_r_id       		),
      .m_axi_rdata          ( clk_conv_r_data     		),
	  .m_axi_arready        ( clk_conv_ar_ready   		),
	  .m_axi_bvalid         ( clk_conv_b_valid    		),
	  .m_axi_bid            ( clk_conv_b_id       		),
	  .m_axi_wready         ( clk_conv_w_ready    		),
	  .m_axi_awready        ( clk_conv_aw_ready   		)
      );

`endif




//=====================
// remove_from_here
//=====================



   // // clock generator
   // logic clk_out1, clk_pixel;

   // clk_wiz_0 clk_gen
     // (
 // `ifdef NEXYS4_COMMON
 // `define LOCKED clk_locked_wiz & rst_top
      // .clk_in1       ( clk_p         ), // 100 MHz onboard
      // .resetn        ( rst_top       ),
      // .clk_rmii      ( clk_rmii      ), // 50 MHz RMII
      // .clk_rmii_quad ( clk_rmii_quad ), // 50 MHz RMII quad
      // .clk_io_uart   (               ), // 60 MHz (not used)
 // `else
 // `define LOCKED clk_locked_wiz & !rst_top
 `define LOCKED locked & !rst_top
      // .clk_in1       ( mig_ui_clk    ), // 100 MHz from MIG
      // .reset         ( rst_top       ),
      // .clk_mii       ( clk_mii       ), // 25 MHz MII
      // .clk_mii_quad  ( clk_mii_quad  ), // 25 MHz MII quad
      // .clk_cpu       ( clk           ), // 50 MHz
 // `endif
      // .clk_out1      ( clk_out1   ), // 200 MHz
      // .clk_pixel     ( clk_pixel     ), // 120 MHz
      // .locked        ( clk_locked_wiz )
      // );
   assign clk_locked = `LOCKED;
   // assign sys_rst = ~rstn;
     
	 
	 
	 
	 
	 
   // // DRAM controller
   // mig_7series_0 dram_ctl
     // (
 // `ifdef KC705
      // .sys_clk_p            ( clk_p                  ),
      // .sys_clk_n            ( clk_n                  ),
      // .sys_rst              ( rst_top                ),
      // .ddr3_dq              ( ddr_dq                 ),
      // .ddr3_dqs_n           ( ddr_dqs_n              ),
      // .ddr3_dqs_p           ( ddr_dqs_p              ),
      // .ddr3_addr            ( ddr_addr               ),
      // .ddr3_ba              ( ddr_ba                 ),
      // .ddr3_ras_n           ( ddr_ras_n              ),
      // .ddr3_cas_n           ( ddr_cas_n              ),
      // .ddr3_we_n            ( ddr_we_n               ),
      // .ddr3_reset_n         ( ddr_reset_n            ),
      // .ddr3_ck_p            ( ddr_ck_p               ),
      // .ddr3_ck_n            ( ddr_ck_n               ),
      // .ddr3_cke             ( ddr_cke                ),
      // .ddr3_cs_n            ( ddr_cs_n               ),
      // .ddr3_dm              ( ddr_dm                 ),
      // .ddr3_odt             ( ddr_odt                ),
 // `elsif NEXYS4_VIDEO
      // .sys_clk_i            ( clk_out1            ),
      // .sys_rst              ( clk_locked             ),
      // .ddr3_addr            ( ddr_addr               ),
      // .ddr3_ba              ( ddr_ba                 ),
      // .ddr3_cas_n           ( ddr_cas_n              ),
      // .ddr3_ck_n            ( ddr_ck_n               ),
      // .ddr3_ck_p            ( ddr_ck_p               ),
      // .ddr3_cke             ( ddr_cke                ),
      // .ddr3_ras_n           ( ddr_ras_n              ),
      // .ddr3_reset_n         ( ddr_reset_n            ),
      // .ddr3_we_n            ( ddr_we_n               ),
      // .ddr3_dq              ( ddr_dq                 ),
      // .ddr3_dqs_n           ( ddr_dqs_n              ),
      // .ddr3_dqs_p           ( ddr_dqs_p              ),
      // .ddr3_dm              ( ddr_dm                 ),
      // .ddr3_odt             ( ddr_odt                ),
 // `elsif NEXYS4
      // .sys_clk_i            ( clk_out1            ),
      // .sys_rst              ( clk_locked             ),
      // .device_temp_i        ( 0                      ),
      // .ddr2_dq              ( ddr_dq                 ),
      // .ddr2_dqs_n           ( ddr_dqs_n              ),
      // .ddr2_dqs_p           ( ddr_dqs_p              ),
      // .ddr2_addr            ( ddr_addr               ),
      // .ddr2_ba              ( ddr_ba                 ),
      // .ddr2_ras_n           ( ddr_ras_n              ),
      // .ddr2_cas_n           ( ddr_cas_n              ),
      // .ddr2_we_n            ( ddr_we_n               ),
      // .ddr2_ck_p            ( ddr_ck_p               ),
      // .ddr2_ck_n            ( ddr_ck_n               ),
      // .ddr2_cke             ( ddr_cke                ),
      // .ddr2_cs_n            ( ddr_cs_n               ),
      // .ddr2_dm              ( ddr_dm                 ),
      // .ddr2_odt             ( ddr_odt                ),
 // `endif // !`elsif NEXYS4
      // .ui_clk               ( mig_ui_clk             ),
      // .ui_clk_sync_rst      ( mig_ui_rst             ),
      // .mmcm_locked          ( rstn                   ),
      // .aresetn              ( rstn                   ), // AXI reset
      // .app_sr_req           ( 1'b0                   ),
      // .app_ref_req          ( 1'b0                   ),
      // .app_zq_req           ( 1'b0                   ),
      // .s_axi_awid           ( mem_mig_nasti.aw_id    ),
      // .s_axi_awaddr         ( mem_mig_nasti.aw_addr  ),
      // .s_axi_awlen          ( mem_mig_nasti.aw_len   ),
      // .s_axi_awsize         ( mem_mig_nasti.aw_size  ),
      // .s_axi_awburst        ( mem_mig_nasti.aw_burst ),
      // .s_axi_awlock         ( 1'b0                   ), // not supported in AXI4
      // .s_axi_awcache        ( mem_mig_nasti.aw_cache ),
      // .s_axi_awprot         ( mem_mig_nasti.aw_prot  ),
      // .s_axi_awqos          ( mem_mig_nasti.aw_qos   ),
      // .s_axi_awvalid        ( mem_mig_nasti.aw_valid ),
      // .s_axi_awready        ( mem_mig_nasti.aw_ready ),
      // .s_axi_wdata          ( mem_mig_nasti.w_data   ),
      // .s_axi_wstrb          ( mem_mig_nasti.w_strb   ),
      // .s_axi_wlast          ( mem_mig_nasti.w_last   ),
      // .s_axi_wvalid         ( mem_mig_nasti.w_valid  ),
      // .s_axi_wready         ( mem_mig_nasti.w_ready  ),
      // .s_axi_bid            ( mem_mig_nasti.b_id     ),
      // .s_axi_bresp          ( mem_mig_nasti.b_resp   ),
      // .s_axi_bvalid         ( mem_mig_nasti.b_valid  ),
      // .s_axi_bready         ( mem_mig_nasti.b_ready  ),
      // .s_axi_arid           ( mem_mig_nasti.ar_id    ),
      // .s_axi_araddr         ( mem_mig_nasti.ar_addr  ),
      // .s_axi_arlen          ( mem_mig_nasti.ar_len   ),
      // .s_axi_arsize         ( mem_mig_nasti.ar_size  ),
      // .s_axi_arburst        ( mem_mig_nasti.ar_burst ),
      // .s_axi_arlock         ( 1'b0                   ), // not supported in AXI4
      // .s_axi_arcache        ( mem_mig_nasti.ar_cache ),
      // .s_axi_arprot         ( mem_mig_nasti.ar_prot  ),
      // .s_axi_arqos          ( mem_mig_nasti.ar_qos   ),
      // .s_axi_arvalid        ( mem_mig_nasti.ar_valid ),
      // .s_axi_arready        ( mem_mig_nasti.ar_ready ),
      // .s_axi_rid            ( mem_mig_nasti.r_id     ),
      // .s_axi_rdata          ( mem_mig_nasti.r_data   ),
      // .s_axi_rresp          ( mem_mig_nasti.r_resp   ),
      // .s_axi_rlast          ( mem_mig_nasti.r_last   ),
      // .s_axi_rvalid         ( mem_mig_nasti.r_valid  ),
      // .s_axi_rready         ( mem_mig_nasti.r_ready  )
      // );





//=====================
// remove_till_here
//=====================



  `endif // !`ifdef ZED
`else // !`ifdef ADD_PHY_DDR

`define MEM_NASTI mem_nasti
   
   assign clk = clk_p;
`ifdef KC705   
   always
     begin
        @(posedge clk_p)
          clk_mii = 1'b0;
        @(negedge clk_p)
          clk_mii_quad = 1'b0;
        @(posedge clk_p)
          clk_mii = 1'b1;
        @(negedge clk_p)
          clk_mii_quad = 1'b1;
     end
`else
   assign clk_rmii = clk_p;
   assign clk_rmii_quad = clk_p;
`endif
   assign rstn = !rst_top;
   assign clk_locked = !rst_top;
   assign clk_locked_wiz = !rst_top;
   assign clk_out1 = clk_p;
   assign clk_pixel = clk_p;   
   assign sys_rst = rst_top;
   
   nasti_ram_sim
     #(
       .ID_WIDTH     ( `MEM_ID_WIDTH    ),
       .ADDR_WIDTH   ( `MEM_ADDR_WIDTH  ),
       .DATA_WIDTH   ( `MEM_DATA_WIDTH  ),
       .USER_WIDTH   ( 1                )
       )
   ram_behav
     (
      .clk           ( clk         ),
      .rstn          ( rstn        ),
      .nasti         ( `MEM_NASTI   )
      );
`endif // !`ifdef ADD_PHY_DDR

   /////////////////////////////////////////////////////////////
   // IO space buses

   nasti_channel
     #(
       .ID_WIDTH    ( `MMIO_MASTER_ID_WIDTH   ),
       .ADDR_WIDTH  ( `MMIO_MASTER_ADDR_WIDTH ),
       .DATA_WIDTH  ( `MMIO_MASTER_DATA_WIDTH ))
   mmio_master_nasti();

   nasti_channel
     #(
       .ID_WIDTH    ( `MMIO_SLAVE_ID_WIDTH   ),
       .ADDR_WIDTH  ( `MMIO_SLAVE_ADDR_WIDTH ),
       .DATA_WIDTH  ( `MMIO_SLAVE_DATA_WIDTH ))
   io_slave_nasti();      // IO nasti interface to Rocket

   // currently the slave port is not used
   assign io_slave_nasti.aw_valid = 'b0;
   assign io_slave_nasti.w_valid  = 'b0;
   assign io_slave_nasti.b_ready  = 'b0;
   assign io_slave_nasti.ar_valid = 'b0;
   assign io_slave_nasti.r_ready  = 'b0;

   /////////////////////////////////////////////////////////////
   // On-chip Block RAM

`ifdef ADD_BRAM

   localparam BRAM_SIZE          = 16;        // 2^16 -> 64 KB
   localparam BRAM_WIDTH         = 128;       // always 128-bit wide
   localparam BRAM_LINE          = 2 ** BRAM_SIZE / (BRAM_WIDTH/8);
   localparam BRAM_OFFSET_BITS   = $clog2(`LOWRISC_IO_DAT_WIDTH/8);
   localparam BRAM_ADDR_LSB_BITS = $clog2(BRAM_WIDTH / `LOWRISC_IO_DAT_WIDTH);
   localparam BRAM_ADDR_BLK_BITS = BRAM_SIZE - BRAM_ADDR_LSB_BITS - BRAM_OFFSET_BITS;

   initial assert (BRAM_OFFSET_BITS < 7) else $fatal(1, "Do not support BRAM AXI width > 64-bit!");

   // BRAM controller
   logic ram_clk, ram_rst, ram_en;
   logic [7:0] ram_we;
   logic [15:0] ram_addr;
   logic [63:0]   ram_wrdata, ram_rddata;

   logic [30:0] bram_ar_addr, bram_aw_addr;

   assign bram_ar_addr = mmio_master_nasti.ar_addr ;
   assign bram_aw_addr = mmio_master_nasti.aw_addr ;
   
   reg   [BRAM_WIDTH-1:0]         ram [0 : BRAM_LINE-1];
   logic [BRAM_ADDR_BLK_BITS-1:0] ram_block_addr, ram_block_addr_delay;
   logic [BRAM_ADDR_LSB_BITS-1:0] ram_lsb_addr, ram_lsb_addr_delay;
   logic [BRAM_WIDTH/8-1:0]       ram_we_full;
   logic [BRAM_WIDTH-1:0]         ram_wrdata_full, ram_rddata_full;
   int                            ram_rddata_shift, ram_we_shift;

   assign ram_block_addr = ram_addr >> BRAM_ADDR_LSB_BITS + BRAM_OFFSET_BITS;
   assign ram_lsb_addr = ram_addr >> BRAM_OFFSET_BITS;
   assign ram_we_shift = ram_lsb_addr << BRAM_OFFSET_BITS; // avoid ISim error
   assign ram_we_full = ram_we << ram_we_shift;
   assign ram_wrdata_full = {(BRAM_WIDTH / `LOWRISC_IO_DAT_WIDTH){ram_wrdata}};

   always @(posedge ram_clk)
    begin
     if(ram_en) begin
        ram_block_addr_delay <= ram_block_addr;
        ram_lsb_addr_delay <= ram_lsb_addr;
        foreach (ram_we_full[i])
          if(ram_we_full[i]) ram[ram_block_addr][i*8 +:8] <= ram_wrdata_full[i*8 +: 8];
     end
    end

   assign ram_rddata_full = ram[ram_block_addr_delay];
   assign ram_rddata_shift = ram_lsb_addr_delay << (BRAM_OFFSET_BITS + 3); // avoid ISim error
   assign ram_rddata = ram_rddata_full >> ram_rddata_shift;

   initial $readmemh("boot.mem", ram);

`endif //  `ifdef ADD_BRAM

   /////////////////////////////////////////////////////////////
   // XIP SPI Flash

`ifdef ADD_FLASH

   wire       flash_ss_i,  flash_ss_o,  flash_ss_t;
   wire [3:0] flash_io_i,  flash_io_o,  flash_io_t;

   axi_quad_spi_1 flash_i
     (
      .ext_spi_clk      ( clk                           ),
      .s_axi_aclk       ( clk                           ),
      .s_axi_aresetn    ( rstn                          ),
      .s_axi4_aclk      ( clk                           ),
      .s_axi4_aresetn   ( rstn                          ),
      .s_axi_araddr     ( 7'b0                          ),
      .s_axi_arready    (                               ),
      .s_axi_arvalid    ( 1'b0                          ),
      .s_axi_awaddr     ( 7'b0                          ),
      .s_axi_awready    (                               ),
      .s_axi_awvalid    ( 1'b0                          ),
      .s_axi_bready     ( 1'b0                          ),
      .s_axi_bresp      (                               ),
      .s_axi_bvalid     (                               ),
      .s_axi_rdata      (                               ),
      .s_axi_rready     ( 1'b0                          ),
      .s_axi_rresp      (                               ),
      .s_axi_rvalid     (                               ),
      .s_axi_wdata      ( 0                             ),
      .s_axi_wready     (                               ),
      .s_axi_wstrb      ( 4'b0                          ),
      .s_axi_wvalid     ( 1'b0                          ),
      .s_axi4_awid      ( local_flash_nasti.aw_id       ),
      .s_axi4_awaddr    ( local_flash_nasti.aw_addr     ),
      .s_axi4_awlen     ( local_flash_nasti.aw_len      ),
      .s_axi4_awsize    ( local_flash_nasti.aw_size     ),
      .s_axi4_awburst   ( local_flash_nasti.aw_burst    ),
      .s_axi4_awlock    ( local_flash_nasti.aw_lock     ),
      .s_axi4_awcache   ( local_flash_nasti.aw_cache    ),
      .s_axi4_awprot    ( local_flash_nasti.aw_prot     ),
      .s_axi4_awvalid   ( local_flash_nasti.aw_valid    ),
      .s_axi4_awready   ( local_flash_nasti.aw_ready    ),
      .s_axi4_wdata     ( local_flash_nasti.w_data      ),
      .s_axi4_wstrb     ( local_flash_nasti.w_strb      ),
      .s_axi4_wlast     ( local_flash_nasti.w_last      ),
      .s_axi4_wvalid    ( local_flash_nasti.w_valid     ),
      .s_axi4_wready    ( local_flash_nasti.w_ready     ),
      .s_axi4_bid       ( local_flash_nasti.b_id        ),
      .s_axi4_bresp     ( local_flash_nasti.b_resp      ),
      .s_axi4_bvalid    ( local_flash_nasti.b_valid     ),
      .s_axi4_bready    ( local_flash_nasti.b_ready     ),
      .s_axi4_arid      ( local_flash_nasti.ar_id       ),
      .s_axi4_araddr    ( local_flash_nasti.ar_addr     ),
      .s_axi4_arlen     ( local_flash_nasti.ar_len      ),
      .s_axi4_arsize    ( local_flash_nasti.ar_size     ),
      .s_axi4_arburst   ( local_flash_nasti.ar_burst    ),
      .s_axi4_arlock    ( local_flash_nasti.ar_lock     ),
      .s_axi4_arcache   ( local_flash_nasti.ar_cache    ),
      .s_axi4_arprot    ( local_flash_nasti.ar_prot     ),
      .s_axi4_arvalid   ( local_flash_nasti.ar_valid    ),
      .s_axi4_arready   ( local_flash_nasti.ar_ready    ),
      .s_axi4_rid       ( local_flash_nasti.r_id        ),
      .s_axi4_rdata     ( local_flash_nasti.r_data      ),
      .s_axi4_rresp     ( local_flash_nasti.r_resp      ),
      .s_axi4_rlast     ( local_flash_nasti.r_last      ),
      .s_axi4_rvalid    ( local_flash_nasti.r_valid     ),
      .s_axi4_rready    ( local_flash_nasti.r_ready     ),
      .io0_i            ( flash_io_i[0]                 ),
      .io0_o            ( flash_io_o[0]                 ),
      .io0_t            ( flash_io_t[0]                 ),
      .io1_i            ( flash_io_i[1]                 ),
      .io1_o            ( flash_io_o[1]                 ),
      .io1_t            ( flash_io_t[1]                 ),
      .io2_i            ( flash_io_i[2]                 ),
      .io2_o            ( flash_io_o[2]                 ),
      .io2_t            ( flash_io_t[2]                 ),
      .io3_i            ( flash_io_i[3]                 ),
      .io3_o            ( flash_io_o[3]                 ),
      .io3_t            ( flash_io_t[3]                 ),
      .ss_i             ( flash_ss_i                    ),
      .ss_o             ( flash_ss_o                    ),
      .ss_t             ( flash_ss_t                    )
      );

   // tri-state gates
   generate for(i=0; i<4; i++) begin
      assign flash_io[i] = !flash_io_t[i] ? flash_io_o[i] : 1'bz;
      assign flash_io_i[i] = flash_io[i];
   end
   endgenerate

   assign flash_ss = !flash_ss_t ? flash_ss_o : 1'bz;
   assign flash_ss_i = flash_ss;

`endif //  `ifdef ADD_FLASH

   assign spi_irq = 1'b0;

   /////////////////////////////////////////////////////////////
   // Human interface and miscellaneous devices

`ifdef ADD_HID
   
   wire                        hid_rst, hid_clk, hid_en;
   wire [7:0]                  hid_we;
   wire [17:0]                 hid_addr;
   wire [63:0]                 hid_wrdata,  hid_rddata;
   logic [30:0]                hid_ar_addr, hid_aw_addr;
   logic eth_rstn, eth_refclk, eth_txen, eth_txer, eth_rxerr;
   assign o_erstn = eth_rstn & clk_locked_wiz;

   axi_bram_ctrl_dummy BramCtl
     (
      .s_axi_aclk      ( clk_cpu	            ),
      .s_axi_aresetn   ( rstn                       ),
      .s_axi_arid      ( mmio_master_nasti.ar_id    ),
      .s_axi_araddr    ( bram_ar_addr[17:0]         ),
      .s_axi_arlen     ( mmio_master_nasti.ar_len   ),
      .s_axi_arsize    ( mmio_master_nasti.ar_size  ),
      .s_axi_arburst   ( mmio_master_nasti.ar_burst ),
      .s_axi_arlock    ( mmio_master_nasti.ar_lock  ),
      .s_axi_arcache   ( mmio_master_nasti.ar_cache ),
      .s_axi_arprot    ( mmio_master_nasti.ar_prot  ),
      .s_axi_arready   ( mmio_master_nasti.ar_ready ),
      .s_axi_arvalid   ( mmio_master_nasti.ar_valid ),
      .s_axi_rid       ( mmio_master_nasti.r_id     ),
      .s_axi_rdata     ( mmio_master_nasti.r_data   ),
      .s_axi_rresp     ( mmio_master_nasti.r_resp   ),
      .s_axi_rlast     ( mmio_master_nasti.r_last   ),
      .s_axi_rready    ( mmio_master_nasti.r_ready  ),
      .s_axi_rvalid    ( mmio_master_nasti.r_valid  ),
      .s_axi_awid      ( mmio_master_nasti.aw_id    ),
      .s_axi_awaddr    ( bram_aw_addr[17:0]         ),
      .s_axi_awlen     ( mmio_master_nasti.aw_len   ),
      .s_axi_awsize    ( mmio_master_nasti.aw_size  ),
      .s_axi_awburst   ( mmio_master_nasti.aw_burst ),
      .s_axi_awlock    ( mmio_master_nasti.aw_lock  ),
      .s_axi_awcache   ( mmio_master_nasti.aw_cache ),
      .s_axi_awprot    ( mmio_master_nasti.aw_prot  ),
      .s_axi_awready   ( mmio_master_nasti.aw_ready ),
      .s_axi_awvalid   ( mmio_master_nasti.aw_valid ),
      .s_axi_wdata     ( mmio_master_nasti.w_data   ),
      .s_axi_wstrb     ( mmio_master_nasti.w_strb   ),
      .s_axi_wlast     ( mmio_master_nasti.w_last   ),
      .s_axi_wready    ( mmio_master_nasti.w_ready  ),
      .s_axi_wvalid    ( mmio_master_nasti.w_valid  ),
      .s_axi_bid       ( mmio_master_nasti.b_id     ),
      .s_axi_bresp     ( mmio_master_nasti.b_resp   ),
      .s_axi_bready    ( mmio_master_nasti.b_ready  ),
      .s_axi_bvalid    ( mmio_master_nasti.b_valid  ),
      .bram_rst_a      ( hid_rst                   ),
      .bram_clk_a      ( hid_clk                   ),
      .bram_en_a       ( hid_en                    ),
      .bram_we_a       ( hid_we                    ),
      .bram_addr_a     ( hid_addr                  ),
      .bram_wrdata_a   ( hid_wrdata                ),
      .bram_rddata_a   ( hid_rddata                )
      );
  
`ifdef KC705    
   always @(posedge i_etx_clk)
`else      
   always @(posedge clk_rmii)
`endif      
     begin
        phy_emdio_i <= io_emdio_i;
        io_emdio_o <= phy_emdio_o;
        io_emdio_t <= phy_emdio_t;
     end

   IOBUF #(
      .DRIVE(12), // Specify the output drive strength
      .IBUF_LOW_PWR("TRUE"),  // Low Power - "TRUE", High Performance = "FALSE" 
      .IOSTANDARD("DEFAULT"), // Specify the I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) IOBUF_inst (
      .O(io_emdio_i),     // Buffer output
      .IO(io_emdio),   // Buffer inout port (connect directly to top-level port)
      .I(io_emdio_o),     // Buffer input
      .T(io_emdio_t)      // 3-state enable input, high=input, low=output
   );

  ODDR #(
    .DDR_CLK_EDGE("OPPOSITE_EDGE"),
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    refclk_inst
       (.C(eth_refclk),
        .CE(1'b1),
        .D1(1'b1),
        .D2(1'b0),
        .Q(o_erefclk),
        .R(1'b0),
        .S( ));
		
		
		
   // assign clk = clk_p;

`ifdef KC705    
    always @(posedge i_erx_clk)
`else      
    always @(posedge clk_rmii_quad)
`endif      
      begin
        eth_rxd = i_erxd;
        eth_rxerr = i_erx_er;         
      end
   
`ifdef KC705    
   logic [3:0] eth_txd;
    always @(posedge i_etx_clk)
`else      
   logic [1:0] eth_txd;
    always @(posedge clk_rmii_quad)
`endif      
      begin
        o_etxd = eth_txd;
        o_etx_en = eth_txen;
        o_etx_er = eth_txer;
        end

   // periph_soc_wrapper #(.UBAUD_DEFAULT(108)) psoc
   periph_soc_wrapper psoc
     (
      .msoc_clk   ( clk_cpu			),
      .sd_sclk    ( sd_sclk         ),
      .sd_detect  ( sd_detect       ),
      .sd_dat     ( sd_dat          ),
      .sd_cmd     ( sd_cmd          ),
      .sd_irq     ( sd_irq          ),
`ifdef KC705
      .from_dip   ( {12'b0,i_dip}    ),
      .to_led     ( {unused_led,o_led} ),
`else
      .from_dip   ( i_dip           ),
      .to_led     ( o_led           ),
`endif
      .rstn       ( clk_locked      ),
      .clk_200MHz ( clk_out1     	),
      .pxl_clk    ( clk_pixel       ),
      .uart_rx    ( rxd             ),
      .uart_tx    ( txd             ),
`ifdef KC705   
      .i_erx_clk  ( i_erx_clk       ),
      .i_etx_clk  ( i_etx_clk       ),
      .clk_mii    ( clk_mii         ), // 25 MHz MII
`else
      .clk_rmii   ( clk_rmii        ),
`endif
      .locked     ( clk_locked      ),
    // SMSC ethernet PHY connections
      .eth_rstn   ( eth_rstn        ),
      .eth_crsdv  ( i_erx_dv        ),
      .eth_refclk ( eth_refclk      ),
      .eth_txd    ( eth_txd         ),
      .eth_txen   ( eth_txen        ),
      .eth_txer   ( eth_txer        ),
      .eth_rxd    ( eth_rxd         ),
      .eth_rxerr  ( eth_rxerr       ),
      .eth_mdc    ( o_emdc          ),
      .phy_mdio_i ( phy_emdio_i     ),
      .phy_mdio_o ( phy_emdio_o     ),
      .phy_mdio_t ( phy_emdio_t     ),
      .eth_irq    ( eth_irq         ),
	 
	 
	// Clock in ports
    // .clk_in1		(	clk_in1			),      // input clk_in1
    // Clock out ports	
    .clk_sdclk		(	clk_sdclk		),     // output clk_sdclk
    // Dynamic reconfiguration ports	
    .daddr			(	daddr			), // input [6:0] daddr
	// .dclk			(	dclk			), // input dclk
	.den			(	den				), // input den
	.din			(	din				), // input [15:0] din
	.dout			(	dout			), // output [15:0] dout
	.drdy			(	drdy			), // output drdy
	.dwe			(	dwe				), // input dwe
      // Status and control signals
    // .reset			(	~(sd_clk_rst&rstn)	), // input reset
    .reset			(	reset	), // input reset
    .sd_clk_locked	(	sd_clk_locked			),
 
	
    // // Clock in ports
    // .msoc_clk		(	clk_in1			),      // input clk_in1
    // // Clock out ports	
    // .sd_clk_o		(	clk_sdclk		),     // output clk_sdclk
    // // Dynamic reconfiguration ports	
    // .sd_clk_daddr	(	daddr			), // input [6:0] daddr
	// .sd_clk_dclk	(	dclk			), // input dclk
	// .sd_clk_den		(	den				), // input den
	// .sd_clk_din		(	din				), // input [15:0] din
	// .sd_clk_dout	(	dout			), // output [15:0] dout
	// .sd_clk_drdy	(	drdy			), // output drdy
	// .sd_clk_dwe		(	dwe				), // input dwe
      // // Status and control signals
      // .reset		(	reset	), // input reset
    // .sd_clk_locked	(	locked			),
	 
	  
      .*
      );

   assign rts = cts;
   
`else // !`ifdef ADD_HID

   assign hid_irq = 1'b0;
   assign sd_irq = 1'b0;
   assign eth_irq = 1'b0;

`endif // !`ifdef ADD_HID

   /////////////////////////////////////////////////////////////
   // Host for ISA regression

   nasti_channel
     #(
       .ADDR_WIDTH  ( `MMIO_MASTER_ADDR_WIDTH   ),
       .DATA_WIDTH  ( `LOWRISC_IO_DAT_WIDTH     ))
   io_host_lite();

`ifdef ADD_HOST
   host_behav host
     (
      .clk          ( clk          ),
      .rstn         ( rstn         ),
      .nasti        ( io_host_lite )
      );
`endif
`define MEM_NASTI mem_nasti
   /////////////////////////////////////////////////////////////
   // the Rocket chip

   wire CAPTURE, DRCK, RESET, RUNTEST, SEL, SHIFT, TCK, TDI, TMS, UPDATE, TDO, TCK_unbuf;

   /* This block is just used to feed the JTAG clock into the parts of Rocket that need it */
      
   BSCANE2 #(
      .JTAG_CHAIN(2)  // Value for USER command.
   )
   BSCANE2_inst1 (
      .CAPTURE(CAPTURE), // 1-bit output: CAPTURE output from TAP controller.
      .DRCK(DRCK),       // 1-bit output: Gated TCK output. When SEL is asserted, DRCK toggles when CAPTURE or
                         // SHIFT are asserted.

      .RESET(RESET),     // 1-bit output: Reset output for TAP controller.
      .RUNTEST(RUNTEST), // 1-bit output: Output asserted when TAP controller is in Run Test/Idle state.
      .SEL(SEL),         // 1-bit output: USER instruction active output.
      .SHIFT(SHIFT),     // 1-bit output: SHIFT output from TAP controller.
      .TCK(TCK_unbuf),   // 1-bit output: Test Clock output. Fabric connection to TAP Clock pin.
      .TDI(TDI),         // 1-bit output: Test Data Input (TDI) output from TAP controller.
      .TMS(TMS),         // 1-bit output: Test Mode Select output. Fabric connection to TAP.
      .UPDATE(UPDATE),   // 1-bit output: UPDATE output from TAP controller
      .TDO(TDO)          // 1-bit input: Test Data Output (TDO) input for USER function.
   );

   // BUFH: HROW Clock Buffer for a Single Clocking Region
   //       Artix-7
   // Xilinx HDL Language Template, version 2016.1

   BUFH BUFH_inst (
      .O(TCK), // 1-bit output: Clock output
      .I(TCK_unbuf)  // 1-bit input: Clock input
   );
  
  /* DMI interface tie-off */
  wire  ExampleRocketSystem_debug_ndreset;
  wire  ExampleRocketSystem_debug_dmactive;
  reg [31:0] io_reset_vector;

   always @*
     begin
        casez (i_dip[1:0])
          2'b?0: io_reset_vector = 32'h40000000;
          2'b01: io_reset_vector = 32'h80000000;
          2'b11: io_reset_vector = 32'h80200000;
        endcase // casez ()
     end
   
   ExampleRocketSystem Rocket
     (
      .debug_systemjtag_jtag_TCK(TCK),
      .debug_systemjtag_jtag_TMS(TMS),
      .debug_systemjtag_jtag_TDI(TDI),
      .debug_systemjtag_jtag_TDO_data(TDO),
      .debug_systemjtag_jtag_TDO_driven(TDO_driven),
      .debug_systemjtag_reset(RESET),
      .debug_systemjtag_mfr_id(11'h5AA),
      .debug_ndreset(ExampleRocketSystem_debug_ndreset),
      .debug_dmactive(ExampleRocketSystem_debug_dmactive),
      .mem_axi4_0_aw_valid                ( `MEM_NASTI.aw_valid                     ),
      .mem_axi4_0_aw_ready                ( `MEM_NASTI.aw_ready                     ),
      .mem_axi4_0_aw_bits_id              ( `MEM_NASTI.aw_id                        ),
      .mem_axi4_0_aw_bits_addr            ( `MEM_NASTI.aw_addr                      ),
      .mem_axi4_0_aw_bits_len             ( `MEM_NASTI.aw_len                       ),
      .mem_axi4_0_aw_bits_size            ( `MEM_NASTI.aw_size                      ),
      .mem_axi4_0_aw_bits_burst           ( `MEM_NASTI.aw_burst                     ),
      .mem_axi4_0_aw_bits_lock            ( `MEM_NASTI.aw_lock                      ),
      .mem_axi4_0_aw_bits_cache           ( `MEM_NASTI.aw_cache                     ),
      .mem_axi4_0_aw_bits_prot            ( `MEM_NASTI.aw_prot                      ),
      .mem_axi4_0_aw_bits_qos             ( `MEM_NASTI.aw_qos                       ),
      .mem_axi4_0_w_valid                 ( `MEM_NASTI.w_valid                      ),
      .mem_axi4_0_w_ready                 ( `MEM_NASTI.w_ready                      ),
      .mem_axi4_0_w_bits_data             ( `MEM_NASTI.w_data                       ),
      .mem_axi4_0_w_bits_strb             ( `MEM_NASTI.w_strb                       ),
      .mem_axi4_0_w_bits_last             ( `MEM_NASTI.w_last                       ),
      .mem_axi4_0_b_valid                 ( `MEM_NASTI.b_valid                      ),
      .mem_axi4_0_b_ready                 ( `MEM_NASTI.b_ready                      ),
      .mem_axi4_0_b_bits_id               ( `MEM_NASTI.b_id                         ),
      .mem_axi4_0_b_bits_resp             ( `MEM_NASTI.b_resp                       ),
      .mem_axi4_0_ar_valid                ( `MEM_NASTI.ar_valid                     ),
      .mem_axi4_0_ar_ready                ( `MEM_NASTI.ar_ready                     ),
      .mem_axi4_0_ar_bits_id              ( `MEM_NASTI.ar_id                        ),
      .mem_axi4_0_ar_bits_addr            ( `MEM_NASTI.ar_addr                      ),
      .mem_axi4_0_ar_bits_len             ( `MEM_NASTI.ar_len                       ),
      .mem_axi4_0_ar_bits_size            ( `MEM_NASTI.ar_size                      ),
      .mem_axi4_0_ar_bits_burst           ( `MEM_NASTI.ar_burst                     ),
      .mem_axi4_0_ar_bits_lock            ( `MEM_NASTI.ar_lock                      ),
      .mem_axi4_0_ar_bits_cache           ( `MEM_NASTI.ar_cache                     ),
      .mem_axi4_0_ar_bits_prot            ( `MEM_NASTI.ar_prot                      ),
      .mem_axi4_0_ar_bits_qos             ( `MEM_NASTI.ar_qos                       ),
      .mem_axi4_0_r_valid                 ( `MEM_NASTI.r_valid                      ),
      .mem_axi4_0_r_ready                 ( `MEM_NASTI.r_ready                      ),
      .mem_axi4_0_r_bits_id               ( `MEM_NASTI.r_id                         ),
      .mem_axi4_0_r_bits_data             ( `MEM_NASTI.r_data                       ),
      .mem_axi4_0_r_bits_resp             ( `MEM_NASTI.r_resp                       ),
      .mem_axi4_0_r_bits_last             ( `MEM_NASTI.r_last                       ),
`ifdef MEM_USER_WIDTH
      .mem_axi4_0_aw_bits_user            ( `MEM_NASTI.aw_user                      ),
      .mem_axi4_0_w_bits_user             ( `MEM_NASTI.w_user                       ),
      .mem_axi4_0_b_bits_user             ( `MEM_NASTI.b_user                       ),
      .mem_axi4_0_ar_bits_user            ( `MEM_NASTI.ar_user                      ),
      .mem_axi4_0_r_bits_user             ( `MEM_NASTI.r_user                       ),
`endif
      .mmio_axi4_0_aw_valid        ( mmio_master_nasti.aw_valid               ),
      .mmio_axi4_0_aw_ready        ( mmio_master_nasti.aw_ready               ),
      .mmio_axi4_0_aw_bits_id      ( mmio_master_nasti.aw_id                  ),
      .mmio_axi4_0_aw_bits_addr    ( mmio_master_nasti.aw_addr                ),
      .mmio_axi4_0_aw_bits_len     ( mmio_master_nasti.aw_len                 ),
      .mmio_axi4_0_aw_bits_size    ( mmio_master_nasti.aw_size                ),
      .mmio_axi4_0_aw_bits_burst   ( mmio_master_nasti.aw_burst               ),
      .mmio_axi4_0_aw_bits_lock    ( mmio_master_nasti.aw_lock                ),
      .mmio_axi4_0_aw_bits_cache   ( mmio_master_nasti.aw_cache               ),
      .mmio_axi4_0_aw_bits_prot    ( mmio_master_nasti.aw_prot                ),
      .mmio_axi4_0_aw_bits_qos     ( mmio_master_nasti.aw_qos                 ),
      .mmio_axi4_0_w_valid         ( mmio_master_nasti.w_valid                ),
      .mmio_axi4_0_w_ready         ( mmio_master_nasti.w_ready                ),
      .mmio_axi4_0_w_bits_data     ( mmio_master_nasti.w_data                 ),
      .mmio_axi4_0_w_bits_strb     ( mmio_master_nasti.w_strb                 ),
      .mmio_axi4_0_w_bits_last     ( mmio_master_nasti.w_last                 ),
      .mmio_axi4_0_b_valid         ( mmio_master_nasti.b_valid                ),
      .mmio_axi4_0_b_ready         ( mmio_master_nasti.b_ready                ),
      .mmio_axi4_0_b_bits_id       ( mmio_master_nasti.b_id                   ),
      .mmio_axi4_0_b_bits_resp     ( mmio_master_nasti.b_resp                 ),
      .mmio_axi4_0_ar_valid        ( mmio_master_nasti.ar_valid               ),
      .mmio_axi4_0_ar_ready        ( mmio_master_nasti.ar_ready               ),
      .mmio_axi4_0_ar_bits_id      ( mmio_master_nasti.ar_id                  ),
      .mmio_axi4_0_ar_bits_addr    ( mmio_master_nasti.ar_addr                ),
      .mmio_axi4_0_ar_bits_len     ( mmio_master_nasti.ar_len                 ),
      .mmio_axi4_0_ar_bits_size    ( mmio_master_nasti.ar_size                ),
      .mmio_axi4_0_ar_bits_burst   ( mmio_master_nasti.ar_burst               ),
      .mmio_axi4_0_ar_bits_lock    ( mmio_master_nasti.ar_lock                ),
      .mmio_axi4_0_ar_bits_cache   ( mmio_master_nasti.ar_cache               ),
      .mmio_axi4_0_ar_bits_prot    ( mmio_master_nasti.ar_prot                ),
      .mmio_axi4_0_ar_bits_qos     ( mmio_master_nasti.ar_qos                 ),
      .mmio_axi4_0_r_valid         ( mmio_master_nasti.r_valid                ),
      .mmio_axi4_0_r_ready         ( mmio_master_nasti.r_ready                ),
      .mmio_axi4_0_r_bits_id       ( mmio_master_nasti.r_id                   ),
      .mmio_axi4_0_r_bits_data     ( mmio_master_nasti.r_data                 ),
      .mmio_axi4_0_r_bits_resp     ( mmio_master_nasti.r_resp                 ),
      .mmio_axi4_0_r_bits_last     ( mmio_master_nasti.r_last                 ),
`ifdef MMIO_MASTER_USER_WIDTH
      .mmio_axi4_0_aw_bits_user    ( mmio_master_nasti.aw_user                ),
      .mmio_axi4_0_w_bits_user     ( mmio_master_nasti.w_user                 ),
      .mmio_axi4_0_b_bits_user     ( mmio_master_nasti.b_user                 ),
      .mmio_axi4_0_ar_bits_user    ( mmio_master_nasti.ar_user                ),
      .mmio_axi4_0_r_bits_user     ( mmio_master_nasti.r_user                 ),
`endif
      .l2_frontend_bus_axi4_0_aw_valid         ( io_slave_nasti.aw_valid                ),
      .l2_frontend_bus_axi4_0_aw_ready         ( io_slave_nasti.aw_ready                ),
      .l2_frontend_bus_axi4_0_aw_bits_id       ( io_slave_nasti.aw_id                   ),
      .l2_frontend_bus_axi4_0_aw_bits_addr     ( io_slave_nasti.aw_addr                 ),
      .l2_frontend_bus_axi4_0_aw_bits_len      ( io_slave_nasti.aw_len                  ),
      .l2_frontend_bus_axi4_0_aw_bits_size     ( io_slave_nasti.aw_size                 ),
      .l2_frontend_bus_axi4_0_aw_bits_burst    ( io_slave_nasti.aw_burst                ),
      .l2_frontend_bus_axi4_0_aw_bits_lock     ( io_slave_nasti.aw_lock                 ),
      .l2_frontend_bus_axi4_0_aw_bits_cache    ( io_slave_nasti.aw_cache                ),
      .l2_frontend_bus_axi4_0_aw_bits_prot     ( io_slave_nasti.aw_prot                 ),
      .l2_frontend_bus_axi4_0_aw_bits_qos      ( io_slave_nasti.aw_qos                  ),
      .l2_frontend_bus_axi4_0_w_valid          ( io_slave_nasti.w_valid                 ),
      .l2_frontend_bus_axi4_0_w_ready          ( io_slave_nasti.w_ready                 ),
      .l2_frontend_bus_axi4_0_w_bits_data      ( io_slave_nasti.w_data                  ),
      .l2_frontend_bus_axi4_0_w_bits_strb      ( io_slave_nasti.w_strb                  ),
      .l2_frontend_bus_axi4_0_w_bits_last      ( io_slave_nasti.w_last                  ),
      .l2_frontend_bus_axi4_0_b_valid          ( io_slave_nasti.b_valid                 ),
      .l2_frontend_bus_axi4_0_b_ready          ( io_slave_nasti.b_ready                 ),
      .l2_frontend_bus_axi4_0_b_bits_id        ( io_slave_nasti.b_id                    ),
      .l2_frontend_bus_axi4_0_b_bits_resp      ( io_slave_nasti.b_resp                  ),
      .l2_frontend_bus_axi4_0_ar_valid         ( io_slave_nasti.ar_valid                ),
      .l2_frontend_bus_axi4_0_ar_ready         ( io_slave_nasti.ar_ready                ),
      .l2_frontend_bus_axi4_0_ar_bits_id       ( io_slave_nasti.ar_id                   ),
      .l2_frontend_bus_axi4_0_ar_bits_addr     ( io_slave_nasti.ar_addr                 ),
      .l2_frontend_bus_axi4_0_ar_bits_len      ( io_slave_nasti.ar_len                  ),
      .l2_frontend_bus_axi4_0_ar_bits_size     ( io_slave_nasti.ar_size                 ),
      .l2_frontend_bus_axi4_0_ar_bits_burst    ( io_slave_nasti.ar_burst                ),
      .l2_frontend_bus_axi4_0_ar_bits_lock     ( io_slave_nasti.ar_lock                 ),
      .l2_frontend_bus_axi4_0_ar_bits_cache    ( io_slave_nasti.ar_cache                ),
      .l2_frontend_bus_axi4_0_ar_bits_prot     ( io_slave_nasti.ar_prot                 ),
      .l2_frontend_bus_axi4_0_ar_bits_qos      ( io_slave_nasti.ar_qos                  ),
      .l2_frontend_bus_axi4_0_r_valid          ( io_slave_nasti.r_valid                 ),
      .l2_frontend_bus_axi4_0_r_ready          ( io_slave_nasti.r_ready                 ),
      .l2_frontend_bus_axi4_0_r_bits_id        ( io_slave_nasti.r_id                    ),
      .l2_frontend_bus_axi4_0_r_bits_data      ( io_slave_nasti.r_data                  ),
      .l2_frontend_bus_axi4_0_r_bits_resp      ( io_slave_nasti.r_resp                  ),
      .l2_frontend_bus_axi4_0_r_bits_last      ( io_slave_nasti.r_last                  ),
`ifdef MMIO_SLAVE_USER_WIDTH
      .l2_frontend_bus_axi4_0_aw_bits_user     ( io_salve_nasti.aw_user                 ),
      .l2_frontend_bus_axi4_0_w_bits_user      ( io_salve_nasti.w_user                  ),
      .l2_frontend_bus_axi4_0_b_bits_user      ( io_salve_nasti.b_user                  ),
      .l2_frontend_bus_axi4_0_ar_bits_user     ( io_salve_nasti.ar_user                 ),
      .l2_frontend_bus_axi4_0_r_bits_user      ( io_salve_nasti.r_user                  ),
`endif
      .interrupts                    ( {sd_irq, eth_irq, spi_irq, uart_irq} ),
      .io_reset_vector               ( io_reset_vector                      ),
      .clock                         ( clk_cpu                       ),
      .reset                         ( sys_rst                              )
      );
   
endmodule // chip_top
