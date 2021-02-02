// See LICENSE for license details.

`include "consts.vh"
`include "config.vh"

// Allow ISA regression test to use proper FPGA configuration

module chip_top_mmio_port
  (
   //clock related

   input wire         rstn,           //from mig
   input wire         clk,            //from wiz_0  
   input wire         clk_locked_wiz, //from wiz_0
   input wire         rst_top,        //from external
   input wire         mig_sys_clk,    //from wiz_0
   input wire         clk_pixel,      //from wiz_0
   input wire         clk_mii,        //from wiz_0
   // input wire         mig_ui_clk,     //from mig
   // input wire         mig_ui_rst,     //from mig

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
	input wire         i_erx_dv, 		// PHY data valid
	input wire         i_erx_er, 		// PHY coding error
	input wire         i_emdint, 		// PHY interrupt in active low
	output reg         o_erefclk, 		// RMII clock out
	output reg         o_etx_en, 		// RMII transmit enable
	//KC705   
	input wire [3:0]   i_erxd, 			// RMII receive data
	output reg [7:0]   o_etxd, 			// RMII transmit data
	output reg         o_etx_er, 		// RMII transmit enable
	input wire         i_gmiiclk_p,
	input wire         i_gmiiclk_n,
	input wire         i_erx_clk,
	input wire         i_etx_clk,
	output wire        o_emdc, 			// MDIO clock
	inout wire         io_emdio, 		// MDIO inout
	output wire        o_erstn, 		// PHY reset active low

   //above port --> Existing external interface

   //below port --> Fixed interface

   
   //=============================
   // rocket chip <=> clock conv
   //=============================
   
   input  wire        mem_m_axi4_0_aw_ready 			  ,
   output wire        mem_m_axi4_0_aw_valid             ,
   output wire [3:0]  mem_m_axi4_0_aw_bits_id           ,
   output wire [31:0] mem_m_axi4_0_aw_bits_addr         ,
   output wire [7:0]  mem_m_axi4_0_aw_bits_len          ,
   output wire [2:0]  mem_m_axi4_0_aw_bits_size         ,
   output wire [1:0]  mem_m_axi4_0_aw_bits_burst        ,
   output wire [3:0]  mem_m_axi4_0_aw_bits_cache        ,
   output wire [2:0]  mem_m_axi4_0_aw_bits_prot         ,
   output wire [3:0]  mem_m_axi4_0_aw_bits_qos          ,
   input  wire        mem_m_axi4_0_w_ready              ,
   output wire        mem_m_axi4_0_w_valid              ,
   output wire [63:0] mem_m_axi4_0_w_bits_data          ,
   output wire [7:0]  mem_m_axi4_0_w_bits_strb          ,
   output wire        mem_m_axi4_0_w_bits_last          ,
   output wire        mem_m_axi4_0_b_ready              ,
   input  wire        mem_m_axi4_0_b_valid              ,
   input  wire [3:0]  mem_m_axi4_0_b_bits_id            ,
   input  wire [1:0]  mem_m_axi4_0_b_bits_resp          ,
   input  wire        mem_m_axi4_0_ar_ready             ,
   output wire        mem_m_axi4_0_ar_valid             ,
   output wire [3:0]  mem_m_axi4_0_ar_bits_id           ,
   output wire [31:0] mem_m_axi4_0_ar_bits_addr         ,
   output wire [7:0]  mem_m_axi4_0_ar_bits_len          ,
   output wire [2:0]  mem_m_axi4_0_ar_bits_size         ,
   output wire [1:0]  mem_m_axi4_0_ar_bits_burst        ,
   output wire [3:0]  mem_m_axi4_0_ar_bits_cache        ,
   output wire [2:0]  mem_m_axi4_0_ar_bits_prot         ,
   output wire [3:0]  mem_m_axi4_0_ar_bits_qos          ,
   output wire        mem_m_axi4_0_r_ready              ,
   input  wire        mem_m_axi4_0_r_valid              ,
   input  wire [3:0]  mem_m_axi4_0_r_bits_id            ,
   input  wire [63:0] mem_m_axi4_0_r_bits_data          ,
   input  wire [1:0]  mem_m_axi4_0_r_bits_resp          ,
   input  wire        mem_m_axi4_0_r_bits_last          ,

//   output        mem_m_axi4_0_aw_bits_lock         ,
//   output        mem_m_axi4_0_ar_bits_lock         ,


  //========================================
  //  rocket_chip <=> axi interconnect(VTA)
  //========================================
  
//mmio port
  input  wire        mmio_master_nasti_aw_ready, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_master_nasti_aw_valid, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [3:0]  mmio_master_nasti_aw_bits_id, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [30:0] mmio_master_nasti_aw_bits_addr, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [7:0]  mmio_master_nasti_aw_bits_len, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [2:0]  mmio_master_nasti_aw_bits_size, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [1:0]  mmio_master_nasti_aw_bits_burst, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_master_nasti_aw_bits_lock, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [3:0]  mmio_master_nasti_aw_bits_cache, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [2:0]  mmio_master_nasti_aw_bits_prot, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [3:0]  mmio_master_nasti_aw_bits_qos, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire        mmio_master_nasti_w_ready, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_master_nasti_w_valid, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [63:0] mmio_master_nasti_w_bits_data, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [7:0]  mmio_master_nasti_w_bits_strb, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_master_nasti_w_bits_last, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_master_nasti_b_ready, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire        mmio_master_nasti_b_valid, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire [3:0]  mmio_master_nasti_b_bits_id, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire [1:0]  mmio_master_nasti_b_bits_resp, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire        mmio_master_nasti_ar_ready, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_master_nasti_ar_valid, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [3:0]  mmio_master_nasti_ar_bits_id, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [30:0] mmio_master_nasti_ar_bits_addr, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [7:0]  mmio_master_nasti_ar_bits_len, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [2:0]  mmio_master_nasti_ar_bits_size, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [1:0]  mmio_master_nasti_ar_bits_burst, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_master_nasti_ar_bits_lock, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [3:0]  mmio_master_nasti_ar_bits_cache, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [2:0]  mmio_master_nasti_ar_bits_prot, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [3:0]  mmio_master_nasti_ar_bits_qos, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_master_nasti_r_ready, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire        mmio_master_nasti_r_valid, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire [3:0]  mmio_master_nasti_r_bits_id, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire [63:0] mmio_master_nasti_r_bits_data, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire [1:0]  mmio_master_nasti_r_bits_resp, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire        mmio_master_nasti_r_bits_last, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
 
 



//external interface

   input  wire         sd_clk_o,
   output wire [6:0]   sd_clk_daddr,
   output wire         sd_clk_den,
   output wire [15:0]  sd_clk_din,
   input  wire [15:0]  sd_clk_dout,
   input  wire         sd_clk_drdy,
   output wire         sd_clk_dwe,
   output wire         clk_wiz1_rst,
   input  wire         sd_clk_locked

);
	
logic  sys_rst;
assign sys_rst = ~rstn;

//logic mig_ui_rstn;
//assign mig_ui_rstn = !mig_ui_rst;

// NASTI/Lite on-chip interconnects

`define MEM_NASTI mem_nasti
// Rocket memory nasti bus
nasti_channel
   #(
   .ID_WIDTH    ( `MEM_ID_WIDTH   ),
   .ADDR_WIDTH  ( `MEM_ADDR_WIDTH ),
   .DATA_WIDTH  ( `MEM_DATA_WIDTH ))
mem_nasti();

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

//ADD_BRAM

localparam BRAM_SIZE          = 16;        // 2^16 -> 64 KB
localparam BRAM_WIDTH         = 128;       // always 128-bit wide
localparam BRAM_LINE          = 2 ** BRAM_SIZE / (BRAM_WIDTH/8);
localparam BRAM_OFFSET_BITS   = $clog2(`LOWRISC_IO_DAT_WIDTH/8);
localparam BRAM_ADDR_LSB_BITS = $clog2(BRAM_WIDTH / `LOWRISC_IO_DAT_WIDTH);
localparam BRAM_ADDR_BLK_BITS = BRAM_SIZE - BRAM_ADDR_LSB_BITS - BRAM_OFFSET_BITS;

initial assert (BRAM_OFFSET_BITS < 7) else $fatal(1, "Do not support BRAM AXI width > 64-bit!");

logic          ram_clk, ram_rst, ram_en;
logic [7:0]    ram_we;
logic [15:0]   ram_addr;
logic [63:0]   ram_wrdata, ram_rddata;

logic [30:0] bram_ar_addr, bram_aw_addr;

assign bram_ar_addr = mmio_master_nasti.ar_addr ;
assign bram_aw_addr = mmio_master_nasti.aw_addr ;
//assign bram_ar_addr = Inter_to_Bram_axi_araddr ;
//assign bram_aw_addr = Inter_to_Bram_axi_awaddr ;
   
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

always @(posedge ram_clk)begin
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


//useless port
wire                        hid_rst, hid_clk, hid_en;
wire [7:0]                  hid_we;
wire [17:0]                 hid_addr;
wire [63:0]                 hid_wrdata,  hid_rddata;
logic [30:0]                hid_ar_addr, hid_aw_addr;


/////////////////////////////////////////////////////////////
///// BRAM ctrl
/////////////////////////////////////////////////////////////

axi_bram_ctrl_dummy BramCtl
     (
      .s_axi_aclk      ( clk                        ),
      .s_axi_aresetn   ( rstn                       ),
      .s_axi_araddr    ( mmio_master_nasti.ar_id    ),
      .s_axi_awaddr    ( bram_ar_addr[17:0]         ),
      .s_axi_arid      ( mmio_master_nasti.ar_len   ),
      .s_axi_arlen     ( mmio_master_nasti.ar_size  ),
      .s_axi_arsize    ( mmio_master_nasti.ar_burst ),
      .s_axi_arburst   ( mmio_master_nasti.ar_lock  ),
      .s_axi_arlock    ( mmio_master_nasti.ar_cache ),
      .s_axi_arcache   ( mmio_master_nasti.ar_prot  ),
      .s_axi_arprot    ( mmio_master_nasti.ar_ready ),
      .s_axi_arready   ( mmio_master_nasti.ar_valid ),
      .s_axi_arvalid   ( mmio_master_nasti.r_id     ),
      .s_axi_rid       ( mmio_master_nasti.r_data   ),
      .s_axi_rdata     ( mmio_master_nasti.r_resp   ),
      .s_axi_rresp     ( mmio_master_nasti.r_last   ),
      .s_axi_rlast     ( mmio_master_nasti.r_ready  ),
      .s_axi_rready    ( mmio_master_nasti.r_valid  ),
      .s_axi_rvalid    ( mmio_master_nasti.aw_id    ),
      .s_axi_awid      ( bram_aw_addr[17:0]         ),
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
      .bram_rst_a      ( hid_rst                    ), 
      .bram_clk_a      ( hid_clk                    ), 
      .bram_en_a       ( hid_en                     ), 
      .bram_we_a       ( hid_we                     ), 
      .bram_addr_a     ( hid_addr                   ), 
      .bram_wrdata_a   ( hid_wrdata                 ), 
      .bram_rddata_a   ( hid_rddata                 )  
      );


/////////////////////////////////////////////////////////////
///// psoc 
/////////////////////////////////////////////////////////////


logic spi_irq, sd_irq, eth_irq, uart_irq;

assign spi_irq = 1'b0;

logic [7:0] unused_led;

wire clk_locked;
assign clk_locked = clk_locked_wiz & !rst_top; //external

logic eth_rstn, eth_refclk, eth_txen, eth_txer, eth_rxerr;
logic [3:0]  eth_rxd;
assign o_erstn = eth_rstn & clk_locked_wiz;

wire io_emdio_i, phy_emdio_o, phy_emdio_t;
reg phy_emdio_i, io_emdio_o, io_emdio_t;

//KC705    
always @(posedge i_etx_clk) begin
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


always @(posedge i_erx_clk) begin
   eth_rxd   = i_erxd;
   eth_rxerr = i_erx_er;         
end
   
logic [3:0] eth_txd;

always @(posedge i_etx_clk) begin
   o_etxd   <= eth_txd;
   o_etx_en <= eth_txen;
   o_etx_er <= eth_txer;
end

  wire sd_clk_rst;

   periph_soc_mod #(.UBAUD_DEFAULT(108)) psoc
     (
      .msoc_clk   ( clk                ), //external
      .sd_sclk    ( sd_sclk            ), //external
      .sd_detect  ( sd_detect          ), //external
      .sd_dat     ( sd_dat             ), //external
      .sd_cmd     ( sd_cmd             ), //external
      .sd_irq     ( sd_irq             ), //internal
      .sd_reset   ( sd_reset           ),
   //KC705
      .from_dip   ( {12'b0,i_dip}      ), //external
      .to_led     ( {unused_led,o_led} ), //external
      .rstn       ( clk_locked         ), //internal
      .clk_200MHz ( mig_sys_clk        ), //wiz0
      .pxl_clk    ( clk_pixel          ), //wiz0
      .uart_rx    ( rxd                ), //external
      .uart_tx    ( txd                ), //external
      .uart_irq   ( uart_irq           ),
   //KC705   
      .i_erx_clk  ( i_erx_clk          ), //external
      .i_etx_clk  ( i_etx_clk          ), //external 
      .clk_mii    ( clk_mii            ), //wiz0
      .locked     ( clk_locked         ), //internal
    // SMSC ethernet PHY connections
      .eth_rstn   ( eth_rstn           ), 
      .eth_crsdv  ( i_erx_dv           ), 
      .eth_refclk ( eth_refclk         ), 
      .eth_txd    ( eth_txd            ), 
      .eth_txen   ( eth_txen           ), 
      .eth_txer   ( eth_txer           ), 
      .eth_rxd    ( eth_rxd            ),
      .eth_rxerr  ( eth_rxerr          ),
      .eth_mdc    ( o_emdc             ), //external
      .phy_mdio_i ( phy_emdio_i        ),
      .phy_mdio_o ( phy_emdio_o        ),
      .phy_mdio_t ( phy_emdio_t        ),
      .eth_irq    ( eth_irq            ),

      .ram_clk    ( ram_clk            ),
      .ram_rst    ( ram_rst            ),
      .ram_en     ( ram_en             ),
      .ram_we     ( ram_we             ),
      .ram_addr   ( ram_addr           ),
      .ram_wrdata ( ram_wrdata         ),
      .ram_rddata ( ram_rddata         ),

      .hid_en     (hid_en              ),
      .hid_we     (hid_we              ),
      .hid_addr   (hid_addr            ),
      .hid_wrdata (hid_wrdata          ),
      .hid_rddata (hid_rddata          ),


      //keyboard
      .PS2_CLK     (PS2_CLK            ),
      .PS2_DATA    (PS2_DATA           ),

      // pusb button array
      .GPIO_SW_C   (GPIO_SW_C          ),
      .GPIO_SW_W   (GPIO_SW_W          ),
      .GPIO_SW_E   (GPIO_SW_E          ),
      .GPIO_SW_N   (GPIO_SW_N          ),
      .GPIO_SW_S   (GPIO_SW_S          ),

      .sd_clk_o     (sd_clk_o          ),
      .sd_clk_daddr (sd_clk_daddr      ),
      .sd_clk_den   (sd_clk_den        ),
      .sd_clk_din   (sd_clk_din        ),
      .sd_clk_dout  (sd_clk_dout       ),
      .sd_clk_drdy  (sd_clk_drdy       ),
      .sd_clk_dwe   (sd_clk_dwe        ),
      .sd_clk_rst   (sd_clk_rst        ),
      .sd_clk_locked (sd_clk_locked    )
);

   assign rts = cts;
   // assign clk_wiz1_rst = (sd_clk_rst&rstn);
   assign clk_wiz1_rst = ~(sd_clk_rst&rstn);
   // assign clk_wiz1_rstn = ~(sd_clk_rst&rstn);


///psoc end
/////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////
///// rocket chip
/////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////
// Host for ISA regression
nasti_channel
   #(
   .ADDR_WIDTH  ( `MMIO_MASTER_ADDR_WIDTH   ),
   .DATA_WIDTH  ( `LOWRISC_IO_DAT_WIDTH     ))
io_host_lite();
//would be not used
/////////////////////////////////////////////////////////////

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
      .debug_systemjtag_jtag_TCK                (TCK),
      .debug_systemjtag_jtag_TMS                (TMS),
      .debug_systemjtag_jtag_TDI                (TDI),
      .debug_systemjtag_jtag_TDO_data           (TDO),
      .debug_systemjtag_jtag_TDO_driven         (TDO_driven),
      .debug_systemjtag_reset                   (RESET),
      .debug_systemjtag_mfr_id                  (11'h5AA),
      .debug_ndreset                            (ExampleRocketSystem_debug_ndreset),
      .debug_dmactive                           (ExampleRocketSystem_debug_dmactive),
      .mem_axi4_0_aw_valid                      ( `MEM_NASTI.aw_valid                     ),
      .mem_axi4_0_aw_ready                      ( `MEM_NASTI.aw_ready                     ),
      .mem_axi4_0_aw_bits_id                    ( `MEM_NASTI.aw_id                        ),
      .mem_axi4_0_aw_bits_addr                  ( `MEM_NASTI.aw_addr                      ),
      .mem_axi4_0_aw_bits_len                   ( `MEM_NASTI.aw_len                       ),
      .mem_axi4_0_aw_bits_size                  ( `MEM_NASTI.aw_size                      ),
      .mem_axi4_0_aw_bits_burst                 ( `MEM_NASTI.aw_burst                     ),
      .mem_axi4_0_aw_bits_lock                  ( `MEM_NASTI.aw_lock                      ),
      .mem_axi4_0_aw_bits_cache                 ( `MEM_NASTI.aw_cache                     ),
      .mem_axi4_0_aw_bits_prot                  ( `MEM_NASTI.aw_prot                      ),
      .mem_axi4_0_aw_bits_qos                   ( `MEM_NASTI.aw_qos                       ),
      .mem_axi4_0_w_valid                       ( `MEM_NASTI.w_valid                      ),
      .mem_axi4_0_w_ready                       ( `MEM_NASTI.w_ready                      ),
      .mem_axi4_0_w_bits_data                   ( `MEM_NASTI.w_data                       ),
      .mem_axi4_0_w_bits_strb                   ( `MEM_NASTI.w_strb                       ),
      .mem_axi4_0_w_bits_last                   ( `MEM_NASTI.w_last                       ),
      .mem_axi4_0_b_valid                       ( `MEM_NASTI.b_valid                      ),
      .mem_axi4_0_b_ready                       ( `MEM_NASTI.b_ready                      ),
      .mem_axi4_0_b_bits_id                     ( `MEM_NASTI.b_id                         ),
      .mem_axi4_0_b_bits_resp                   ( `MEM_NASTI.b_resp                       ),
      .mem_axi4_0_ar_valid                      ( `MEM_NASTI.ar_valid                     ),
      .mem_axi4_0_ar_ready                      ( `MEM_NASTI.ar_ready                     ),
      .mem_axi4_0_ar_bits_id                    ( `MEM_NASTI.ar_id                        ),
      .mem_axi4_0_ar_bits_addr                  ( `MEM_NASTI.ar_addr                      ),
      .mem_axi4_0_ar_bits_len                   ( `MEM_NASTI.ar_len                       ),
      .mem_axi4_0_ar_bits_size                  ( `MEM_NASTI.ar_size                      ),
      .mem_axi4_0_ar_bits_burst                 ( `MEM_NASTI.ar_burst                     ),
      .mem_axi4_0_ar_bits_lock                  ( `MEM_NASTI.ar_lock                      ),
      .mem_axi4_0_ar_bits_cache                 ( `MEM_NASTI.ar_cache                     ),
      .mem_axi4_0_ar_bits_prot                  ( `MEM_NASTI.ar_prot                      ),
      .mem_axi4_0_ar_bits_qos                   ( `MEM_NASTI.ar_qos                       ),
      .mem_axi4_0_r_valid                       ( `MEM_NASTI.r_valid                      ),
      .mem_axi4_0_r_ready                       ( `MEM_NASTI.r_ready                      ),
      .mem_axi4_0_r_bits_id                     ( `MEM_NASTI.r_id                         ),
      .mem_axi4_0_r_bits_data                   ( `MEM_NASTI.r_data                       ),
      .mem_axi4_0_r_bits_resp                   ( `MEM_NASTI.r_resp                       ),
      .mem_axi4_0_r_bits_last                   ( `MEM_NASTI.r_last                       ),
      .mmio_axi4_0_aw_valid                     ( mmio_master_nasti.aw_valid               ),
      .mmio_axi4_0_aw_ready                     ( mmio_master_nasti.aw_ready               ),
      .mmio_axi4_0_aw_bits_id                   ( mmio_master_nasti.aw_id                  ),
      .mmio_axi4_0_aw_bits_addr                 ( mmio_master_nasti.aw_addr                ),
      .mmio_axi4_0_aw_bits_len                  ( mmio_master_nasti.aw_len                 ),
      .mmio_axi4_0_aw_bits_size                 ( mmio_master_nasti.aw_size                ),
      .mmio_axi4_0_aw_bits_burst                ( mmio_master_nasti.aw_burst               ),
      .mmio_axi4_0_aw_bits_lock                 ( mmio_master_nasti.aw_lock                ),
      .mmio_axi4_0_aw_bits_cache                ( mmio_master_nasti.aw_cache               ),
      .mmio_axi4_0_aw_bits_prot                 ( mmio_master_nasti.aw_prot                ),
      .mmio_axi4_0_aw_bits_qos                  ( mmio_master_nasti.aw_qos                 ),
      .mmio_axi4_0_w_valid                      ( mmio_master_nasti.w_valid                ),
      .mmio_axi4_0_w_ready                      ( mmio_master_nasti.w_ready                ),
      .mmio_axi4_0_w_bits_data                  ( mmio_master_nasti.w_data                 ),
      .mmio_axi4_0_w_bits_strb                  ( mmio_master_nasti.w_strb                 ),
      .mmio_axi4_0_w_bits_last                  ( mmio_master_nasti.w_last                 ),
      .mmio_axi4_0_b_valid                      ( mmio_master_nasti.b_valid                ),
      .mmio_axi4_0_b_ready                      ( mmio_master_nasti.b_ready                ),
      .mmio_axi4_0_b_bits_id                    ( mmio_master_nasti.b_id                   ),
      .mmio_axi4_0_b_bits_resp                  ( mmio_master_nasti.b_resp                 ),
      .mmio_axi4_0_ar_valid                     ( mmio_master_nasti.ar_valid               ),
      .mmio_axi4_0_ar_ready                     ( mmio_master_nasti.ar_ready               ),
      .mmio_axi4_0_ar_bits_id                   ( mmio_master_nasti.ar_id                  ),
      .mmio_axi4_0_ar_bits_addr                 ( mmio_master_nasti.ar_addr                ),
      .mmio_axi4_0_ar_bits_len                  ( mmio_master_nasti.ar_len                 ),
      .mmio_axi4_0_ar_bits_size                 ( mmio_master_nasti.ar_size                ),
      .mmio_axi4_0_ar_bits_burst                ( mmio_master_nasti.ar_burst               ),
      .mmio_axi4_0_ar_bits_lock                 ( mmio_master_nasti.ar_lock                ),
      .mmio_axi4_0_ar_bits_cache                ( mmio_master_nasti.ar_cache               ),
      .mmio_axi4_0_ar_bits_prot                 ( mmio_master_nasti.ar_prot                ),
      .mmio_axi4_0_ar_bits_qos                  ( mmio_master_nasti.ar_qos                 ),
      .mmio_axi4_0_r_valid                      ( mmio_master_nasti.r_valid                ),
      .mmio_axi4_0_r_ready                      ( mmio_master_nasti.r_ready                ),
      .mmio_axi4_0_r_bits_id                    ( mmio_master_nasti.r_id                   ),
      .mmio_axi4_0_r_bits_data                  ( mmio_master_nasti.r_data                 ),
      .mmio_axi4_0_r_bits_resp                  ( mmio_master_nasti.r_resp                 ),
      .mmio_axi4_0_r_bits_last                  ( mmio_master_nasti.r_last                 ),
      .l2_frontend_bus_axi4_0_aw_valid          ( io_slave_nasti.aw_valid                ),
      .l2_frontend_bus_axi4_0_aw_ready          ( io_slave_nasti.aw_ready                ),
      .l2_frontend_bus_axi4_0_aw_bits_id        ( io_slave_nasti.aw_id                   ),
      .l2_frontend_bus_axi4_0_aw_bits_addr      ( io_slave_nasti.aw_addr                 ),
      .l2_frontend_bus_axi4_0_aw_bits_len       ( io_slave_nasti.aw_len                  ),
      .l2_frontend_bus_axi4_0_aw_bits_size      ( io_slave_nasti.aw_size                 ),
      .l2_frontend_bus_axi4_0_aw_bits_burst     ( io_slave_nasti.aw_burst                ),
      .l2_frontend_bus_axi4_0_aw_bits_lock      ( io_slave_nasti.aw_lock                 ),
      .l2_frontend_bus_axi4_0_aw_bits_cache     ( io_slave_nasti.aw_cache                ),
      .l2_frontend_bus_axi4_0_aw_bits_prot      ( io_slave_nasti.aw_prot                 ),
      .l2_frontend_bus_axi4_0_aw_bits_qos       ( io_slave_nasti.aw_qos                  ),
      .l2_frontend_bus_axi4_0_w_valid           ( io_slave_nasti.w_valid                 ),
      .l2_frontend_bus_axi4_0_w_ready           ( io_slave_nasti.w_ready                 ),
      .l2_frontend_bus_axi4_0_w_bits_data       ( io_slave_nasti.w_data                  ),
      .l2_frontend_bus_axi4_0_w_bits_strb       ( io_slave_nasti.w_strb                  ),
      .l2_frontend_bus_axi4_0_w_bits_last       ( io_slave_nasti.w_last                  ),
      .l2_frontend_bus_axi4_0_b_valid           ( io_slave_nasti.b_valid                 ),
      .l2_frontend_bus_axi4_0_b_ready           ( io_slave_nasti.b_ready                 ),
      .l2_frontend_bus_axi4_0_b_bits_id         ( io_slave_nasti.b_id                    ),
      .l2_frontend_bus_axi4_0_b_bits_resp       ( io_slave_nasti.b_resp                  ),
      .l2_frontend_bus_axi4_0_ar_valid          ( io_slave_nasti.ar_valid                ),
      .l2_frontend_bus_axi4_0_ar_ready          ( io_slave_nasti.ar_ready                ),
      .l2_frontend_bus_axi4_0_ar_bits_id        ( io_slave_nasti.ar_id                   ),
      .l2_frontend_bus_axi4_0_ar_bits_addr      ( io_slave_nasti.ar_addr                 ),
      .l2_frontend_bus_axi4_0_ar_bits_len       ( io_slave_nasti.ar_len                  ),
      .l2_frontend_bus_axi4_0_ar_bits_size      ( io_slave_nasti.ar_size                 ),
      .l2_frontend_bus_axi4_0_ar_bits_burst     ( io_slave_nasti.ar_burst                ),
      .l2_frontend_bus_axi4_0_ar_bits_lock      ( io_slave_nasti.ar_lock                 ),
      .l2_frontend_bus_axi4_0_ar_bits_cache     ( io_slave_nasti.ar_cache                ),
      .l2_frontend_bus_axi4_0_ar_bits_prot      ( io_slave_nasti.ar_prot                 ),
      .l2_frontend_bus_axi4_0_ar_bits_qos       ( io_slave_nasti.ar_qos                  ),
      .l2_frontend_bus_axi4_0_r_valid           ( io_slave_nasti.r_valid                 ),
      .l2_frontend_bus_axi4_0_r_ready           ( io_slave_nasti.r_ready                 ),
      .l2_frontend_bus_axi4_0_r_bits_id         ( io_slave_nasti.r_id                    ),
      .l2_frontend_bus_axi4_0_r_bits_data       ( io_slave_nasti.r_data                  ),
      .l2_frontend_bus_axi4_0_r_bits_resp       ( io_slave_nasti.r_resp                  ),
      .l2_frontend_bus_axi4_0_r_bits_last       ( io_slave_nasti.r_last                  ),
      .interrupts                               ( {sd_irq, eth_irq, spi_irq, uart_irq}   ), //from psoc
      .io_reset_vector                          ( io_reset_vector                        ),
      .clock                                    ( clk                                    ), //external
      .reset                                    ( sys_rst                                )  //external
      );



assign mem_m_axi4_0_aw_valid            =		 `MEM_NASTI.aw_valid     ;                
assign mem_m_axi4_0_aw_ready            =		 `MEM_NASTI.aw_ready     ;                
assign mem_m_axi4_0_aw_bits_id          =		 `MEM_NASTI.aw_id        ;                
assign mem_m_axi4_0_aw_bits_addr        =		 `MEM_NASTI.aw_addr      ;                
assign mem_m_axi4_0_aw_bits_len         =		 `MEM_NASTI.aw_len       ;                
assign mem_m_axi4_0_aw_bits_size        =		 `MEM_NASTI.aw_size      ;                
assign mem_m_axi4_0_aw_bits_burst       =		 `MEM_NASTI.aw_burst     ;   
assign mem_m_axi4_0_aw_bits_cache       =		 `MEM_NASTI.aw_cache     ;                
assign mem_m_axi4_0_aw_bits_prot        =		 `MEM_NASTI.aw_prot      ;                
assign mem_m_axi4_0_aw_bits_qos         =		 `MEM_NASTI.aw_qos       ;                
assign mem_m_axi4_0_w_valid             =		 `MEM_NASTI.w_valid      ;                
assign mem_m_axi4_0_w_ready             =		 `MEM_NASTI.w_ready      ;                
assign mem_m_axi4_0_w_bits_data         =		 `MEM_NASTI.w_data       ;                
assign mem_m_axi4_0_w_bits_strb         =		 `MEM_NASTI.w_strb       ;                
assign mem_m_axi4_0_w_bits_last         =		 `MEM_NASTI.w_last       ;                
assign mem_m_axi4_0_b_valid             =		 `MEM_NASTI.b_valid      ;                
assign mem_m_axi4_0_b_ready             =		 `MEM_NASTI.b_ready      ;                
assign mem_m_axi4_0_b_bits_id           =		 `MEM_NASTI.b_id         ;                
assign mem_m_axi4_0_b_bits_resp         =		 `MEM_NASTI.b_resp       ;                
assign mem_m_axi4_0_ar_valid            =		 `MEM_NASTI.ar_valid     ;                
assign mem_m_axi4_0_ar_ready            =		 `MEM_NASTI.ar_ready     ;                
assign mem_m_axi4_0_ar_bits_id          =		 `MEM_NASTI.ar_id        ;                
assign mem_m_axi4_0_ar_bits_addr        =		 `MEM_NASTI.ar_addr      ;                
assign mem_m_axi4_0_ar_bits_len         =		 `MEM_NASTI.ar_len       ;                
assign mem_m_axi4_0_ar_bits_size        =		 `MEM_NASTI.ar_size      ;                
assign mem_m_axi4_0_ar_bits_burst       =		 `MEM_NASTI.ar_burst     ;                
assign mem_m_axi4_0_ar_bits_cache       =		 `MEM_NASTI.ar_cache     ;                
assign mem_m_axi4_0_ar_bits_prot        =		 `MEM_NASTI.ar_prot      ;                
assign mem_m_axi4_0_ar_bits_qos         =		 `MEM_NASTI.ar_qos       ;                
assign mem_m_axi4_0_r_valid             =		 `MEM_NASTI.r_valid      ;                
assign mem_m_axi4_0_r_ready             =		 `MEM_NASTI.r_ready      ;                
assign mem_m_axi4_0_r_bits_id           =		 `MEM_NASTI.r_id         ;                
assign mem_m_axi4_0_r_bits_data         =		 `MEM_NASTI.r_data       ;                
assign mem_m_axi4_0_r_bits_resp         =		 `MEM_NASTI.r_resp       ;                
assign mem_m_axi4_0_r_bits_last         =		 `MEM_NASTI.r_last       ;

//assign mem_m_axi4_0_aw_bits_lock        =		 `MEM_NASTI.aw_lock      ;                
//assign mem_m_axi4_0_ar_bits_lock        =		 `MEM_NASTI.ar_lock      ;                


assign mmio_master_nasti_aw_valid  		=		mmio_master_nasti.aw_valid  ;
assign mmio_master_nasti_aw_ready       =		mmio_master_nasti.aw_ready  ;
assign mmio_master_nasti_aw_id          =		mmio_master_nasti.aw_id     ;
assign mmio_master_nasti_aw_addr        =		mmio_master_nasti.aw_addr   ;
assign mmio_master_nasti_aw_len         =		mmio_master_nasti.aw_len    ;
assign mmio_master_nasti_aw_size        =		mmio_master_nasti.aw_size   ;
assign mmio_master_nasti_aw_burst       =		mmio_master_nasti.aw_burst  ;
assign mmio_master_nasti_aw_lock        =		mmio_master_nasti.aw_lock   ;
assign mmio_master_nasti_aw_cache       =		mmio_master_nasti.aw_cache  ;
assign mmio_master_nasti_aw_prot        =		mmio_master_nasti.aw_prot   ;
assign mmio_master_nasti_aw_qos         =		mmio_master_nasti.aw_qos    ;
assign mmio_master_nasti_w_valid        =		mmio_master_nasti.w_valid   ;
assign mmio_master_nasti_w_ready        =		mmio_master_nasti.w_ready   ;
assign mmio_master_nasti_w_data         =		mmio_master_nasti.w_data    ;
assign mmio_master_nasti_w_strb         =		mmio_master_nasti.w_strb    ;
assign mmio_master_nasti_w_last         =		mmio_master_nasti.w_last    ;
assign mmio_master_nasti_b_valid        =		mmio_master_nasti.b_valid   ;
assign mmio_master_nasti_b_ready        =		mmio_master_nasti.b_ready   ;
assign mmio_master_nasti_b_id           =		mmio_master_nasti.b_id      ;
assign mmio_master_nasti_b_resp         =		mmio_master_nasti.b_resp    ;
assign mmio_master_nasti_ar_valid       =		mmio_master_nasti.ar_valid  ;
assign mmio_master_nasti_ar_ready       =		mmio_master_nasti.ar_ready  ;
assign mmio_master_nasti_ar_id          =		mmio_master_nasti.ar_id     ;
assign mmio_master_nasti_ar_addr        =		mmio_master_nasti.ar_addr   ;
assign mmio_master_nasti_ar_len         =		mmio_master_nasti.ar_len    ;
assign mmio_master_nasti_ar_size        =		mmio_master_nasti.ar_size   ;
assign mmio_master_nasti_ar_burst       =		mmio_master_nasti.ar_burst  ;
assign mmio_master_nasti_ar_lock        =		mmio_master_nasti.ar_lock   ;
assign mmio_master_nasti_ar_cache       =		mmio_master_nasti.ar_cache  ;
assign mmio_master_nasti_ar_prot        =		mmio_master_nasti.ar_prot   ;
assign mmio_master_nasti_ar_qos         =		mmio_master_nasti.ar_qos    ;
assign mmio_master_nasti_r_valid        =		mmio_master_nasti.r_valid   ;
assign mmio_master_nasti_r_ready        =		mmio_master_nasti.r_ready   ;
assign mmio_master_nasti_r_id           =		mmio_master_nasti.r_id      ;
assign mmio_master_nasti_r_data         =		mmio_master_nasti.r_data    ;
assign mmio_master_nasti_r_resp         =		mmio_master_nasti.r_resp    ;
assign mmio_master_nasti_r_last         =		mmio_master_nasti.r_last    ;











endmodule // chip_top
