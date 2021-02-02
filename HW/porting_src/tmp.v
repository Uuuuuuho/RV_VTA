

 // signals from/to core
logic [7:0] one_hot_data_addr;
logic [63:0] one_hot_rdata[7:0];




	//===================================
	//  Q. port A와 port B가 나눠지는 이유는?
	//  **port A는 sd related LUT로 connected. port B는 hid related LUT로 connected.
	//  by manual
	//  port A is to write data in BRAM
	//  port B is to read data in BRAM
	//===================================
	//  However, bram controller is configured as a single port BRAM controller
	//  So only port A is used to access to BRAM
	//===================================
	
이 부분이 OS가 보는 MMIO I/O control BRAM address space
   dualmem_32K_64 RAMB16_S36_S36_inst_sd
       (	   
	//=====  Port A  =======
        .clka   ( ~sd_clk_o                   ),     // Port A Clock
        .douta  ( douta                       ),     // Port A 1-bit Data Output
        .addra  ( sd_xfr_addr[9:1]            ),     // Port A 9-bit Address Input
        .dina   ( {swapbein,swapbein}         ),     // Port A 1-bit Data Input
        .ena    ( tx_rd|rx_wr_en              ),     // Port A RAM Enable Input
        .wea    ( rx_wr                       ),     // Port A Write Enable Input
	//=====  Port B  =======
        .clkb   ( msoc_clk                    ),     // Port B Clock
        .doutb  ( doutb                       ),     // Port B 1-bit Data Output
        .addrb  ( hid_addr[11:3]              ),     // Port B 14-bit Address Input, 9 bits
        .dinb   ( hid_wrdata                  ),     // Port B 1-bit Data Input
        .enb    ( hid_en&one_hot_data_addr[3] ),     // Port B RAM Enable Input
		//when hid_en is 1 & one_hot_data_addr[3] is 1
        .web    ( hid_we                      )      // Port B Write Enable Input
        );


Q. how hid address is divided?(follow only on sub-module in psoc)
	let's follow keyboard module.

psoc의 output port ram_**은 어디로?

 
module ps2(clk, rst,
           PS2_K_CLK_IO, PS2_K_DATA_IO, PS2_M_CLK_IO, PS2_M_DATA_IO,
           rx_scan_read, rx_released, rx_scan_ready, rx_scan_code, tx_error_no_keyboard_ack);
{
   ps2_keyboard key1(
                     .clock_i(clk),
                     .reset_i(rst),
                     .ps2_clk_en_o_(ps2_k_clk_en_o_),
                     .ps2_data_en_o_(ps2_k_data_en_o_),
                     .ps2_clk_i(ps2_k_clk_i),
                     .ps2_data_i(ps2_k_data_i),
                     .rx_released(rx_released),
                     .rx_scan_code(rx_scan_code),
                     .rx_data_ready(rx_scan_ready),       // rx_read_o
                     .rx_read(rx_scan_read),             // rx_read_ack_i
                     .tx_data(tx_data),
                     .tx_write(tx_write),
                     .tx_write_ack_o(tx_write_ack_o),
                     .tx_error_no_keyboard_ack(tx_error_no_keyboard_ack),
                     .divide_reg_i(divide_reg)
                     );
}endmodule


    ps2 keyb_mouse(
      .clk(msoc_clk),
      .rst(~rstn),
      .PS2_K_CLK_IO(PS2_CLK),
      .PS2_K_DATA_IO(PS2_DATA),
      .PS2_M_CLK_IO(),
      .PS2_M_DATA_IO(),
      .rx_released(scan_released),
      .rx_scan_ready(scan_ready),
      .rx_scan_code(scan_code),
      .rx_scan_read(scan_ready),
      .tx_error_no_keyboard_ack(tx_error_no_keyboard_ack));


    
 my_fifo #(.width(9)) keyb_fifo (
       .clk(~msoc_clk),      // input wire read clk
       .rst(~rstn),      // input wire rst
       .din({scan_released, scan_code}),      // input wire [31 : 0] din
       .wr_en(scan_ready & ~scan_ready_dly),  // input wire wr_en
       .rd_en(hid_en&(|hid_we)&one_hot_data_addr[6]&~hid_addr[14]),  // input wire rd_en
       .dout(keyb_fifo_out),    // output wire [31 : 0] dout
       .rdcount(),         // 12-bit output: Read count
       .wrcount(),         // 12-bit output: Write count
       .full(),    // output wire full
       .empty(keyb_empty)  // output wire empty
     );

address를 arbitering해주는 부분은 도대체 어디?

psoc.(input wire)hid_addr은 어떻게 divide 되는가?
hid_addr이 connect되는 psoc의 sub-module을 모조리 찾아보자.

	my_fifo #(.width(9)) keyb_fifo ()
	fstore2 the_fstore()

	assign one_hot_rdata[6] = hid_addr[14] ?

	if (hid_en & (|hid_we) & one_hot_data_addr[6] & hid_addr[14])
        casez (hid_addr[13:12])
         2'b00: begin u_trans = 1; u_tx_byte = hid_wrdata[7:0]; $write("%c", u_tx_byte); $fflush(); end
         2'b01: begin u_recv = 1; end
         2'b10: begin u_baud = hid_wrdata; end
         2'b11: begin end
        endcase
	end // else: !if(~rstn)


always_comb
	begin:onehot
	 integer i;
	 hid_rddata = 64'b0;
	 for (i = 0; i < 8; i++)
	   begin
	   one_hot_data_addr[i] = hid_addr[17:15] == i;
	   hid_rddata |= (one_hot_data_addr[i] ? one_hot_rdata[i] : 64'b0);
	   end
	end



	one_hot_data_addr from where?



   assign one_hot_rdata[1] = one_hot_rdata[0];
   assign one_hot_rdata[0] = ram_rddata;
   assign ram_wrdata = hid_wrdata;
   assign ram_addr = hid_addr[15:0];
   assign ram_we = hid_we;
   assign ram_en = hid_en&(one_hot_data_addr[1]|one_hot_data_addr[0]);
   assign ram_clk = msoc_clk;
   assign ram_rst = ~rstn;



hid_addr => keyb_fifo.rd_en(hid_en&(|hid_we)&one_hot_data_addr[6]&~hid_addr[14]),  // input wire rd_en
	din[9:0] (scan_released, scan_code) //width for each var?
		scan_released : 1bit
		scan_code : 8bit
	rd_en : 1bit wire => queue enable
		~hid_addr[14]
		one_hot_data_addr[6]
		|hid_we[7:0]
		hid_en
		meaning?? => hid_en = 1, hid_addr[14] = 0, one_hot_data_addr[6] = 1, hid_we 중 하나라도 '1'

what is one_hot_data_addr for?
	signals from/to core
	
one_hot_data_addr field analysis.
	one_hot_data_addr filling for loop
		hid_adr

one_hot_data_addr[7:0]
7 : fstore2.enb
6 : my_fifo.rd_en
5 : 
4 : frapming_top_mii.we_d
3 : RAMB : port B RAM enable input
2 : if (hid_en&(|hid_we)&one_hot_data_addr[2]&~hid_addr[14])
1 : ram_en
0 : ram_en


//hid_addr : entire input wires are connected to the ground. << this is incorrect
hid_addr <=> BramCtl.bram_addr_a[17:0] >> where does BramCtl.bram_addr_a go to?
from the bram controller manual
BRAM port A(write port) address bus.

Q. why width of bram_addr_a is 18 bits(256KB)?
	**ram_addr is determined 16 bits(64KB)
	
A. BRAM sized in chip_top.sv


//  rocket_chip <=> bram controller interface? AXI뿐인가?
mmio_master_nasti  //AXI protocol interface system verilog. 즉 AXI bus를 사용함.
bram_ar_addr : mmio_master_nasti.ar_addr
bram_aw_addr : mmio_master_nasti.aw_addr

rocket_chip.mmio_master_nasti <=> bramCtl.mmio_master_nasti


//=====================
// =====  (AXI)	=====		==========
// |R.C|  <=>	|B.C|	<=> |BootROM |
// ===== (mmio)	=====		==========
//				|	======		========		=================
//				|=> |psoc|	<=>	|BRAM16|	<=>	|uart,eth,key,sd|
//				|	======		========		=================

How to create BRAM16?
	in psoc.sv
		dualmem_32K_64 RAMB16_S36_S36_inst_sd
			RAMB16_S36_S36 : xilinx primitive //each block has 2KB of data 
	dualmem is not the only BRAM generated in psoc as far as I'm aware of
	wonder how to determine base address & address space for each peripheral device?

	//=======================
	//  dualmem BRAM is being used only for sd_top module
	//=======================

	  case(hid_addr[6:3])
	    0: sd_align_reg <= hid_wrdata;
	    1: sd_clk_din <= hid_wrdata;
	    2: sd_cmd_arg_reg <= hid_wrdata;
	    3: sd_cmd_i_reg <= hid_wrdata;
	    4: {sd_data_start_reg,sd_cmd_setting_reg[2:0]} <= hid_wrdata;
	    5: sd_cmd_start_reg <= hid_wrdata;
	    6: {sd_reset,sd_clk_rst,sd_data_rst,sd_cmd_rst} <= hid_wrdata;
	    7: sd_blkcnt_reg <= hid_wrdata;
	    8: sd_blksize_reg <= hid_wrdata;
	    9: sd_cmd_timeout_reg <= hid_wrdata;
	   10: {sd_clk_dwe,sd_clk_den,sd_clk_daddr} <= hid_wrdata;
       11: sd_irq_en_reg <= hid_wrdata;            
	   // Not strictly related, but can indicate SD-card activity and so on
	   15: to_led <= hid_wrdata;
	  endcase

//============================
//  from lowrisc_memory_map.h
//============================

enum {
        clint_base_addr = 0x02000000,
        plic_base_addr = 0x0c000000,
        bram_base_addr = 0x40000000,
          sd_base_addr = 0x40010000,
          sd_bram_addr = 0x40018000,
         eth_base_addr = 0x40020000,
        keyb_base_addr = 0x40030000, // These have been relocated
        uart_base_addr = 0x40034000,
         vga_base_addr = 0x40038000,
        ddr_base_addr  = 0x80000000
      };

//=============================================
//  let's figure out how the address is accessed
//=============================================


//================  여기는 나중에 BootROM bram size 늘리고싶을때 보는곳 ===================
나중에 필요한 경우, BRAM_SIZE를 늘려서 MMIO control address space를 지정할 수 있을 것으로 보임.
reg   [BRAM_WIDTH-1:0]         ram [0 : BRAM_LINE-1];의 의미?
	4KB sized 16 reg로 64KB의 BRAM allocation.
BRAM_ADDR_BLK_BITS?
	BRAM_ADDR_BLK_BITS(8) = BRAM_SIZE(16) - BRAM_ADDR_LSB_BITS(4) - BRAM_OFFSET_BITS(4);
	ram_block_addr, ram_block_addr_delay[3:0] //4 bit width



































































