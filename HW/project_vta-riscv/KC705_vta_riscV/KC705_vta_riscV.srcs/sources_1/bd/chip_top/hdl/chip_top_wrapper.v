//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
//Date        : Fri May 15 16:32:26 2020
//Host        : Panther running 64-bit Ubuntu 16.04.6 LTS
//Command     : generate_target chip_top_wrapper.bd
//Design      : chip_top_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module chip_top_wrapper
   (
  
//define input/output
   
   // DDR3 RAM
   inout wire [63:0]  ddr_dq		,
   inout wire [7:0]   ddr_dqs_n     ,
   inout wire [7:0]   ddr_dqs_p     ,
   output wire [13:0] ddr_addr      ,
   output wire [2:0]  ddr_ba        ,
   output wire        ddr_ras_n     ,
   output wire        ddr_cas_n     ,
   output wire        ddr_we_n      ,
   output wire        ddr_reset_n   ,
   output wire        ddr_ck_n      ,
   output wire        ddr_ck_p      ,
   output wire        ddr_cke       ,
   output wire        ddr_cs_n      ,
   output wire [7:0]  ddr_dm        ,
   output wire        ddr_odt		,
   
   
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
									
`ifdef ADD_HID                      
	// Simple UART interface        
	input wire         rxd			,
	output wire        txd			,
	output wire        rts			,
	input wire         cts			,
									
	// 4-bit full SD interface      
	inout wire         sd_sclk      ,
	input wire         sd_detect    ,
	inout wire [3:0]   sd_dat       ,
	inout wire         sd_cmd       ,
	output wire        sd_reset		,

	// LED and DIP switch
`ifdef NEXYS4_COMMON
	output wire [15:0] o_led		,
	input wire  [15:0] i_dip		,
	// display
	output wire        VGA_HS_O     ,
	output wire        VGA_VS_O     ,
	output wire [3:0]  VGA_RED_O    ,
	output wire [3:0]  VGA_BLUE_O   ,
	output wire [3:0]  VGA_GREEN_O	,
`else                               
   output wire [7:0]  o_led			,
   input wire  [3:0]  i_dip			,
`endif
	// push button array
	input wire         GPIO_SW_C	,	
	input wire         GPIO_SW_W	,	
	input wire         GPIO_SW_E	,	
	input wire         GPIO_SW_N	,	
	input wire         GPIO_SW_S	,	
	//keyboard
	inout wire         PS2_CLK		,
	inout wire         PS2_DATA		,

	//! Ethernet MAC PHY interface signals
	input wire         i_erx_dv		, // PHY data valid
	input wire         i_erx_er		, // PHY coding error
	input wire         i_emdint		, // PHY interrupt in active low
	output reg         o_erefclk	, // RMII clock out
	output reg         o_etx_en		, // RMII transmit enable
// `ifdef KC705                        
	input wire [3:0]   i_erxd		, // RMII receive data
	output reg [7:0]   o_etxd		, // RMII transmit data
	output reg         o_etx_er		, // RMII transmit enable
	input wire         i_gmiiclk_p	,
	input wire         i_gmiiclk_n	,
	input wire         i_erx_clk	,
	input wire         i_etx_clk	,
// `else                               
	// input wire [1:0]   i_erxd		, // RMII receive data
	// output reg [1:0]   o_etxd		, // RMII transmit data
// `endif                              
	output wire        o_emdc 		, // MDIO clock
	inout wire         io_emdio 	, // MDIO inout
	output wire        o_erstn 		, // PHY reset active low
`endif                              
	// clock and reset              
	input wire         clk_p		,
	input wire         clk_n		,
	input wire         rst_top      
);



chip_top U0_CHIP_TOP
  (
`ifdef ADD_PHY_DDR
 `ifdef KC705
   // DDR3 RAM
    .ddr_dq 	(	ddr_dq 		),
    .ddr_dqs_n  (  	ddr_dqs_n   ),
    .ddr_dqs_p  (  	ddr_dqs_p   ),
    .ddr_addr   (  	ddr_addr	),
    .ddr_ba     (  	ddr_ba      ),
    .ddr_ras_n  (  	ddr_ras_n	),
    .ddr_cas_n  (  	ddr_cas_n   ),
    .ddr_we_n   (  	ddr_we_n	),
    .ddr_reset_n(  	ddr_reset_n ),
    .ddr_ck_n   (  	ddr_ck_n	),
    .ddr_ck_p   (  	ddr_ck_p    ),
    .ddr_cke    (  	ddr_cke		),
    .ddr_cs_n   (  	ddr_cs_n 	),
    .ddr_dm		(  	ddr_dm		),
    .ddr_odt    (  	ddr_odt     ),
	
`endif
`endif //  `ifdef ADD_DDR_IO

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

`ifdef ADD_HID
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
 
`ifdef KC705   
	.i_erxd		(	i_erxd		),		// RMII receive data
	.o_etxd 	(	o_etxd 		),		// RMII transmit data
	.o_etx_er 	(	o_etx_er 	),		// RMII transmit enable
	.i_gmiiclk_p(   i_gmiiclk_p ),
	.i_gmiiclk_n(   i_gmiiclk_n ),
	.i_erx_clk	(   i_erx_clk	),
	.i_etx_clk  (	i_etx_clk   ),
`else
`endif   
	.o_emdc 	(	o_emdc 		),		// MDIO clock
	.io_emdio 	(	io_emdio	),		// MDIO inout
	.o_erstn 	(	o_erstn 	),		// PHY reset active low
`endif
   // clock and reset
	.clk_p		(	clk_p		),
	.clk_n      (   clk_n       ),
	.rst_top    (   rst_top     )

);
endmodule
