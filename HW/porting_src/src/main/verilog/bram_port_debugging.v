module bram_port_debugging
  (
       //=======
       // input
       //=======
       
       input wire        clk		,
       input wire        awvalid    ,
       input wire        awready    ,
       input wire        arvalid    ,
       input wire        arready    ,
       input wire [31:0] awaddr     ,
       input wire [31:0] araddr     

);





(* mark_debug = "true" *) reg [3:0] debug_aw_counter;
(* mark_debug = "true" *) reg [3:0] debug_ar_counter;

(* mark_debug = "true" *) reg [31:0] mmio_m_axi_awaddr_r[0:9];
(* mark_debug = "true" *) reg [31:0] mmio_m_axi_araddr_r[0:9];

reg [31:0] mmio_m_axi_awaddr_r_temp;
reg [31:0] mmio_m_axi_araddr_r_temp;


always @(posedge clk) begin
	if(awvalid && awready) begin
																	debug_aw_counter <= debug_aw_counter + 1;
																	mmio_m_axi_awaddr_r_temp <= awaddr;
	end 
	else if(arvalid && arready) begin
																	debug_ar_counter <= debug_ar_counter + 1;
																	mmio_m_axi_araddr_r_temp <= araddr;																   
	end
end


always @(posedge clk) begin
	if     (debug_aw_counter == 1) 			mmio_m_axi_awaddr_r[0] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_counter == 2) 			mmio_m_axi_awaddr_r[1] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_counter == 3) 			mmio_m_axi_awaddr_r[2] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_counter == 4) 			mmio_m_axi_awaddr_r[3] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_counter == 5) 			mmio_m_axi_awaddr_r[4] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_counter == 6) 			mmio_m_axi_awaddr_r[5] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_counter == 7) 			mmio_m_axi_awaddr_r[6] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_counter == 8) 			mmio_m_axi_awaddr_r[7] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_counter == 9) 			mmio_m_axi_awaddr_r[8] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_counter == 10) 		mmio_m_axi_awaddr_r[9] <= mmio_m_axi_awaddr_r_temp;
end


always @(posedge clk) begin
	if     (debug_ar_counter == 1) 			mmio_m_axi_araddr_r[0] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_counter == 2) 			mmio_m_axi_araddr_r[1] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_counter == 3) 			mmio_m_axi_araddr_r[2] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_counter == 4) 			mmio_m_axi_araddr_r[3] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_counter == 5) 			mmio_m_axi_araddr_r[4] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_counter == 6) 			mmio_m_axi_araddr_r[5] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_counter == 7) 			mmio_m_axi_araddr_r[6] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_counter == 8) 			mmio_m_axi_araddr_r[7] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_counter == 9) 			mmio_m_axi_araddr_r[8] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_counter == 10) 		mmio_m_axi_araddr_r[9] <= mmio_m_axi_araddr_r_temp;
end

endmodule
