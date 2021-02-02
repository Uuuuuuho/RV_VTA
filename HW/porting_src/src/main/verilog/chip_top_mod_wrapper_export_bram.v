module chip_top_mod_wrapper_export_bram
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

  input  wire        mem_m_axi_awready 			 ,
  output wire        mem_m_axi_awvalid           ,
  output wire [3:0]  mem_m_axi_awid              ,
  output wire [31:0] mem_m_axi_awaddr            ,
  output wire [7:0]  mem_m_axi_awlen             ,
  output wire [2:0]  mem_m_axi_awsize            ,
  output wire [1:0]  mem_m_axi_awburst           ,
  output wire [3:0]  mem_m_axi_awcache           ,
  output wire [2:0]  mem_m_axi_awprot            ,
  output wire [3:0]  mem_m_axi_awqos             ,
  input  wire        mem_m_axi_wready            ,
  output wire        mem_m_axi_wvalid            ,
  output wire [63:0] mem_m_axi_wdata             ,
  output wire [7:0]  mem_m_axi_wstrb             ,
  output wire        mem_m_axi_wlast             ,
  output wire        mem_m_axi_bready            ,
  input  wire        mem_m_axi_bvalid            ,
  input  wire [3:0]  mem_m_axi_bid            	 ,
  input  wire [1:0]  mem_m_axi_bresp          	 ,
  input  wire        mem_m_axi_arready           ,
  output wire        mem_m_axi_arvalid           ,
  output wire [3:0]  mem_m_axi_arid           	 ,
  output wire [31:0] mem_m_axi_araddr         	 ,
  output wire [7:0]  mem_m_axi_arlen          	 ,
  output wire [2:0]  mem_m_axi_arsize         	 ,
  output wire [1:0]  mem_m_axi_arburst        	 ,
  output wire [3:0]  mem_m_axi_arcache        	 ,
  output wire [2:0]  mem_m_axi_arprot         	 ,
  output wire [3:0]  mem_m_axi_arqos          	 ,
  output wire        mem_m_axi_rready            ,
  input  wire        mem_m_axi_rvalid            ,
  input  wire [3:0]  mem_m_axi_rid            	 ,
  input  wire [63:0] mem_m_axi_rdata          	 ,
  input  wire [1:0]  mem_m_axi_rresp          	 ,
  input  wire        mem_m_axi_rlast          	 ,

//  output        mem_m_axi_awlock       ,
//  output        mem_m_axi_arlock         	,




  //========================================
  //  rocket_chip <=> axi interconnect(VTA)
  //========================================
  
//mmio port
  input  wire        mmio_m_axi_awready, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_m_axi_awvalid, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [3:0]  mmio_m_axi_awid, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [30:0] mmio_m_axi_awaddr, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [7:0]  mmio_m_axi_awlen, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [2:0]  mmio_m_axi_awsize, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [1:0]  mmio_m_axi_awburst, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_m_axi_awlock, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [3:0]  mmio_m_axi_awcache, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [2:0]  mmio_m_axi_awprot, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [3:0]  mmio_m_axi_awqos, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire        mmio_m_axi_wready, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_m_axi_wvalid, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [63:0] mmio_m_axi_wdata, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [7:0]  mmio_m_axi_wstrb, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_m_axi_wlast, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_m_axi_bready, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire        mmio_m_axi_bvalid, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire [3:0]  mmio_m_axi_bid, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire [1:0]  mmio_m_axi_bresp, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire        mmio_m_axi_arready, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_m_axi_arvalid, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [3:0]  mmio_m_axi_arid, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [30:0] mmio_m_axi_araddr, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [7:0]  mmio_m_axi_arlen, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [2:0]  mmio_m_axi_arsize, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [1:0]  mmio_m_axi_arburst, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_m_axi_arlock, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [3:0]  mmio_m_axi_arcache, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [2:0]  mmio_m_axi_arprot, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire [3:0]  mmio_m_axi_arqos, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  output wire        mmio_m_axi_rready, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire        mmio_m_axi_rvalid, // @[:free1chipschips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire [3:0]  mmio_m_axi_rid, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire [63:0] mmio_m_axi_rdata, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire [1:0]  mmio_m_axi_rresp, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
  input  wire        mmio_m_axi_rlast, // @[:freechips.rocketchip.system.DefaultConfig.fir@157636.4]
 


  //psoc <=> Bram controller
  input  wire [17:0]	bram_addr_a     ,
  input  wire			bram_rst_a      ,
  input  wire 			bram_clk_a      ,
  input  wire       	bram_en_a       ,
  input  wire [7:0] 	bram_we_a       ,
  input  wire [63:0]	bram_wrdata_a   ,
  output wire [63:0]	bram_rddata_a   ,
 


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


//chip_top interface

chip_top_export_bram U0_CHIP_TOP_1(
   //clock related

   .rstn           (	rstn           	),			//from mig
   .clk            (	clk            	),			//from wiz_0  
   .clk_locked_wiz (	clk_locked_wiz 	),			//from wiz_0
   .rst_top        (	rst_top        	),			//from external
   .mig_sys_clk    (	mig_sys_clk    	),			//from wiz_0
   .clk_pixel      (	clk_pixel      	),			//from wiz_0
   .clk_mii        (	clk_mii        	),			//from wiz_0
   // .mig_ui_clk     (	mig_ui_clk     	),			//from mig
   // .mig_ui_rst     (	mig_ui_rst     	),			//from mig

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

   .mem_m_axi4_0_aw_ready 			  (	mem_m_axi_awready 			),
   .mem_m_axi4_0_aw_valid             (	mem_m_axi_awvalid           ),
   .mem_m_axi4_0_aw_bits_id           (	mem_m_axi_awid         		),
   .mem_m_axi4_0_aw_bits_addr         (	mem_m_axi_awaddr       		),
   .mem_m_axi4_0_aw_bits_len          (	mem_m_axi_awlen        		),
   .mem_m_axi4_0_aw_bits_size         (	mem_m_axi_awsize       		),
   .mem_m_axi4_0_aw_bits_burst        (	mem_m_axi_awburst      		),
   .mem_m_axi4_0_aw_bits_cache        (	mem_m_axi_awcache      		),
   .mem_m_axi4_0_aw_bits_prot         (	mem_m_axi_awprot       		),
   .mem_m_axi4_0_aw_bits_qos          (	mem_m_axi_awqos        		),
   .mem_m_axi4_0_w_ready              (	mem_m_axi_wready            ),
   .mem_m_axi4_0_w_valid              (	mem_m_axi_wvalid            ),
   .mem_m_axi4_0_w_bits_data          (	mem_m_axi_wdata        ),
   .mem_m_axi4_0_w_bits_strb          (	mem_m_axi_wstrb        ),
   .mem_m_axi4_0_w_bits_last          (	mem_m_axi_wlast        ),
   .mem_m_axi4_0_b_ready              (	mem_m_axi_bready            ),
   .mem_m_axi4_0_b_valid              (	mem_m_axi_bvalid            ),
   .mem_m_axi4_0_b_bits_id            (	mem_m_axi_bid            	),
   .mem_m_axi4_0_b_bits_resp          (	mem_m_axi_bresp          	),
   .mem_m_axi4_0_ar_ready             (	mem_m_axi_arready           ),
   .mem_m_axi4_0_ar_valid             (	mem_m_axi_arvalid           ),
   .mem_m_axi4_0_ar_bits_id           (	mem_m_axi_arid           	),
   .mem_m_axi4_0_ar_bits_addr         (	mem_m_axi_araddr         	),
   .mem_m_axi4_0_ar_bits_len          (	mem_m_axi_arlen          	),
   .mem_m_axi4_0_ar_bits_size         (	mem_m_axi_arsize         	),
   .mem_m_axi4_0_ar_bits_burst        (	mem_m_axi_arburst        	),
   .mem_m_axi4_0_ar_bits_cache        (	mem_m_axi_arcache        	),
   .mem_m_axi4_0_ar_bits_prot         (	mem_m_axi_arprot         	),
   .mem_m_axi4_0_ar_bits_qos          (	mem_m_axi_arqos          	),
   .mem_m_axi4_0_r_ready              (	mem_m_axi_rready            ),
   .mem_m_axi4_0_r_valid              (	mem_m_axi_rvalid            ),
   .mem_m_axi4_0_r_bits_id            (	mem_m_axi_rid            	),
   .mem_m_axi4_0_r_bits_data          (	mem_m_axi_rdata          	),
   .mem_m_axi4_0_r_bits_resp          (	mem_m_axi_rresp          	),
   .mem_m_axi4_0_r_bits_last          (	mem_m_axi_rlast          	),

//   .mem_m_axi4_0_aw_bits_lock         (	mem_m_axi_awlock       		),
//   .mem_m_axi4_0_ar_bits_lock         (	mem_m_axi_arlock         	),

   .mmio_master_nasti_aw_ready 			(	mmio_m_axi_awready			),
   .mmio_master_nasti_aw_valid         	(   mmio_m_axi_awvalid          ),
   .mmio_master_nasti_aw_id       	(   mmio_m_axi_awid        ),
   .mmio_master_nasti_aw_addr     	(   mmio_m_axi_awaddr      ),
   .mmio_master_nasti_aw_len      	(   mmio_m_axi_awlen       ),
   .mmio_master_nasti_aw_size     	(   mmio_m_axi_awsize      ),
   .mmio_master_nasti_aw_burst    	(   mmio_m_axi_awburst     ),
   .mmio_master_nasti_aw_lock     	(   mmio_m_axi_awlock      ),
   .mmio_master_nasti_aw_cache    	(   mmio_m_axi_awcache     ),
   .mmio_master_nasti_aw_prot     	(   mmio_m_axi_awprot      ),
   .mmio_master_nasti_aw_qos      	(   mmio_m_axi_awqos       ),
   .mmio_master_nasti_w_ready          	(   mmio_m_axi_wready           ),
   .mmio_master_nasti_w_valid          	(   mmio_m_axi_wvalid           ),
   .mmio_master_nasti_w_data      	(   mmio_m_axi_wdata       ),
   .mmio_master_nasti_w_strb      	(   mmio_m_axi_wstrb       ),
   .mmio_master_nasti_w_last      	(   mmio_m_axi_wlast       ),
   .mmio_master_nasti_b_ready          	(   mmio_m_axi_bready           ),
   .mmio_master_nasti_b_valid          	(   mmio_m_axi_bvalid           ),
   .mmio_master_nasti_b_id        	(   mmio_m_axi_bid         ),
   .mmio_master_nasti_b_resp      	(   mmio_m_axi_bresp       ),
   .mmio_master_nasti_ar_ready         	(   mmio_m_axi_arready          ),
   .mmio_master_nasti_ar_valid         	(   mmio_m_axi_arvalid          ),
   .mmio_master_nasti_ar_id       	(   mmio_m_axi_arid        ),
   .mmio_master_nasti_ar_addr     	(   mmio_m_axi_araddr      ),
   .mmio_master_nasti_ar_len      	(   mmio_m_axi_arlen       ),
   .mmio_master_nasti_ar_size     	(   mmio_m_axi_arsize      ),
   .mmio_master_nasti_ar_burst    	(   mmio_m_axi_arburst     ),
   .mmio_master_nasti_ar_lock     	(   mmio_m_axi_arlock      ),
   .mmio_master_nasti_ar_cache    	(   mmio_m_axi_arcache     ),
   .mmio_master_nasti_ar_prot     	(   mmio_m_axi_arprot      ),
   .mmio_master_nasti_ar_qos      	(   mmio_m_axi_arqos       ),
   .mmio_master_nasti_r_ready          	(   mmio_m_axi_rready           ),
   .mmio_master_nasti_r_valid          	(   mmio_m_axi_rvalid           ),
   .mmio_master_nasti_r_id        	(   mmio_m_axi_rid         ),
   .mmio_master_nasti_r_data      	(   mmio_m_axi_rdata       ),
   .mmio_master_nasti_r_resp      	(   mmio_m_axi_rresp       ),
   .mmio_master_nasti_r_last      	(   mmio_m_axi_rlast       ),


   .bram_rst_a      	(	bram_rst_a      	),
   .bram_clk_a      	(	bram_clk_a      	),
   .bram_en_a       	(	bram_en_a       	),
   .bram_we_a       	(	bram_we_a       	),
   .bram_addr_a     	(	bram_addr_a     	),
   .bram_wrdata_a   	(	bram_wrdata_a   	),
   .bram_rddata_a   	(	bram_rddata_a   	),





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


//  //debug
//  
//  
//  (* mark_debug = "true" *) reg [3:0] debug_aw_counter;
//  (* mark_debug = "true" *) reg [3:0] debug_ar_counter;
//  
//  (* mark_debug = "true" *) reg [31:0] mmio_m_axi_awaddr_r[0:9];
//  (* mark_debug = "true" *) reg [31:0] mmio_m_axi_araddr_r[0:9];
//  
//  reg [31:0] mmio_m_axi_awaddr_r_temp;
//  reg [31:0] mmio_m_axi_araddr_r_temp;
//  
//  always @(posedge clk) begin
//  	if(mmio_m_axi_awvalid && mmio_m_axi_awready) begin
//  																	debug_aw_counter <= debug_aw_counter + 1;
//  																	mmio_m_axi_awaddr_r_temp <= mmio_m_axi_awaddr;
//  	end 
//  	else if(mmio_m_axi_arvalid && mmio_m_axi_arready) begin
//  																	debug_ar_counter <= debug_ar_counter + 1;
//  																	mmio_m_axi_araddr_r_temp <= mmio_m_axi_araddr;																   
//  	end
//  end
//  
//  
//  always @(posedge clk) begin
//  	if     (debug_aw_counter == 1) 			mmio_m_axi_awaddr_r[0] <= mmio_m_axi_awaddr_r_temp;
//  	else if(debug_aw_counter == 2) 			mmio_m_axi_awaddr_r[1] <= mmio_m_axi_awaddr_r_temp;
//  	else if(debug_aw_counter == 3) 			mmio_m_axi_awaddr_r[2] <= mmio_m_axi_awaddr_r_temp;
//  	else if(debug_aw_counter == 4) 			mmio_m_axi_awaddr_r[3] <= mmio_m_axi_awaddr_r_temp;
//  	else if(debug_aw_counter == 5) 			mmio_m_axi_awaddr_r[4] <= mmio_m_axi_awaddr_r_temp;
//  	else if(debug_aw_counter == 6) 			mmio_m_axi_awaddr_r[5] <= mmio_m_axi_awaddr_r_temp;
//  	else if(debug_aw_counter == 7) 			mmio_m_axi_awaddr_r[6] <= mmio_m_axi_awaddr_r_temp;
//  	else if(debug_aw_counter == 8) 			mmio_m_axi_awaddr_r[7] <= mmio_m_axi_awaddr_r_temp;
//  	else if(debug_aw_counter == 9) 			mmio_m_axi_awaddr_r[8] <= mmio_m_axi_awaddr_r_temp;
//  	else if(debug_aw_counter == 10) 		mmio_m_axi_awaddr_r[9] <= mmio_m_axi_awaddr_r_temp;
//  end
//  
//  
//  always @(posedge clk) begin
//  	if     (debug_ar_counter == 1) 			mmio_m_axi_araddr_r[0] <= mmio_m_axi_araddr_r_temp;
//  	else if(debug_ar_counter == 2) 			mmio_m_axi_araddr_r[1] <= mmio_m_axi_araddr_r_temp;
//  	else if(debug_ar_counter == 3) 			mmio_m_axi_araddr_r[2] <= mmio_m_axi_araddr_r_temp;
//  	else if(debug_ar_counter == 4) 			mmio_m_axi_araddr_r[3] <= mmio_m_axi_araddr_r_temp;
//  	else if(debug_ar_counter == 5) 			mmio_m_axi_araddr_r[4] <= mmio_m_axi_araddr_r_temp;
//  	else if(debug_ar_counter == 6) 			mmio_m_axi_araddr_r[5] <= mmio_m_axi_araddr_r_temp;
//  	else if(debug_ar_counter == 7) 			mmio_m_axi_araddr_r[6] <= mmio_m_axi_araddr_r_temp;
//  	else if(debug_ar_counter == 8) 			mmio_m_axi_araddr_r[7] <= mmio_m_axi_araddr_r_temp;
//  	else if(debug_ar_counter == 9) 			mmio_m_axi_araddr_r[8] <= mmio_m_axi_araddr_r_temp;
//  	else if(debug_ar_counter == 10) 		mmio_m_axi_araddr_r[9] <= mmio_m_axi_araddr_r_temp;
//  end
//  
endmodule
