// See LICENSE for license details.

`include "consts.vh"
`include "config.vh"

// Allow ISA regression test to use proper FPGA configuration

module RISC_V_TOP_wrapper
  (
 //def KC705
   // clock and reset
   input wire         clk_p,
   input wire         clk_n,
   input wire         rst_top,

   // DDR3 RAM
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
	output reg         o_erefclk, // RMII clock out
	output reg         o_etx_en, // RMII transmit enable
	//KC705   
	input wire [3:0]   i_erxd, // RMII receive data
	output reg [7:0]   o_etxd, // RMII transmit data
	output reg         o_etx_er, // RMII transmit enable
	input wire         i_gmiiclk_p,
	input wire         i_gmiiclk_n,
	input wire         i_erx_clk,
	input wire         i_etx_clk,
	output wire        o_emdc, // MDIO clock
	inout wire         io_emdio, // MDIO inout
	output wire        o_erstn // PHY reset active low
);



//mig <-> chip_top interface
wire [3:0]  mig_s_axi_awid;
wire [29:0] mig_s_axi_awaddr;
wire [7:0]  mig_s_axi_awlen;
wire [2:0]  mig_s_axi_awsize;
wire [1:0]  mig_s_axi_awburst;
wire [0:0]  mig_s_axi_awlock;
wire [3:0]  mig_s_axi_awcache;
wire [2:0]  mig_s_axi_awprot;
wire [3:0]  mig_s_axi_awqos;
wire        mig_s_axi_awvalid;
wire        mig_s_axi_awready;
wire [63:0] mig_s_axi_wdata;
wire [7:0]  mig_s_axi_wstrb;
wire        mig_s_axi_wlast;
wire        mig_s_axi_wvalid;
wire        mig_s_axi_wready;
wire [3:0]  mig_s_axi_bid;
wire [1:0]  mig_s_axi_bresp;
wire        mig_s_axi_bvalid;
wire        mig_s_axi_bready;
wire [3:0]  mig_s_axi_arid;
wire [29:0] mig_s_axi_araddr;
wire [7:0]  mig_s_axi_arlen;
wire [2:0]  mig_s_axi_arsize;
wire [1:0]  mig_s_axi_arburst;
wire [0:0]  mig_s_axi_arlock;
wire [3:0]  mig_s_axi_arcache;
wire [2:0]  mig_s_axi_arprot;
wire [3:0]  mig_s_axi_arqos;
wire        mig_s_axi_arvalid;
wire        mig_s_axi_arready;
wire [3:0]  mig_s_axi_rid;
wire [63:0] mig_s_axi_rdata;
wire [1:0]  mig_s_axi_rresp;
wire        mig_s_axi_rlast;
wire        mig_s_axi_rvalid;
wire        mig_s_axi_rready;

//clk_interface

wire   clk_locked_wiz;
logic  mig_sys_clk, clk_pixel;
logic  clk, rstn;
logic  mig_ui_clk, mig_ui_rst;
logic  clk_mii, clk_mii_quad;

// `define LOCKED clk_locked_wiz & !rst_top


////clk_wiz1 wire
//wire         wiz1_clk_in1;
wire         wiz1_clk_sdclk;
wire [6:0]   wiz1_daddr;
wire         wiz1_dclk;
wire         wiz1_den;
wire [15:0]  wiz1_din;
wire [15:0]  wiz1_dout;
wire         wiz1_drdy;
wire         wiz1_dwe;
wire         wiz1_reset;
wire         wiz1_locked;

//mig interface

   // DRAM controller
   mig_7series_0 dram_ctl
     (
   //KC705

      //External interface
      .sys_clk_p            ( clk_p                  ), //external sig
      .sys_clk_n            ( clk_n                  ), //external sig
      .sys_rst              ( rst_top                ), //external sig
      .ddr3_dq              ( ddr_dq                 ), //external sig
      .ddr3_dqs_n           ( ddr_dqs_n              ), //external sig
      .ddr3_dqs_p           ( ddr_dqs_p              ), //external sig
      .ddr3_addr            ( ddr_addr               ), //external sig
      .ddr3_ba              ( ddr_ba                 ), //external sig
      .ddr3_ras_n           ( ddr_ras_n              ), //external sig
      .ddr3_cas_n           ( ddr_cas_n              ), //external sig
      .ddr3_we_n            ( ddr_we_n               ), //external sig
      .ddr3_reset_n         ( ddr_reset_n            ), //external sig
      .ddr3_ck_p            ( ddr_ck_p               ), //external sig
      .ddr3_ck_n            ( ddr_ck_n               ), //external sig
      .ddr3_cke             ( ddr_cke                ), //external sig
      .ddr3_cs_n            ( ddr_cs_n               ), //external sig
      .ddr3_dm              ( ddr_dm                 ), //external sig
      .ddr3_odt             ( ddr_odt                ), //external sig


      //internal interface
      .ui_clk               ( mig_ui_clk             ), //output //internal
      .ui_clk_sync_rst      ( mig_ui_rst             ), //output //internal
      .mmcm_locked          ( rstn                   ), //output //internal
      .aresetn              ( rstn                   ), //input
      .app_sr_req           ( 1'b0                   ), //input
      .app_ref_req          ( 1'b0                   ), //input
      .app_zq_req           ( 1'b0                   ), //input

      //axi_interface <- internal interface
      .s_axi_awid           (mig_s_axi_awid),
      .s_axi_awaddr         (mig_s_axi_awaddr),
      .s_axi_awlen          (mig_s_axi_awlen),
      .s_axi_awsize         (mig_s_axi_awsize),
      .s_axi_awburst        (mig_s_axi_awburst),
      .s_axi_awlock         (mig_s_axi_awlock),
      .s_axi_awcache        (mig_s_axi_awcache),
      .s_axi_awprot         (mig_s_axi_awprot),
      .s_axi_awqos          (mig_s_axi_awqos),
      .s_axi_awvalid        (mig_s_axi_awvalid),
      .s_axi_awready        (mig_s_axi_awready),
      .s_axi_wdata          (mig_s_axi_wdata),
      .s_axi_wstrb          (mig_s_axi_wstrb),
      .s_axi_wlast          (mig_s_axi_wlast),
      .s_axi_wvalid         (mig_s_axi_wvalid),
      .s_axi_wready         (mig_s_axi_wready),
      .s_axi_bid            (mig_s_axi_bid),
      .s_axi_bresp          (mig_s_axi_bresp),
      .s_axi_bvalid         (mig_s_axi_bvalid),
      .s_axi_bready         (mig_s_axi_bready),
      .s_axi_arid           (mig_s_axi_arid),
      .s_axi_araddr         (mig_s_axi_araddr),
      .s_axi_arlen          (mig_s_axi_arlen),
      .s_axi_arsize         (mig_s_axi_arsize),
      .s_axi_arburst        (mig_s_axi_arburst),
      .s_axi_arlock         (mig_s_axi_arlock),
      .s_axi_arcache        (mig_s_axi_arcache),
      .s_axi_arprot         (mig_s_axi_arprot),
      .s_axi_arqos          (mig_s_axi_arqos),
      .s_axi_arvalid        (mig_s_axi_arvalid),
      .s_axi_arready        (mig_s_axi_arready),
      .s_axi_rid            (mig_s_axi_rid),
      .s_axi_rdata          (mig_s_axi_rdata),
      .s_axi_rresp          (mig_s_axi_rresp),
      .s_axi_rlast          (mig_s_axi_rlast),
      .s_axi_rvalid         (mig_s_axi_rvalid),
      .s_axi_rready         (mig_s_axi_rready)
      );


//clk_wiz0 interface

   clk_wiz_0 clk_gen(
      .clk_in1       ( mig_ui_clk    ), // 100 MHz from MIG
      .reset         ( rst_top       ),
      .clk_mii       ( clk_mii       ), // 25 MHz MII
      .clk_mii_quad  ( clk_mii_quad  ), // 25 MHz MII quad
      .clk_cpu       ( clk           ), // 50 MHz
      .clk_out1      ( mig_sys_clk   ), // 200 MHz
      .clk_pixel     ( clk_pixel     ), // 120 MHz
      .locked        ( clk_locked_wiz )

      //input  clk_in1           from mig
      //input  reset             from external
      //output clk_mii           to psoc
      //output clk_mii_quad      //useless
      //output clk_cpu           to axi_clock_converter_0 axi_bram_ctrl_dummy periph_soc ExampleRocketSystem
      //output clk_out1          to psoc
      //output clk_pixel         to psoc
      //output locked            //assign o_erstn = eth_rstn & clk_locked_wiz;
   );

   //wire clk_locked;
   //assign clk_locked = clk_locked_wiz & !rst_top;

//clk_wiz1 interface (psoc internal)

//FPGA FULL
   clk_wiz_1 sd_clk_div(
      .clk_in1    (clk             ), //wiz1_clk_in1 = clk (from mig)
      .clk_sdclk  (wiz1_clk_sdclk  ), //output
      .daddr      (wiz1_daddr      ),
      .dclk       (clk             ), //wiz1_dclk = clk (from mig)
      .den        (wiz1_den        ),
      .din        (wiz1_din        ),
      .dout       (wiz1_dout       ),
      .drdy       (wiz1_drdy       ),
      .dwe        (wiz1_dwe        ),
      .reset      (wiz1_reset      ),
      .locked     (wiz1_locked     )

      //input         clk_in1
      //output        clk_sdclk
      //input [6:0]   daddr
      //input         dclk
      //input         den
      //input [15:0]  din
      //output [15:0] dout
      //output        drdy
      //input         dwe
      //input         reset
      //output        locked
   );

//chip_top interface

chip_top_without_mig_clkwiz U0_CHIP_TOP(

   .rstn             (rstn                ),
   .clk              (clk                 ),
   .clk_locked_wiz   (clk_locked_wiz      ),
   .rst_top          (rst_top             ),
   .mig_sys_clk      (mig_sys_clk         ),
   .clk_pixel        (clk_pixel           ),
   .clk_mii          (clk_mii             ),
   .mig_ui_clk       (mig_ui_clk          ),
   .mig_ui_rst       (mig_ui_rst          ),

   // Simple UART interface
   .rxd              (rxd                 ),
   .txd              (txd                 ),
   .rts              (rts                 ),
   .cts              (cts                 ),

   // 4-bit full SD interface
   .sd_sclk          (sd_sclk             ),
   .sd_detect        (sd_detect           ),
   .sd_dat           (sd_dat              ),
   .sd_cmd           (sd_cmd              ),
   .sd_reset         (sd_reset            ),

   // LED and DIP switch
   .o_led            (o_led               ),
   .i_dip            (i_dip               ),
   // push button array
   .GPIO_SW_C        (GPIO_SW_C           ),
   .GPIO_SW_W        (GPIO_SW_W           ),
   .GPIO_SW_E        (GPIO_SW_E           ),
   .GPIO_SW_N        (GPIO_SW_N           ),
   .GPIO_SW_S        (GPIO_SW_S           ),
   //keyboard
   .PS2_CLK          (PS2_CLK             ),
   .PS2_DATA         (PS2_DATA            ),
   //! Ethernet MAC PHY interface signals
   .i_erx_dv         (i_erx_dv            ),
   .i_erx_er         (i_erx_er            ),
   .i_emdint         (i_emdint            ),
   .o_erefclk        (o_erefclk           ),
   .o_etx_en         (o_etx_en            ),
   //KC705   
   .i_erxd           (i_erxd              ),
   .o_etxd           (o_etxd              ),
   .o_etx_er         (o_etx_er            ),
   .i_gmiiclk_p      (i_gmiiclk_p         ),
   .i_gmiiclk_n      (i_gmiiclk_n         ),
   .i_erx_clk        (i_erx_clk           ),
   .i_etx_clk        (i_etx_clk           ),
   .o_emdc           (o_emdc              ),
   .io_emdio         (io_emdio            ),
   .o_erstn          (o_erstn             ),

   //above port --> Existing external interface

   //below port --> Fixed interface

   .mig_s_axi_awid      (mig_s_axi_awid),
   .mig_s_axi_awaddr    (mig_s_axi_awaddr),
   .mig_s_axi_awlen     (mig_s_axi_awlen),
   .mig_s_axi_awsize    (mig_s_axi_awsize),
   .mig_s_axi_awburst   (mig_s_axi_awburst),
   .mig_s_axi_awlock    (mig_s_axi_awlock),
   .mig_s_axi_awcache   (mig_s_axi_awcache),
   .mig_s_axi_awprot    (mig_s_axi_awprot),
   .mig_s_axi_awqos     (mig_s_axi_awqos),
   .mig_s_axi_awvalid   (mig_s_axi_awvalid),
   .mig_s_axi_awready   (mig_s_axi_awready),
   .mig_s_axi_wdata     (mig_s_axi_wdata),
   .mig_s_axi_wstrb     (mig_s_axi_wstrb),
   .mig_s_axi_wlast     (mig_s_axi_wlast),
   .mig_s_axi_wvalid    (mig_s_axi_wvalid),
   .mig_s_axi_wready    (mig_s_axi_wready),
   .mig_s_axi_bid       (mig_s_axi_bid),
   .mig_s_axi_bresp     (mig_s_axi_bresp),
   .mig_s_axi_bvalid    (mig_s_axi_bvalid),
   .mig_s_axi_bready    (mig_s_axi_bready),
   .mig_s_axi_arid      (mig_s_axi_arid),
   .mig_s_axi_araddr    (mig_s_axi_araddr),
   .mig_s_axi_arlen     (mig_s_axi_arlen),
   .mig_s_axi_arsize    (mig_s_axi_arsize),
   .mig_s_axi_arburst   (mig_s_axi_arburst),
   .mig_s_axi_arlock    (mig_s_axi_arlock),
   .mig_s_axi_arcache   (mig_s_axi_arcache),
   .mig_s_axi_arprot    (mig_s_axi_arprot),
   .mig_s_axi_arqos     (mig_s_axi_arqos),
   .mig_s_axi_arvalid   (mig_s_axi_arvalid),
   .mig_s_axi_arready   (mig_s_axi_arready),
   .mig_s_axi_rid       (mig_s_axi_rid),
   .mig_s_axi_rdata     (mig_s_axi_rdata),
   .mig_s_axi_rresp     (mig_s_axi_rresp),
   .mig_s_axi_rlast     (mig_s_axi_rlast),
   .mig_s_axi_rvalid    (mig_s_axi_rvalid),
   .mig_s_axi_rready    (mig_s_axi_rready),

//external interface

   .sd_clk_o            (wiz1_clk_sdclk   ), //from clk_wiz1
   .sd_clk_daddr        (wiz1_daddr       ),
   .sd_clk_den          (wiz1_den         ),
   .sd_clk_din          (wiz1_din         ),
   .sd_clk_dout         (wiz1_dout        ),
   .sd_clk_drdy         (wiz1_drdy        ),
   .sd_clk_dwe          (wiz1_dwe         ),
   .clk_wiz1_rst        (wiz1_reset       ),
   .sd_clk_locked       (wiz1_locked      )
);


endmodule // chip_top
