module chip_top_mod_wrapper_wrapper
  (
   //clock related

   input wire         rstn,           //from mig
   input wire         clk,            //from wiz_0  
   input wire         clk_locked_wiz, //from wiz_0
   input wire         rst_top,        //from external
   input wire         mig_sys_clk,    //from wiz_0
   input wire         clk_pixel,      //from wiz_0
   input wire         clk_mii,        //from wiz_0
   input wire         mig_ui_clk,     //from mig
   input wire         mig_ui_rst,     //from mig

   ///////////////////////////////////////////

   //ADD_HID
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

	// LED and DIP switch
	output wire [7:0]  o_led,
	input wire  [3:0]  i_dip,
	// push button array
	input wire         GPIO_SW_C,
	input wire         GPIO_SW_W,
	input wire         GPIO_SW_E,
	input wire         GPIO_SW_N,
	input wire         GPIO_SW_S,
	//keyboard
	inout wire         PS2_CLK,
	inout wire         PS2_DATA,

	//! Ethernet MAC PHY interface signals
	input wire         i_erx_dv, // PHY data valid
	input wire         i_erx_er, // PHY coding error
	input wire         i_emdint, // PHY interrupt in active low
	output wire         o_erefclk, // RMII clock out
	output wire         o_etx_en, // RMII transmit enable
	//KC705   
	input wire [3:0]   i_erxd, // RMII receive data
	output wire [7:0]   o_etxd, // RMII transmit data
	output wire         o_etx_er, // RMII transmit enable
	input wire         i_gmiiclk_p,
	input wire         i_gmiiclk_n,
	input wire         i_erx_clk,
	input wire         i_etx_clk,
	output wire        o_emdc, // MDIO clock
	inout wire         io_emdio, // MDIO inout
	output wire        o_erstn, // PHY reset active low

   //above port --> Existing external interface

   //below port --> Fixed interface

   output wire [3:0]  mig_s_axi_awid,
   output wire [29:0] mig_s_axi_awaddr,
   output wire [7:0]  mig_s_axi_awlen,
   output wire [2:0]  mig_s_axi_awsize,
   output wire [1:0]  mig_s_axi_awburst,
   output wire [0:0]  mig_s_axi_awlock,
   output wire [3:0]  mig_s_axi_awcache,
   output wire [2:0]  mig_s_axi_awprot,
   output wire [3:0]  mig_s_axi_awqos,
   output wire        mig_s_axi_awvalid,
   input  wire        mig_s_axi_awready,
   output wire [63:0] mig_s_axi_wdata,
   output wire [7:0]  mig_s_axi_wstrb,
   output wire        mig_s_axi_wlast,
   output wire        mig_s_axi_wvalid,
   input  wire        mig_s_axi_wready,
   input  wire [3:0]  mig_s_axi_bid,
   input  wire [1:0]  mig_s_axi_bresp,
   input  wire        mig_s_axi_bvalid,
   output wire        mig_s_axi_bready,
   output wire [3:0]  mig_s_axi_arid,
   output wire [29:0] mig_s_axi_araddr,
   output wire [7:0]  mig_s_axi_arlen,
   output wire [2:0]  mig_s_axi_arsize,
   output wire [1:0]  mig_s_axi_arburst,
   output wire [0:0]  mig_s_axi_arlock,
   output wire [3:0]  mig_s_axi_arcache,
   output wire [2:0]  mig_s_axi_arprot,
   output wire [3:0]  mig_s_axi_arqos,
   output wire        mig_s_axi_arvalid,
   input  wire        mig_s_axi_arready,
   input  wire [3:0]  mig_s_axi_rid,
   input  wire [63:0] mig_s_axi_rdata,
   input  wire [1:0]  mig_s_axi_rresp,
   input  wire        mig_s_axi_rlast,
   input  wire        mig_s_axi_rvalid,
   output wire        mig_s_axi_rready,

//external interface

   input  wire         sd_clk_o,
   output wire [6:0]   sd_clk_daddr,
   output wire         sd_clk_den,
   output wire [15:0]  sd_clk_din,
   input  wire [15:0]  sd_clk_dout,
   input  wire         sd_clk_drdy,
   output wire         sd_clk_dwe,
   output wire         clk_wiz1_rst,
   input  wire         sd_clk_locked	);
   
chip_top_mod_wrapper U0_CHIP_TOP_WRAPPED(
   //clock related

   .rstn           (	rstn           	),			//from mig
   .clk            (	clk            	),			//from wiz_0  
   .clk_locked_wiz (	clk_locked_wiz 	),			//from wiz_0
   .rst_top        (	rst_top        	),			//from external
   .mig_sys_clk    (	mig_sys_clk    	),			//from wiz_0
   .clk_pixel      (	clk_pixel      	),			//from wiz_0
   .clk_mii        (	clk_mii        	),			//from wiz_0
   .mig_ui_clk     (	mig_ui_clk     	),			//from mig
   .mig_ui_rst     (	mig_ui_rst     	),			//from mig

   ///////////////////////////////////////////

   //ADD_HID
	// Simple UART interface
	.rxd			(	rxd				),
	.txd            (	txd             ),
	.rts            (	rts             ),
	.cts            (	cts             ),

	// 4-bit full SD interface
	.sd_sclk		(	sd_sclk			),
	.sd_detect      (	sd_detect      	),
	.sd_dat         (	sd_dat         	),
	.sd_cmd         (	sd_cmd         	),
	.sd_reset       (	sd_reset       	),
						
	// LED and DIP switch
	.o_led			(	o_led			),
	.i_dip          (	i_dip          	),
	// push button array
	.GPIO_SW_C		(	GPIO_SW_C		),
	.GPIO_SW_W      (   GPIO_SW_W      	),
	.GPIO_SW_E      (   GPIO_SW_E      	),
	.GPIO_SW_N      (   GPIO_SW_N      	),
	.GPIO_SW_S      (   GPIO_SW_S      	),
	//keyboard
	.PS2_CLK		(	PS2_CLK			),
	.PS2_DATA       (	PS2_DATA 		),

	//! Ethernet MAC PHY interface signals
	.i_erx_dv 		(	i_erx_dv 		),	// PHY data valid
	.i_erx_er 		(	i_erx_er 		),	// PHY coding error
	.i_emdint 		(	i_emdint 		),	// PHY interrupt in active low
	.o_erefclk 		(	o_erefclk		),	// RMII clock out
	.o_etx_en 		(	o_etx_en 		),	// RMII transmit enable
	//KC705   
	.i_erxd 		(	i_erxd 			),				// RMII receive data
	.o_etxd 		(	o_etxd 			),				// RMII transmit data
	.o_etx_er 		(	o_etx_er 		),					// RMII transmit enable
	.i_gmiiclk_p	(	i_gmiiclk_p		),
	.i_gmiiclk_n	(	i_gmiiclk_n		),
	.i_erx_clk		(	i_erx_clk		),
	.i_etx_clk		(	i_etx_clk		),
	.o_emdc			(	o_emdc			),					// MDIO clock
	.io_emdio 		(	io_emdio 		),					// MDIO inout
	.o_erstn 		(	o_erstn 		),				// PHY reset active low

   //above port --> Existing external interface

   //below port --> Fixed interface

   .mig_s_axi_awid		(	mig_s_axi_awid			),
   .mig_s_axi_awaddr    (	mig_s_axi_awaddr		),
   .mig_s_axi_awlen     (	mig_s_axi_awlen			),
   .mig_s_axi_awsize    (	mig_s_axi_awsize		),
   .mig_s_axi_awburst   (	mig_s_axi_awburst		),
   .mig_s_axi_awlock    (	mig_s_axi_awlock		),
   .mig_s_axi_awcache   (	mig_s_axi_awcache		),
   .mig_s_axi_awprot    (	mig_s_axi_awprot		),
   .mig_s_axi_awqos     (	mig_s_axi_awqos			),
   .mig_s_axi_awvalid   (	mig_s_axi_awvalid		),
   .mig_s_axi_awready   (	mig_s_axi_awready		),
   .mig_s_axi_wdata     (	mig_s_axi_wdata			),
   .mig_s_axi_wstrb     (	mig_s_axi_wstrb			),
   .mig_s_axi_wlast     (	mig_s_axi_wlast			),
   .mig_s_axi_wvalid    (	mig_s_axi_wvalid		),
   .mig_s_axi_wready    (	mig_s_axi_wready		),
   .mig_s_axi_bid       (	mig_s_axi_bid			),
   .mig_s_axi_bresp     (	mig_s_axi_bresp			),
   .mig_s_axi_bvalid    (	mig_s_axi_bvalid		),
   .mig_s_axi_bready    (	mig_s_axi_bready		),
   .mig_s_axi_arid      (	mig_s_axi_arid			),
   .mig_s_axi_araddr    (	mig_s_axi_araddr		),
   .mig_s_axi_arlen     (	mig_s_axi_arlen			),
   .mig_s_axi_arsize    (	mig_s_axi_arsize		),
   .mig_s_axi_arburst   (	mig_s_axi_arburst		),
   .mig_s_axi_arlock    (	mig_s_axi_arlock		),
   .mig_s_axi_arcache   (	mig_s_axi_arcache		),
   .mig_s_axi_arprot    (	mig_s_axi_arprot		),
   .mig_s_axi_arqos     (	mig_s_axi_arqos			),
   .mig_s_axi_arvalid   (	mig_s_axi_arvalid		),
   .mig_s_axi_arready   (	mig_s_axi_arready		),
   .mig_s_axi_rid       (	mig_s_axi_rid			),
   .mig_s_axi_rdata     (	mig_s_axi_rdata			),
   .mig_s_axi_rresp     (	mig_s_axi_rresp			),
   .mig_s_axi_rlast     (	mig_s_axi_rlast			),
   .mig_s_axi_rvalid    (	mig_s_axi_rvalid		),
   .mig_s_axi_rready    (	mig_s_axi_rready		),

//external interface

   .sd_clk_o			(	sd_clk_o				),
   .sd_clk_daddr        (	sd_clk_daddr			),
   .sd_clk_den          (	sd_clk_den				),
   .sd_clk_din          (	sd_clk_din				),
   .sd_clk_dout         (	sd_clk_dout				),
   .sd_clk_drdy         (	sd_clk_drdy				),
   .sd_clk_dwe          (	sd_clk_dwe				),
   .clk_wiz1_rst        (	clk_wiz1_rst			),
   .sd_clk_locked       (	sd_clk_locked			)
);	
endmodule