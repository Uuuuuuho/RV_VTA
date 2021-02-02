//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.1 (lin64) Build 2188600 Wed Apr  4 18:39:19 MDT 2018
//Date        : Tue May 19 21:21:19 2020
//Host        : Panther running 64-bit Ubuntu 16.04.6 LTS
//Command     : generate_target psoc_wrapper.bd
//Design      : psoc_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module periph_soc_wrapper
   (
		output wire        uart_tx,
		output wire        uart_irq,
		input wire         uart_rx,
		// clock and reset
		input wire         clk_200MHz,
		input wire         pxl_clk,
		input wire         msoc_clk,
		input wire         rstn,
		// output reg [15:0]  to_led,
		output wire [15:0]  to_led,
		input wire [15:0]  from_dip,
		inout wire         sd_sclk,
		input wire         sd_detect,
		inout wire [3:0]   sd_dat,
		inout wire         sd_cmd,
		// output reg         sd_reset,
		// output reg         sd_irq,
		output wire			sd_reset,
		output wire         sd_irq,
		input wire         hid_en,
		input wire [7:0]   hid_we,
		input wire [17:0]  hid_addr,
		input wire [63:0]  hid_wrdata,
		// output reg [63:0]  hid_rddata,
		output wire [63:0]  hid_rddata,
		// pusb button array
		input wire         GPIO_SW_C,
		input wire         GPIO_SW_W,
		input wire         GPIO_SW_E,
		input wire         GPIO_SW_N,
		input wire         GPIO_SW_S,
		//keyboard
		inout wire         PS2_CLK,
		inout wire         PS2_DATA,

		// display
		output wire        VGA_HS_O,
		output wire        VGA_VS_O,
		output wire [3:0]  VGA_RED_O,
		output wire [3:0]  VGA_BLUE_O,
		output wire [3:0]  VGA_GREEN_O,
		// SMSC ethernet PHY to framing_top connections
		input wire         locked,
		output wire        eth_rstn,
		input wire         eth_crsdv,
		output wire        eth_refclk,
		`ifdef KC705   
		output wire [3:0]  eth_txd,
		input wire [3:0]   eth_rxd,
		input wire         i_erx_clk,
		input wire         i_etx_clk,
		input wire         clk_mii,
		output wire        eth_txer,
		`else   
		output wire [1:0]  eth_txd,
		input wire [1:0]   eth_rxd,
		input wire         clk_rmii,
		`endif   
		output wire        eth_txen,
		input wire         eth_rxerr,
		output wire        eth_mdc,
		input wire         phy_mdio_i,
		output wire        phy_mdio_o,
		output wire        phy_mdio_t,
		output wire        eth_irq,
		output wire        ram_clk,
		output wire        ram_rst,
		output wire        ram_en,
		output wire [7:0]  ram_we,
		output wire [15:0] ram_addr,
		output wire [63:0] ram_wrdata,
		input wire [63:0]  ram_rddata,



		// //====================
		// //  in case clk_wiz_1 should be removed
		// //====================
		// // Clock in ports
		// input wire 		msoc_clk				,   // input clk_in1
		// // Clock out ports
		// output wire 		sd_clk_o				,   // output clk_sdclk
		// // Dynamic reconfiguration ports
		// output wire 		sd_clk_daddr			, 	// input [6:0] daddr
		// output wire 		sd_clk_dclk				,	// input dclk
		// output wire 		sd_clk_den				,	// input den
		// output wire 		sd_clk_din				, 	// input [15:0] din
		// input wire 		sd_clk_dout				, 	// output [15:0] dout
		// input wire 		sd_clk_drdy				, 	// output drdy
		// output wire 		sd_clk_dwe				, 	// input dwe
		// // Status and control signals
		// input wire 		sd_clk_rst				,	//(~(sd_clk_rst&rstn))		, 	// input reset
		// output wire 		sd_clk_locked


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
	input wire 			sd_clk_locked



   );


  periph_soc_modified periph_soc_i
       (
		.uart_tx			(	uart_tx			),
		.uart_irq           (	uart_irq           ),
		.uart_rx            (	uart_rx            ),
		// clock and reset  (	/ clock and re     ),
		.clk_200MHz         (	clk_200MHz         ),
		.pxl_clk            (	pxl_clk            ),
		.msoc_clk           (	msoc_clk           ),
		.rstn               (	rstn               ),
		.to_led             (	to_led             ),
		.from_dip           (	from_dip           ),
		.sd_sclk            (	sd_sclk            ),
		.sd_detect          (	sd_detect          ),
		.sd_dat             (	sd_dat             ),
		.sd_cmd             (	sd_cmd             ),
		.sd_reset           (	sd_reset           ),
		.sd_irq             (	sd_irq             ),
		.hid_en             (	hid_en             ),
		.hid_we             (	hid_we             ),
		.hid_addr           (	hid_addr           ),
		.hid_wrdata         (	hid_wrdata         ),
		.hid_rddata         (	hid_rddata         ),
		// pusb button array(	/ pusb button      ),
		.GPIO_SW_C          (	GPIO_SW_C          ),
		.GPIO_SW_W          (	GPIO_SW_W          ),
		.GPIO_SW_E          (	GPIO_SW_E          ),
		.GPIO_SW_N          (	GPIO_SW_N          ),
		.GPIO_SW_S          (	GPIO_SW_S          ),
		//keyboard          (	/keyboard          ),
		.PS2_CLK            (	PS2_CLK            ),
		.PS2_DATA           (	PS2_DATA           ),
							
		// display          (	/ display          ),
		.VGA_HS_O           (	VGA_HS_O           ),
		.VGA_VS_O           (	VGA_VS_O           ),
		.VGA_RED_O          (	VGA_RED_O          ),
		.VGA_BLUE_O         (	VGA_BLUE_O         ),
		.VGA_GREEN_O        (	VGA_GREEN_O        ),
		// SMSC ethernet PHY(	/ SMSC etherne to f),raming_top connections
		.locked             (	locked             ),
		.eth_rstn           (	eth_rstn           ),
		.eth_crsdv          (	eth_crsdv          ),
		.eth_refclk         (	eth_refclk         ),
`ifdef KC705                
		.eth_txd            (	eth_txd            ),
		.eth_rxd            (	eth_rxd            ),
		.i_erx_clk          (	i_erx_clk          ),
		.i_etx_clk          (	i_etx_clk          ),
		.clk_mii            (	clk_mii            ),
		.eth_txer           (	eth_txer           ),
`else                       
		.eth_txd            (	eth_txd            ),
		.eth_rxd            (	eth_rxd            ),
		.clk_rmii           (	clk_rmii           ),
`endif                      
		.eth_txen           (	eth_txen           ),
		.eth_rxerr          (	eth_rxerr          ),
		.eth_mdc            (	eth_mdc            ),
		.phy_mdio_i         (	phy_mdio_i         ),
		.phy_mdio_o         (	phy_mdio_o         ),
		.phy_mdio_t         (	phy_mdio_t         ),
		.eth_irq            (	eth_irq            ),
		.ram_clk            (	ram_clk            ),
		.ram_rst            (	ram_rst            ),
		.ram_en             (	ram_en             ),
		.ram_we             (	ram_we             ),
		.ram_addr           (	ram_addr           ),
		.ram_wrdata         (	ram_wrdata         ),
		.ram_rddata         (	ram_rddata         ),


//====================
//  in case clk_wiz_1 should be removed
//====================

		// .clk_in1			(	clk_in1				),   // input clk_in1
		.clk_sdclk			(	clk_sdclk			),   // output clk_sdclk
		.daddr				(	daddr				), 	// input [6:0] daddr
		// .dclk				(	dclk				),	// input dclk
		.den				(	den					),	// input den
		.din				(	din					), 	// input [15:0] din
		.dout				(	dout				), 	// output [15:0] dout
		.drdy				(	drdy				), 	// output drdy
		.dwe				(	dwe					), 	// input dwe
		.reset				(	reset				),	//(~(sd_clk_rst&rstn))		, 	// input reset
		.sd_clk_locked		(	sd_clk_locked		)




		// //====================
		// //  in case clk_wiz_1 should be removed
		// //====================
		// // Clock in ports
		// .msoc_clk			(	msoc_clk			)		,   // input clk_in1
		// // Clock out por	(	/ Clock out por	)ts
		// .sd_clk_o			(	sd_clk_o			)		,   // output clk_sdclk
		// // Dynamic recon	(	/ Dynamic recon	)figuration ports
		// .sd_clk_daddr		(	sd_clk_daddr		)		, 	// input [6:0] daddr
		// .sd_clk_dclk		(	sd_clk_dclk		)			,	// input dclk
		// .sd_clk_den			(	sd_clk_den			)		,	// input den
		// .sd_clk_din			(	sd_clk_din			)		, 	// input [15:0] din
		// .sd_clk_dout		(	sd_clk_dout		)			, 	// output [15:0] dout
		// .sd_clk_drdy		(	sd_clk_drdy		)			, 	// output drdy
		// .sd_clk_dwe			(	sd_clk_dwe			)		, 	// input dwe
		// // Status and co	(	/ Status and co	)ntrol signals
		// .sd_clk_rst			(	sd_clk_rst			)		,	//(~(sd_clk_rst&rstn))		, 	// input reset
		// .sd_clk_locked		(	sd_clk_locked      )

	   
	   
	   );
endmodule
