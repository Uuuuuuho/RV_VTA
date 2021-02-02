vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xilinx_vip
vlib questa_lib/msim/xil_defaultlib

vmap xilinx_vip questa_lib/msim/xilinx_vip
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xilinx_vip -64 -sv -L xil_defaultlib "+incdir+/opt/Xilinx/Vivado/2018.1/data/xilinx_vip/include" "+incdir+/opt/Xilinx/Vivado/2018.1/data/xilinx_vip/include" \
"/opt/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/opt/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/opt/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/opt/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/opt/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/opt/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/opt/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/opt/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/opt/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xil_defaultlib -64 "+incdir+/opt/Xilinx/Vivado/2018.1/data/xilinx_vip/include" "+incdir+/opt/Xilinx/Vivado/2018.1/data/xilinx_vip/include" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_lim.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_prbs_rdlvl.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_poc_tap_base.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_prbs_gen.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_rdlvl.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_poc_cc.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_calib_top.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_cntlr.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_oclkdelay_cal.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_mux.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_poc_meta.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_poc_top.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_if_post_fifo.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_wrlvl_off_delay.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_wrcal.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_byte_group_io.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ck_addr_cmd_delay.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_dqs_found_cal.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_mc_phy.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_edge.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_skip_calib_tap.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_samp.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_data.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_top.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_byte_lane.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_init.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_mc_phy_wrapper.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_poc_pd.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_tempmon.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_poc_edge_store.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_4lanes.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_of_pre_fifo.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_wrlvl.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_dqs_found_cal_hr.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_po_cntlr.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_mc_simple_fifo.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_mc_r_channel.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_ctrl_addr_decode.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_ctrl_write.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_ddr_axi_register_slice.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_ddr_w_upsizer.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_ddr_axic_register_slice.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_ctrl_read.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_ddr_r_upsizer.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_mc_w_channel.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_ddr_comparator_sel_static.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_ddr_axi_upsizer.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_ddr_carry_or.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_ddr_comparator.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_mc_aw_channel.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_ctrl_reg.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_ctrl_top.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_mc_b_channel.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_mc_wr_cmd_fsm.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_mc_fifo.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_ddr_a_upsizer.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_ddr_carry_latch_and.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_ddr_command_fifo.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_mc_incr_cmd.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_ddr_carry_latch_or.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_mc_cmd_fsm.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_mc.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_ddr_carry_and.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_ctrl_reg_bank.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_mc_wrap_cmd.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_ddr_comparator_sel.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_mc_cmd_arbiter.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_mc_ar_channel.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/axi/mig_7series_v4_1_axi_mc_cmd_translator.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/ui/mig_7series_v4_1_ui_rd_data.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/ui/mig_7series_v4_1_ui_top.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/ui/mig_7series_v4_1_ui_wr_data.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/ui/mig_7series_v4_1_ui_cmd.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/ip_top/mig_7series_v4_1_mem_intfc.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/ip_top/mig_7series_v4_1_memc_ui_top_axi.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/ecc/mig_7series_v4_1_ecc_gen.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/ecc/mig_7series_v4_1_fi_xor.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/ecc/mig_7series_v4_1_ecc_merge_enc.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/ecc/mig_7series_v4_1_ecc_dec_fix.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/ecc/mig_7series_v4_1_ecc_buf.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/clocking/mig_7series_v4_1_iodelay_ctrl.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/clocking/mig_7series_v4_1_tempmon.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/clocking/mig_7series_v4_1_clk_ibuf.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/clocking/mig_7series_v4_1_infrastructure.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_round_robin_arb.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_bank_state.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_col_mach.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_arb_select.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_mc.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_rank_mach.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_bank_common.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_arb_mux.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_rank_common.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_bank_compare.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_bank_cntrl.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_rank_cntrl.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_arb_row_col.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_bank_queue.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/controller/mig_7series_v4_1_bank_mach.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/mig_7series_0_mig_sim.v" \
"../../../../mig_7series_0_ex.srcs/sources_1/ip/mig_7series_0/mig_7series_0/user_design/rtl/mig_7series_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

