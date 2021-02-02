module debugging_module_eth
  (
       //=======
       // input
       //=======
       
		clk			    ,
		rst_x      	    ,
		i_erx_dv        ,          // PHY data valid
        i_erx_er        ,          // PHY coding error
        i_emdint        ,          // PHY interrupt in active low
        o_erefclk       ,          // RMII clock out
        o_etx_en        ,          // RMII transmit enable
        i_erxd          ,          // RMII receive data
        o_etxd          ,          // RMII transmit data
        o_etx_er        ,          // RMII transmit enable
        i_gmiiclk_p     ,
        i_gmiiclk_n     ,
        i_erx_clk       ,
        i_etx_clk       ,
        o_emdc          ,           // MDIO clock
        io_emdio        ,           // MDIO inout
        o_erstn         ,           // PHY reset active low
);

										 input wire		 	 clk	;
										 input wire		 	 rst_x  ;


//! Ethernet MAC PHY interface signals
                     
(* keep = "true", mark_debug = "true" *) input wire         i_erx_dv        , // PHY data valid
(* keep = "true", mark_debug = "true" *) input wire         i_erx_er        , // PHY coding error
(* keep = "true", mark_debug = "true" *) input wire         i_emdint        , // PHY interrupt in active low
(* keep = "true", mark_debug = "true" *) output wire        o_erefclk       , // RMII clock out
(* keep = "true", mark_debug = "true" *) output wire        o_etx_en        , // RMII transmit enable


(* keep = "true", mark_debug = "true" *) input wire [3:0]   i_erxd          , // RMII receive data
(* keep = "true", mark_debug = "true" *) output wire [7:0]  o_etxd          , // RMII transmit data
(* keep = "true", mark_debug = "true" *) output wire        o_etx_er        , // RMII transmit enable
(* keep = "true", mark_debug = "true" *) input wire         i_gmiiclk_p     ,
(* keep = "true", mark_debug = "true" *) input wire         i_gmiiclk_n     ,
(* keep = "true", mark_debug = "true" *) input wire         i_erx_clk       ,
(* keep = "true", mark_debug = "true" *) input wire         i_etx_clk       ,
(* keep = "true", mark_debug = "true" *) output wire        o_emdc          , // MDIO clock
(* keep = "true", mark_debug = "true" *) inout wire         io_emdio        , // MDIO inout
(* keep = "true", mark_debug = "true" *) output wire        o_erstn         , // PHY reset active low


(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_i_erx_dv       ; 
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_i_erx_er       ;
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_i_emdint       ; 
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_o_erefclk      ;
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_o_etx_en       ; 
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_i_erxd         ;
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_o_etxd         ;
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_o_etx_er       ;
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_i_gmiiclk_p    ;
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_i_gmiiclk_n    ;
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_i_erx_clk      ;
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_i_etx_clk      ;
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_o_emdc         ;
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_io_emdio       ; 
(* keep = "true", mark_debug = "true" *) reg [3:0] debug_counter_o_erstn        ;

(* keep = "true", mark_debug = "true" *) reg [31:0] debug_i_erx_dv       [9:0]; 
(* keep = "true", mark_debug = "true" *) reg [31:0] debug_i_erx_er       [9:0];
(* keep = "true", mark_debug = "true" *) reg [31:0] debug_i_emdint       [9:0]; 
(* keep = "true", mark_debug = "true" *) reg [31:0] debug_o_erefclk      [9:0];
(* keep = "true", mark_debug = "true" *) reg [31:0] debug_o_etx_en       [9:0]; 
(* keep = "true", mark_debug = "true" *) reg [31:0] debug_i_erxd         [9:0];
(* keep = "true", mark_debug = "true" *) reg [31:0] debug_o_etxd         [9:0];
(* keep = "true", mark_debug = "true" *) reg [31:0] debug_o_etx_er       [9:0];
(* keep = "true", mark_debug = "true" *) reg [31:0] debug_i_gmiiclk_p    [9:0];
(* keep = "true", mark_debug = "true" *) reg [31:0] debug_i_gmiiclk_n    [9:0];
(* keep = "true", mark_debug = "true" *) reg [31:0] debug_i_erx_clk      [9:0];
(* keep = "true", mark_debug = "true" *) reg [31:0] debug_i_etx_clk      [9:0];
(* keep = "true", mark_debug = "true" *) reg [31:0] debug_o_emdc         [9:0];
(* keep = "true", mark_debug = "true" *) reg [31:0] debug_io_emdio       [9:0]; 
(* keep = "true", mark_debug = "true" *) reg [31:0] debug_o_erstn        [9:0];


reg [31:0] debug_counter_i_erx_dv_temp;   
reg [31:0] debug_counter_i_erx_er_temp;   
reg [31:0] debug_counter_i_emdint_temp;   
reg [31:0] debug_counter_o_erefclk_temp;  
reg [31:0] debug_counter_o_etx_en_temp;   
reg [31:0] debug_counter_i_erxd_temp;     
reg [31:0] debug_counter_o_etxd_temp;     
reg [31:0] debug_counter_o_etx_er_temp;   
reg [31:0] debug_counter_i_gmiiclk_p_temp;
reg [31:0] debug_counter_i_gmiiclk_n_temp;
reg [31:0] debug_counter_i_erx_clk_temp;  
reg [31:0] debug_counter_i_etx_clk_temp;  
reg [31:0] debug_counter_o_emdc_temp;     
reg [31:0] debug_counter_io_emdio_temp;   
reg [31:0] debug_counter_o_erstn_temp;    


always @(posedge clk or negedge rst_x) begin
	if(!rst_x) begin
																	debug_counter_i_erx_dv 	   <= 'b0;
																	debug_counter_i_erx_dv_temp <= 'b0;
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
