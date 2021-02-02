//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
//Date        : Fri May 15 22:21:44 2020
//Host        : Panther running 64-bit Ubuntu 16.04.6 LTS
//Command     : generate_target chip_top_wrapper.bd
//Design      : chip_top_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module chip_top_wrapper
   (
  
// define input/output
   
// `ifdef ADD_PHY_DDR
// `ifdef KC705
   // // DDR3 RAM
   // inout wire [63:0]  ddr_dq		,
   // inout wire [7:0]   ddr_dqs_n     ,
   // inout wire [7:0]   ddr_dqs_p     ,
   // output wire [13:0] ddr_addr      ,
   // output wire [2:0]  ddr_ba        ,
   // output wire        ddr_ras_n     ,
   // output wire        ddr_cas_n     ,
   // output wire        ddr_we_n      ,
   // output wire        ddr_reset_n   ,
   // output wire        ddr_ck_n      ,
   // output wire        ddr_ck_p      ,
   // output wire        ddr_cke       ,
   // output wire        ddr_cs_n      ,
   // output wire [7:0]  ddr_dm        ,
   // output wire        ddr_odt		,
   
   
	// // DDR3 RAM
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

	//==================================
	// clock input from clock generator
	//==================================

	// input wire			clk_RocketCore,	//use same port for other connected ports as well
	// input wire			clk_mii,
	// input wire			mig_sys_clk,
	// input wire			clk_pixel,
	// input wire			clk_locked_wiz,

   
   	// //==================================
	// // clock input from clock generator
	// //==================================
	
	// input wire			clk_RocketCore,	//use same port for other connected ports as well
	// input wire			clk_mii,
	// input wire			mig_sys_clk,
	// input wire			clk_pixel,
	// input wire			clk_locked_wiz,

	//=============================
	// for clock converter
	// interface betwenn clock converter & mig_7
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
    // output wire 		clk_conv_ar_region 	, 
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
	input wire 			clk_out1		,	// 200 MHz
	input wire 			clk_pixel     	,	// 120 MHz
	input wire			locked			,


	// output wire 		clk_in1	    	, 	// 100 MHz from MIG
	// output wire 		reset 	       	,
	
	
//====================
//  in case clk_wiz_1 should be removed
//====================

	// Clock in ports
	// output wire 			clk_in1				,   // input clk_in1
	// Clock out ports	
	input wire 			clk_sdclk		,   // output clk_sdclk
	// Dynamic reconfiguration ports	
	output wire 		daddr			, 	// input [6:0] daddr
	// output wire 		dclk			,	// input dclk
	output wire 		den				,	// input den
	output wire 		din				, 	// input [15:0] din
	input  wire 			dout			, 	// output [15:0] dout
	input  wire 			drdy			, 	// output drdy
	output wire 		dwe				, 	// input dwe
	// Status and control signals	
	output wire 		reset			,	//(~(sd_clk_rst&rstn))		, 	// input reset
	input wire 			sd_clk_locked	,
	
	
	

// `endif
// `endif //  `ifdef ADD_DDR_IO

`ifdef ADD_FLASH
	inout wire         flash_ss		,
	inout wire [3:0]   flash_io		,
`endif

`ifdef ADD_SPI
	inout wire         spi_cs		,
	inout wire         spi_sclk		,
	inout wire         spi_mosi		,
	inout wire         spi_miso		,
	output wire        sd_reset		,
`endif                              
									
// `ifdef ADD_HID                      
	// Simple UART interface        
	input 	wire         rxd			,
	output 	wire        txd			,
	output 	wire        rts			,
	input 	wire         cts			,
									
	// 4-bit full SD interface      
	inout 	wire         sd_sclk      ,
	input 	wire         sd_detect    ,
	inout 	wire [3:0]   sd_dat       ,
	inout 	wire         sd_cmd       ,
	output 	wire        sd_reset		,

	// // LED and DIP switch
// `ifdef NEXYS4_COMMON
	// output wire [15:0] o_led		,
	// input wire  [15:0] i_dip		,
	// // display
	// output wire        VGA_HS_O     ,
	// output wire        VGA_VS_O     ,
	// output wire [3:0]  VGA_RED_O    ,
	// output wire [3:0]  VGA_BLUE_O   ,
	// output wire [3:0]  VGA_GREEN_O	,
// `else                               
   output 	wire [7:0]  o_led			,
   input 	wire  [3:0]  i_dip			,
// `endif
	// push button array
	input 	wire         GPIO_SW_C	,	
	input 	wire         GPIO_SW_W	,	
	input 	wire         GPIO_SW_E	,	
	input 	wire         GPIO_SW_N	,	
	input 	wire         GPIO_SW_S	,	
	//keyboard
	inout 	wire         PS2_CLK		,
	inout 	wire         PS2_DATA		,

	//! Ethernet MAC PHY interface signals
	input 	wire         i_erx_dv		, // PHY data valid
	input 	wire         i_erx_er		, // PHY coding error
	input 	wire         i_emdint		, // PHY interrupt in active low
	output 	wire         o_erefclk	, // RMII clock out
	output 	wire         o_etx_en		, // RMII transmit enable
// // `ifdef KC705                        
	input 	wire [3:0]   i_erxd		, // RMII receive data
	output 	wire [7:0]   o_etxd		, // RMII transmit data
	output 	wire         o_etx_er		, // RMII transmit enable
	input 	wire         i_gmiiclk_p	,
	input 	wire         i_gmiiclk_n	,
	input 	wire         i_erx_clk	,
	input 	wire         i_etx_clk	,
// // `else                               
	// input wire [1:0]   i_erxd		, // RMII receive data
	// output reg [1:0]   o_etxd		, // RMII transmit data
// // `endif                              
	output 	wire        o_emdc 		, // MDIO clock
	inout 	wire         io_emdio 	, // MDIO inout
	output 	wire        o_erstn 		, // PHY reset active low
// `endif                              
	// clock and reset              
	// input wire         clk_p		,
	// input wire         clk_n		,
	input 	wire         rst_top      
);



chip_top_modified U0_CHIP_TOP
  (
// `ifdef ADD_PHY_DDR
 // `ifdef KC705
	
 
 
 	//=============================
	// interface between clock converter & mig_7
	//=============================
	
	.clk_conv_aw_id     	(	clk_conv_aw_id     		), 
    .clk_conv_aw_addr   	(	clk_conv_aw_addr   		), 
    .clk_conv_aw_len    	(	clk_conv_aw_len    		), 
    .clk_conv_aw_size   	(	clk_conv_aw_size   		), 
    .clk_conv_aw_burst  	(	clk_conv_aw_burst  		), 
    .clk_conv_aw_cache  	(	clk_conv_aw_cache  		), 
    .clk_conv_aw_prot   	(	clk_conv_aw_prot   		), 
    .clk_conv_aw_qos    	(	clk_conv_aw_qos    		), 
    .clk_conv_aw_region 	(	clk_conv_aw_region 		), 
    .clk_conv_aw_valid  	(	clk_conv_aw_valid  		), 
    .clk_conv_w_data    	(	clk_conv_w_data    		), 
    .clk_conv_w_strb    	(	clk_conv_w_strb    		), 
    .clk_conv_w_last    	(	clk_conv_w_last    		), 
    .clk_conv_w_valid   	(	clk_conv_w_valid   		), 
    .clk_conv_b_ready   	(	clk_conv_b_ready   		), 
    .clk_conv_ar_id     	(	clk_conv_ar_id     		), 
    .clk_conv_ar_addr   	(	clk_conv_ar_addr   		),
    .clk_conv_ar_len    	(	clk_conv_ar_len    		), 
    .clk_conv_ar_size   	(	clk_conv_ar_size   		), 
    .clk_conv_ar_burst  	(	clk_conv_ar_burst  		), 
    .clk_conv_ar_cache  	(	clk_conv_ar_cache  		), 
    .clk_conv_ar_prot   	(	clk_conv_ar_prot   		), 
    .clk_conv_ar_qos    	(	clk_conv_ar_qos    		), 
    // .clk_conv_ar_region 	(	clk_conv_ar_region 		), 
    .clk_conv_ar_valid  	(	clk_conv_ar_valid  		), 
    .clk_conv_r_ready   	(	clk_conv_r_ready   		), 
						
	.clk_conv_b_resp    	(	clk_conv_b_resp    		),
    .clk_conv_r_last        (   clk_conv_r_last     	),
    .clk_conv_r_valid       (   clk_conv_r_valid    	),
    .clk_conv_r_resp        (   clk_conv_r_resp     	),
    .clk_conv_r_id          (   clk_conv_r_id       	),
    .clk_conv_r_data        (   clk_conv_r_data     	),
    .clk_conv_ar_ready      (   clk_conv_ar_ready   	),
    .clk_conv_b_valid       (   clk_conv_b_valid    	),
    .clk_conv_b_id          (   clk_conv_b_id       	),
    .clk_conv_w_ready       (   clk_conv_w_ready    	),
    .clk_conv_aw_ready      (   clk_conv_aw_ready   	),
	.ui_clk_sync_rst		(	ui_clk_sync_rst			),


   // DDR3 RAM
    // .ddr_dq 	(	ddr_dq 		),
    // .ddr_dqs_n  (  	ddr_dqs_n   ),
    // .ddr_dqs_p  (  	ddr_dqs_p   ),
    // .ddr_addr   (  	ddr_addr	),
    // .ddr_ba     (  	ddr_ba      ),
    // .ddr_ras_n  (  	ddr_ras_n	),
    // .ddr_cas_n  (  	ddr_cas_n   ),
    // .ddr_we_n   (  	ddr_we_n	),
    // .ddr_reset_n(  	ddr_reset_n ),
    // .ddr_ck_n   (  	ddr_ck_n	),
    // .ddr_ck_p   (  	ddr_ck_p    ),
    // .ddr_cke    (  	ddr_cke		),
    // .ddr_cs_n   (  	ddr_cs_n 	),
    // .ddr_dm		(  	ddr_dm		),
    // .ddr_odt    (  	ddr_odt     ),
	
	//=============================
	// clk_wiz_0 interface
	//=============================
	
	.clk_mii       	(	clk_mii       	),
	.clk_cpu       	(	clk_cpu       	),
	.clk_out1		(	clk_out1		),
	.clk_pixel     	(	clk_pixel     	),
	.locked			(	locked			),

	// .clk_in1	    (	clk_in1	    	),
	// .reset 	       	(	reset 	       	),
	
	//=============================
	// clk_wiz_1 interface
	//=============================
	
	// .clk_in1		(	clk_in1			),      // input clk_in1
	.clk_sdclk		(	clk_sdclk		),     // output clk_sdclk
	.daddr			(	daddr			), // input [6:0] daddr
	// .dclk			(	dclk			), // input dclk
	.den			(	den				), // input den
	.din			(	din				), // input [15:0] din
	.dout			(	dout			), // output [15:0] dout
	.drdy			(	drdy			), // output drdy
	.dwe			(	dwe				), // input dwe
	.reset			(	reset			),
	.sd_clk_locked	(	sd_clk_locked	),
	
	
	
	
	
	
	
	
// `endif
// `endif //  `ifdef ADD_DDR_IO

`ifdef ADD_FLASH
	.flash_ss 	(	flash_ss	),
	.flash_io 	(	flash_io	),
`endif

`ifdef ADD_SPI
	.spi_cs		(	spi_cs		),
	.spi_sclk   (   spi_sclk    ),
    .spi_mosi   (   spi_mosi    ),
    .spi_miso   (   spi_miso    ),
    .sd_reset   (   sd_reset    ),                              
`endif

// `ifdef ADD_HID
   // Simple UART interface
   .rxd			(	rxd			),
   .txd         (   txd         ),
   .rts         (   rts         ),
   .cts         (   cts         ),
   
   // 4-bit full SD interface
   .sd_sclk		(	sd_sclk		),
   .sd_detect   (   sd_detect   ),
   .sd_dat      (   sd_dat      ),
   .sd_cmd      (   sd_cmd      ),
   .sd_reset    (   sd_reset    ),
   
   // LED and DIP switch
   .o_led		(	o_led 		),
   .i_dip       (   i_dip       ),
   
   // push button array
   .GPIO_SW_C	(	GPIO_SW_C	),
   .GPIO_SW_W   (   GPIO_SW_W   ),
   .GPIO_SW_E   (   GPIO_SW_E   ),
   .GPIO_SW_N   (   GPIO_SW_N   ),
   .GPIO_SW_S   (   GPIO_SW_S   ),
   
   //keyboard
   .PS2_CLK		(	PS2_CLK		),
   .PS2_DATA    (   PS2_DATA    ),
   
   
 //! Ethernet MAC PHY interface signals
	.i_erx_dv 	(	i_erx_dv 	),		// PHY data valid
    .i_erx_er 	(	i_erx_er 	),		// PHY coding error
    .i_emdint 	(	i_emdint 	),		// PHY interrupt in active low
    .o_erefclk 	(	o_erefclk	),		// RMII clock out
 
// // `ifdef KC705   
	.i_erxd		(	i_erxd		),		// RMII receive data
	.o_etxd 	(	o_etxd 		),		// RMII transmit data
	.o_etx_er 	(	o_etx_er 	),		// RMII transmit enable
	.i_gmiiclk_p(   i_gmiiclk_p ),
	.i_gmiiclk_n(   i_gmiiclk_n ),
	.i_erx_clk	(   i_erx_clk	),
	.i_etx_clk  (	i_etx_clk   ),
// // `else
// // `endif   
	.o_emdc 	(	o_emdc 		),		// MDIO clock
	.io_emdio 	(	io_emdio	),		// MDIO inout
	.o_erstn 	(	o_erstn 	),		// PHY reset active low
// `endif
   // clock and reset
	// .clk_p		(	clk_p		),
	// .clk_n      (   clk_n       ),
	.rst_top    (   rst_top     )

);
endmodule
