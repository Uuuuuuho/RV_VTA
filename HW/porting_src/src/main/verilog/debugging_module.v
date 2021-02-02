module debugging_module
  (
       //=======
       // input
       //=======
       
		clk			,
		rst_x      	,
		awvalid    	,
		awready    	,
		arvalid    	,
		arready    	,
		awaddr     	,
		araddr     
);

										 input wire		 	 clk	;
										 input wire		 	 rst_x  ;
(* keep = "true", mark_debug = "true" *) input wire 		 awvalid;
(* keep = "true", mark_debug = "true" *) input wire 		 awready;
(* keep = "true", mark_debug = "true" *) input wire 		 arvalid;
(* keep = "true", mark_debug = "true" *) input wire 		 arready;
(* keep = "true", mark_debug = "true" *) input wire [31:0]   awaddr ;
(* keep = "true", mark_debug = "true" *) input wire [31:0]   araddr ;



(* keep = "true", mark_debug = "true" *) reg [3:0] debug_aw_vra_counter; //valid & ready
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_ar_vra_counter;
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_aw_r_counter;   //ready
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_ar_r_counter;
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_aw_v_counter;   //valid
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_ar_v_counter;
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_aw_vro_counter; //valid || ready
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_ar_vro_counter;


(* keep = "true", mark_debug = "true" *) reg [31:0] mmio_m_axi_awaddr_vra[0:9];
(* keep = "true", mark_debug = "true" *) reg [31:0] mmio_m_axi_araddr_vra[0:9];
(* keep = "true", mark_debug = "true" *) reg [31:0] mmio_m_axi_awaddr_v[0:9];
(* keep = "true", mark_debug = "true" *) reg [31:0] mmio_m_axi_araddr_v[0:9];
(* keep = "true", mark_debug = "true" *) reg [31:0] mmio_m_axi_awaddr_r[0:9];
(* keep = "true", mark_debug = "true" *) reg [31:0] mmio_m_axi_araddr_r[0:9];
(* keep = "true", mark_debug = "true" *) reg [31:0] mmio_m_axi_awaddr_vro[0:9];
(* keep = "true", mark_debug = "true" *) reg [31:0] mmio_m_axi_araddr_vro[0:9];


reg [31:0] mmio_m_axi_awaddr_vra_temp;
reg [31:0] mmio_m_axi_araddr_vra_temp;

reg [31:0] mmio_m_axi_awaddr_v_temp;
reg [31:0] mmio_m_axi_araddr_v_temp;

reg [31:0] mmio_m_axi_awaddr_r_temp;
reg [31:0] mmio_m_axi_araddr_r_temp;

reg [31:0] mmio_m_axi_awaddr_vro_temp;
reg [31:0] mmio_m_axi_araddr_vro_temp;


always @(posedge clk or negedge rst_x) begin
	if(!rst_x) begin
																	debug_aw_vra_counter 	   <= 'b0;
																	mmio_m_axi_awaddr_vra_temp <= 'b0;
	end
	else if(awvalid && awready) begin
																	debug_aw_vra_counter 		<= debug_aw_vra_counter + 1;
																	mmio_m_axi_awaddr_vra_temp 	<= awaddr;
	end 
	else if(debug_aw_vra_counter > 10) begin                   		
																	debug_aw_vra_counter <= 11; //to keep the address
	end
end

always @(posedge clk or negedge rst_x) begin
	if(!rst_x) begin
																	debug_ar_vra_counter 	   <= 'b0;
																	mmio_m_axi_araddr_vra_temp <= 'b0;
	end
	else if(arvalid && arready) begin
																	debug_ar_vra_counter 		<= debug_ar_vra_counter + 1;
																	mmio_m_axi_araddr_vra_temp 	<= araddr;
	end
	else if(debug_ar_vra_counter > 10) begin                   		
																	debug_ar_vra_counter <= 11;
	end
end

always @(posedge clk or negedge rst_x) begin
	if(!rst_x) begin
																	debug_aw_v_counter 	   	   <= 'b0;
																	mmio_m_axi_awaddr_v_temp   <= 'b0;
	end
	else if(awvalid) begin
																	debug_aw_v_counter 			<= debug_aw_v_counter + 1;
																	mmio_m_axi_awaddr_v_temp 	<= awaddr;
	end
	else if(debug_aw_v_counter > 10) begin                   		
																	debug_aw_v_counter <= 11;
	end
end

always @(posedge clk or negedge rst_x) begin
	if(!rst_x) begin
																	debug_ar_v_counter 	   	   <= 'b0;
																	mmio_m_axi_araddr_v_temp   <= 'b0;
	end
	else if(arvalid) begin
																	debug_ar_v_counter <= debug_ar_v_counter + 1;
																	mmio_m_axi_araddr_v_temp <= araddr;																   
	end
	else if(debug_ar_v_counter > 10) begin                   		
																	debug_ar_v_counter <= 11;
	end
end

always @(posedge clk or negedge rst_x) begin
	if(!rst_x) begin
																	debug_aw_r_counter 	   	   <= 'b0;
																	mmio_m_axi_awaddr_r_temp   <= 'b0;
	end
	else if(awready) begin
																	debug_aw_r_counter <= debug_aw_r_counter + 1;
																	mmio_m_axi_awaddr_r_temp <= awaddr;
	end
	else if(debug_aw_r_counter > 10) begin                   		
																	debug_aw_r_counter <= 11;
	end
end


always @(posedge clk or negedge rst_x) begin
	if(!rst_x) begin
																	debug_ar_r_counter 	   	   <= 'b0;
																	mmio_m_axi_araddr_r_temp   <= 'b0;
	end
	else if(arready) begin
																	debug_ar_r_counter <= debug_ar_r_counter + 1;
																	mmio_m_axi_araddr_r_temp <= araddr;																   
	end
	else if(debug_ar_r_counter > 10) begin                   		
																	debug_ar_r_counter <= 11;
	end
end


always @(posedge clk or negedge rst_x) begin
	if(!rst_x) begin
																	debug_aw_vro_counter 	   	   	<= 'b0;
																	mmio_m_axi_awaddr_vro_temp  	<= 'b0;
	end
	else if(awvalid || awready) begin
																	debug_aw_vro_counter <= debug_aw_vro_counter + 1;
																	mmio_m_axi_awaddr_vro_temp <= awaddr;
	end 
	else if(debug_aw_vro_counter > 10) begin                   		
																	debug_aw_vro_counter <= 11; 
	end
end

always @(posedge clk or negedge rst_x) begin
	if(!rst_x) begin
																	debug_ar_vro_counter 	   	   	<= 'b0;
																	mmio_m_axi_araddr_vro_temp  	<= 'b0;
	end
	else if(arvalid || arready) begin
																	debug_ar_vro_counter <= debug_ar_vro_counter + 1;
																	mmio_m_axi_araddr_vro_temp <= araddr;																   
	end
	else if(debug_ar_vro_counter > 10) begin                   		
																	debug_ar_vro_counter <= 11; 
	end
end








always @(posedge clk) begin
	if     (debug_aw_vra_counter == 1) 			mmio_m_axi_awaddr_vra[0] <= mmio_m_axi_awaddr_vra_temp;
	else if(debug_aw_vra_counter == 2) 			mmio_m_axi_awaddr_vra[1] <= mmio_m_axi_awaddr_vra_temp;
	else if(debug_aw_vra_counter == 3) 			mmio_m_axi_awaddr_vra[2] <= mmio_m_axi_awaddr_vra_temp;
	else if(debug_aw_vra_counter == 4) 			mmio_m_axi_awaddr_vra[3] <= mmio_m_axi_awaddr_vra_temp;
	else if(debug_aw_vra_counter == 5) 			mmio_m_axi_awaddr_vra[4] <= mmio_m_axi_awaddr_vra_temp;
	else if(debug_aw_vra_counter == 6) 			mmio_m_axi_awaddr_vra[5] <= mmio_m_axi_awaddr_vra_temp;
	else if(debug_aw_vra_counter == 7) 			mmio_m_axi_awaddr_vra[6] <= mmio_m_axi_awaddr_vra_temp;
	else if(debug_aw_vra_counter == 8) 			mmio_m_axi_awaddr_vra[7] <= mmio_m_axi_awaddr_vra_temp;
	else if(debug_aw_vra_counter == 9) 			mmio_m_axi_awaddr_vra[8] <= mmio_m_axi_awaddr_vra_temp;
	else if(debug_aw_vra_counter == 10) 		mmio_m_axi_awaddr_vra[9] <= mmio_m_axi_awaddr_vra_temp;
end

always @(posedge clk) begin
	if     (debug_aw_v_counter == 1) 			mmio_m_axi_awaddr_v[0] <= mmio_m_axi_awaddr_v_temp;
	else if(debug_aw_v_counter == 2) 			mmio_m_axi_awaddr_v[1] <= mmio_m_axi_awaddr_v_temp;
	else if(debug_aw_v_counter == 3) 			mmio_m_axi_awaddr_v[2] <= mmio_m_axi_awaddr_v_temp;
	else if(debug_aw_v_counter == 4) 			mmio_m_axi_awaddr_v[3] <= mmio_m_axi_awaddr_v_temp;
	else if(debug_aw_v_counter == 5) 			mmio_m_axi_awaddr_v[4] <= mmio_m_axi_awaddr_v_temp;
	else if(debug_aw_v_counter == 6) 			mmio_m_axi_awaddr_v[5] <= mmio_m_axi_awaddr_v_temp;
	else if(debug_aw_v_counter == 7) 			mmio_m_axi_awaddr_v[6] <= mmio_m_axi_awaddr_v_temp;
	else if(debug_aw_v_counter == 8) 			mmio_m_axi_awaddr_v[7] <= mmio_m_axi_awaddr_v_temp;
	else if(debug_aw_v_counter == 9) 			mmio_m_axi_awaddr_v[8] <= mmio_m_axi_awaddr_v_temp;
	else if(debug_aw_v_counter == 10) 			mmio_m_axi_awaddr_v[9] <= mmio_m_axi_awaddr_v_temp;
end

always @(posedge clk) begin
	if     (debug_aw_r_counter == 1) 			mmio_m_axi_awaddr_r[0] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_r_counter == 2) 			mmio_m_axi_awaddr_r[1] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_r_counter == 3) 			mmio_m_axi_awaddr_r[2] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_r_counter == 4) 			mmio_m_axi_awaddr_r[3] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_r_counter == 5) 			mmio_m_axi_awaddr_r[4] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_r_counter == 6) 			mmio_m_axi_awaddr_r[5] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_r_counter == 7) 			mmio_m_axi_awaddr_r[6] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_r_counter == 8) 			mmio_m_axi_awaddr_r[7] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_r_counter == 9) 			mmio_m_axi_awaddr_r[8] <= mmio_m_axi_awaddr_r_temp;
	else if(debug_aw_r_counter == 10) 			mmio_m_axi_awaddr_r[9] <= mmio_m_axi_awaddr_r_temp;
end

always @(posedge clk) begin
	if     (debug_aw_vro_counter == 1) 			mmio_m_axi_awaddr_vro[0] <= mmio_m_axi_awaddr_vro_temp;
	else if(debug_aw_vro_counter == 2) 			mmio_m_axi_awaddr_vro[1] <= mmio_m_axi_awaddr_vro_temp;
	else if(debug_aw_vro_counter == 3) 			mmio_m_axi_awaddr_vro[2] <= mmio_m_axi_awaddr_vro_temp;
	else if(debug_aw_vro_counter == 4) 			mmio_m_axi_awaddr_vro[3] <= mmio_m_axi_awaddr_vro_temp;
	else if(debug_aw_vro_counter == 5) 			mmio_m_axi_awaddr_vro[4] <= mmio_m_axi_awaddr_vro_temp;
	else if(debug_aw_vro_counter == 6) 			mmio_m_axi_awaddr_vro[5] <= mmio_m_axi_awaddr_vro_temp;
	else if(debug_aw_vro_counter == 7) 			mmio_m_axi_awaddr_vro[6] <= mmio_m_axi_awaddr_vro_temp;
	else if(debug_aw_vro_counter == 8) 			mmio_m_axi_awaddr_vro[7] <= mmio_m_axi_awaddr_vro_temp;
	else if(debug_aw_vro_counter == 9) 			mmio_m_axi_awaddr_vro[8] <= mmio_m_axi_awaddr_vro_temp;
	else if(debug_aw_vro_counter == 10) 		mmio_m_axi_awaddr_vro[9] <= mmio_m_axi_awaddr_vro_temp;
end








always @(posedge clk) begin
	if     (debug_ar_vra_counter == 1) 			mmio_m_axi_araddr_vra[0] <= mmio_m_axi_araddr_vra_temp;
	else if(debug_ar_vra_counter == 2) 			mmio_m_axi_araddr_vra[1] <= mmio_m_axi_araddr_vra_temp;
	else if(debug_ar_vra_counter == 3) 			mmio_m_axi_araddr_vra[2] <= mmio_m_axi_araddr_vra_temp;
	else if(debug_ar_vra_counter == 4) 			mmio_m_axi_araddr_vra[3] <= mmio_m_axi_araddr_vra_temp;
	else if(debug_ar_vra_counter == 5) 			mmio_m_axi_araddr_vra[4] <= mmio_m_axi_araddr_vra_temp;
	else if(debug_ar_vra_counter == 6) 			mmio_m_axi_araddr_vra[5] <= mmio_m_axi_araddr_vra_temp;
	else if(debug_ar_vra_counter == 7) 			mmio_m_axi_araddr_vra[6] <= mmio_m_axi_araddr_vra_temp;
	else if(debug_ar_vra_counter == 8) 			mmio_m_axi_araddr_vra[7] <= mmio_m_axi_araddr_vra_temp;
	else if(debug_ar_vra_counter == 9) 			mmio_m_axi_araddr_vra[8] <= mmio_m_axi_araddr_vra_temp;
	else if(debug_ar_vra_counter == 10) 		mmio_m_axi_araddr_vra[9] <= mmio_m_axi_araddr_vra_temp;
end

always @(posedge clk) begin
	if     (debug_ar_v_counter == 1) 			mmio_m_axi_araddr_v[0] <= mmio_m_axi_araddr_v_temp;
	else if(debug_ar_v_counter == 2) 			mmio_m_axi_araddr_v[1] <= mmio_m_axi_araddr_v_temp;
	else if(debug_ar_v_counter == 3) 			mmio_m_axi_araddr_v[2] <= mmio_m_axi_araddr_v_temp;
	else if(debug_ar_v_counter == 4) 			mmio_m_axi_araddr_v[3] <= mmio_m_axi_araddr_v_temp;
	else if(debug_ar_v_counter == 5) 			mmio_m_axi_araddr_v[4] <= mmio_m_axi_araddr_v_temp;
	else if(debug_ar_v_counter == 6) 			mmio_m_axi_araddr_v[5] <= mmio_m_axi_araddr_v_temp;
	else if(debug_ar_v_counter == 7) 			mmio_m_axi_araddr_v[6] <= mmio_m_axi_araddr_v_temp;
	else if(debug_ar_v_counter == 8) 			mmio_m_axi_araddr_v[7] <= mmio_m_axi_araddr_v_temp;
	else if(debug_ar_v_counter == 9) 			mmio_m_axi_araddr_v[8] <= mmio_m_axi_araddr_v_temp;
	else if(debug_ar_v_counter == 10) 			mmio_m_axi_araddr_v[9] <= mmio_m_axi_araddr_v_temp;
end

always @(posedge clk) begin
	if     (debug_ar_r_counter == 1) 			mmio_m_axi_araddr_r[0] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_r_counter == 2) 			mmio_m_axi_araddr_r[1] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_r_counter == 3) 			mmio_m_axi_araddr_r[2] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_r_counter == 4) 			mmio_m_axi_araddr_r[3] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_r_counter == 5) 			mmio_m_axi_araddr_r[4] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_r_counter == 6) 			mmio_m_axi_araddr_r[5] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_r_counter == 7) 			mmio_m_axi_araddr_r[6] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_r_counter == 8) 			mmio_m_axi_araddr_r[7] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_r_counter == 9) 			mmio_m_axi_araddr_r[8] <= mmio_m_axi_araddr_r_temp;
	else if(debug_ar_r_counter == 10) 			mmio_m_axi_araddr_r[9] <= mmio_m_axi_araddr_r_temp;
end

always @(posedge clk) begin
	if     (debug_ar_vro_counter == 1) 			mmio_m_axi_araddr_vro[0] <= mmio_m_axi_araddr_vro_temp;
	else if(debug_ar_vro_counter == 2) 			mmio_m_axi_araddr_vro[1] <= mmio_m_axi_araddr_vro_temp;
	else if(debug_ar_vro_counter == 3) 			mmio_m_axi_araddr_vro[2] <= mmio_m_axi_araddr_vro_temp;
	else if(debug_ar_vro_counter == 4) 			mmio_m_axi_araddr_vro[3] <= mmio_m_axi_araddr_vro_temp;
	else if(debug_ar_vro_counter == 5) 			mmio_m_axi_araddr_vro[4] <= mmio_m_axi_araddr_vro_temp;
	else if(debug_ar_vro_counter == 6) 			mmio_m_axi_araddr_vro[5] <= mmio_m_axi_araddr_vro_temp;
	else if(debug_ar_vro_counter == 7) 			mmio_m_axi_araddr_vro[6] <= mmio_m_axi_araddr_vro_temp;
	else if(debug_ar_vro_counter == 8) 			mmio_m_axi_araddr_vro[7] <= mmio_m_axi_araddr_vro_temp;
	else if(debug_ar_vro_counter == 9) 			mmio_m_axi_araddr_vro[8] <= mmio_m_axi_araddr_vro_temp;
	else if(debug_ar_vro_counter == 10) 		mmio_m_axi_araddr_vro[9] <= mmio_m_axi_araddr_vro_temp;
end

endmodule
