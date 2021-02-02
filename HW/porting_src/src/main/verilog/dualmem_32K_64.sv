
module dualmem_32K_64(clka, clkb, dina, dinb, addra, addrb, wea, web, douta, doutb, ena, enb);

   input wire clka, clkb;
   input [63:0] dina;
   input [63:0] dinb;
   input [8:0] addra;
   input [8:0] addrb;
   input [7:0]        wea;
   input [7:0]        web;
   input [0:0]        ena, enb;
   output [63:0]      douta;
   output [63:0]      doutb;

   genvar r;

//`ifdef FPGA
//FPGA
   
   generate for (r = 0; r < 2; r=r+1)
     RAMB16_S36_S36
     RAMB16_S36_S36_inst
       (
        .CLKA   ( clka                     ),     // Port A Clock
        .DOA    ( douta[r*32 +: 32]        ),     // Port A 1-bit Data Output
        .DOPA   (                          ),
        .ADDRA  ( addra                    ),     // Port A 14-bit Address Input
        .DIA    ( dina[r*32 +: 32]         ),     // Port A 1-bit Data Input
        .DIPA   ( 4'b0                     ),
        .ENA    ( ena                      ),     // Port A RAM Enable Input
        .SSRA   ( 1'b0                     ),     // Port A Synchronous Set/Reset Input
        .WEA    ( wea[r*4]                 ),     // Port A Write Enable Input
        .CLKB   ( clkb                     ),     // Port B Clock
        .DOB    ( doutb[r*32 +: 32]        ),     // Port B 1-bit Data Output
        .DOPB   (                          ),
        .ADDRB  ( addrb                    ),     // Port B 14-bit Address Input
        .DIB    ( dinb[r*32 +: 32]         ),     // Port B 1-bit Data Input
        .DIPB   ( 4'b0                     ),
        .ENB    ( enb                      ),     // Port B RAM Enable Input
        .SSRB   ( 1'b0                     ),     // Port B Synchronous Set/Reset Input
        .WEB    ( web[r*4]                 )      // Port B Write Enable Input
        );
   endgenerate
   
endmodule // dualmem
