// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
// Version: 2021.1
// Copyright (C) Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module eucHW_sqrt_fixed_27_27_s (
        ap_clk,
        ap_rst,
        x,
        ap_return
);


input   ap_clk;
input   ap_rst;
input  [25:0] x;
output  [13:0] ap_return;

wire   [0:0] icmp_ln489_fu_202_p2;
reg   [0:0] icmp_ln489_reg_1203;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_state4_pp0_stage0_iter3;
wire    ap_block_state5_pp0_stage0_iter4;
wire    ap_block_state6_pp0_stage0_iter5;
wire    ap_block_state7_pp0_stage0_iter6;
wire    ap_block_pp0_stage0_11001;
wire   [29:0] x_l_I_V_25_fu_230_p3;
reg   [29:0] x_l_I_V_25_reg_1208;
wire   [0:0] icmp_ln489_1_fu_268_p2;
reg   [0:0] icmp_ln489_1_reg_1214;
wire   [4:0] sub_ln258_fu_274_p2;
reg   [4:0] sub_ln258_reg_1220;
wire   [29:0] x_l_I_V_27_fu_386_p3;
reg   [29:0] x_l_I_V_27_reg_1225;
wire   [13:0] res_I_V_26_fu_394_p3;
reg   [13:0] res_I_V_26_reg_1231;
wire   [0:0] icmp_ln489_3_fu_434_p2;
reg   [0:0] icmp_ln489_3_reg_1237;
wire   [6:0] sub_ln258_2_fu_440_p2;
reg   [6:0] sub_ln258_2_reg_1243;
wire   [29:0] x_l_I_V_29_fu_543_p3;
reg   [29:0] x_l_I_V_29_reg_1248;
wire   [13:0] res_I_V_28_fu_551_p3;
reg   [13:0] res_I_V_28_reg_1254;
wire   [0:0] icmp_ln489_5_fu_591_p2;
reg   [0:0] icmp_ln489_5_reg_1260;
wire   [8:0] sub_ln258_4_fu_597_p2;
reg   [8:0] sub_ln258_4_reg_1266;
wire   [29:0] x_l_I_V_30_fu_700_p3;
reg   [29:0] x_l_I_V_30_reg_1271;
wire   [13:0] res_I_V_fu_708_p3;
reg   [13:0] res_I_V_reg_1277;
wire   [0:0] icmp_ln489_7_fu_748_p2;
reg   [0:0] icmp_ln489_7_reg_1283;
wire   [10:0] sub_ln258_6_fu_754_p2;
reg   [10:0] sub_ln258_6_reg_1289;
wire   [29:0] x_l_I_V_32_fu_857_p3;
reg   [29:0] x_l_I_V_32_reg_1294;
wire   [13:0] res_I_V_31_fu_865_p3;
reg   [13:0] res_I_V_31_reg_1300;
wire   [0:0] icmp_ln489_9_fu_905_p2;
reg   [0:0] icmp_ln489_9_reg_1306;
wire   [12:0] sub_ln258_8_fu_911_p2;
reg   [12:0] sub_ln258_8_reg_1312;
wire   [29:0] x_l_I_V_34_fu_1014_p3;
reg   [29:0] x_l_I_V_34_reg_1317;
wire   [13:0] res_I_V_33_fu_1022_p3;
reg   [13:0] res_I_V_33_reg_1323;
wire   [0:0] icmp_ln489_11_fu_1062_p2;
reg   [0:0] icmp_ln489_11_reg_1329;
wire   [14:0] sub_ln258_10_fu_1068_p2;
reg   [14:0] sub_ln258_10_reg_1335;
wire    ap_block_pp0_stage0;
wire   [1:0] tmp_fu_188_p4;
wire   [2:0] zext_ln489_12_fu_198_p1;
wire   [2:0] add_ln258_fu_208_p2;
wire   [29:0] zext_ln712_fu_184_p1;
wire  signed [3:0] sext_ln323_fu_214_p1;
wire   [29:0] p_Result_38_fu_218_p5;
wire   [1:0] select_ln489_fu_238_p3;
wire   [2:0] tmp_2_fu_246_p3;
wire   [4:0] p_Result_5_fu_254_p4;
wire   [4:0] zext_ln489_fu_264_p1;
wire   [13:0] select_ln239_fu_280_p3;
wire   [29:0] p_Result_39_fu_287_p5;
wire   [13:0] p_Result_40_fu_297_p4;
wire   [13:0] res_I_V_25_fu_313_p3;
wire   [3:0] p_Result_8_fu_320_p4;
wire   [29:0] x_l_I_V_26_fu_307_p3;
wire   [4:0] tmp_3_fu_330_p3;
wire   [5:0] p_Result_9_fu_338_p4;
wire   [5:0] zext_ln489_1_fu_348_p1;
wire   [5:0] sub_ln258_1_fu_358_p2;
wire   [0:0] icmp_ln489_2_fu_352_p2;
wire   [29:0] p_Result_41_fu_364_p5;
wire   [13:0] p_Result_42_fu_376_p4;
wire   [4:0] p_Result_s_fu_402_p4;
wire   [5:0] tmp_4_fu_412_p3;
wire   [6:0] p_Result_1_fu_420_p4;
wire   [6:0] zext_ln489_2_fu_430_p1;
wire   [29:0] p_Result_43_fu_446_p5;
wire   [13:0] p_Result_44_fu_456_p4;
wire   [13:0] res_I_V_27_fu_471_p3;
wire   [5:0] p_Result_6_fu_477_p4;
wire   [29:0] x_l_I_V_28_fu_465_p3;
wire   [6:0] tmp_5_fu_487_p3;
wire   [7:0] p_Result_7_fu_495_p4;
wire   [7:0] zext_ln489_3_fu_505_p1;
wire   [7:0] sub_ln258_3_fu_515_p2;
wire   [0:0] icmp_ln489_4_fu_509_p2;
wire   [29:0] p_Result_45_fu_521_p5;
wire   [13:0] p_Result_46_fu_533_p4;
wire   [6:0] p_Result_12_fu_559_p4;
wire   [7:0] tmp_6_fu_569_p3;
wire   [8:0] p_Result_13_fu_577_p4;
wire   [8:0] zext_ln489_4_fu_587_p1;
wire   [29:0] p_Result_47_fu_603_p5;
wire   [13:0] p_Result_48_fu_613_p4;
wire   [13:0] res_I_V_29_fu_628_p3;
wire   [7:0] p_Result_15_fu_634_p4;
wire   [29:0] x_l_I_V_fu_622_p3;
wire   [8:0] tmp_7_fu_644_p3;
wire   [9:0] p_Result_16_fu_652_p4;
wire   [9:0] zext_ln489_5_fu_662_p1;
wire   [9:0] sub_ln258_5_fu_672_p2;
wire   [0:0] icmp_ln489_6_fu_666_p2;
wire   [29:0] p_Result_49_fu_678_p5;
wire   [13:0] p_Result_50_fu_690_p4;
wire   [8:0] p_Result_18_fu_716_p4;
wire   [9:0] tmp_8_fu_726_p3;
wire   [10:0] p_Result_19_fu_734_p4;
wire   [10:0] zext_ln489_6_fu_744_p1;
wire   [29:0] p_Result_51_fu_760_p5;
wire   [13:0] p_Result_52_fu_770_p4;
wire   [13:0] res_I_V_30_fu_785_p3;
wire   [9:0] p_Result_21_fu_791_p4;
wire   [29:0] x_l_I_V_31_fu_779_p3;
wire   [10:0] tmp_9_fu_801_p3;
wire   [11:0] p_Result_22_fu_809_p4;
wire   [11:0] zext_ln489_7_fu_819_p1;
wire   [11:0] sub_ln258_7_fu_829_p2;
wire   [0:0] icmp_ln489_8_fu_823_p2;
wire   [29:0] p_Result_53_fu_835_p5;
wire   [13:0] p_Result_54_fu_847_p4;
wire   [10:0] p_Result_24_fu_873_p4;
wire   [11:0] tmp_s_fu_883_p3;
wire   [12:0] p_Result_25_fu_891_p4;
wire   [12:0] zext_ln489_8_fu_901_p1;
wire   [29:0] p_Result_55_fu_917_p5;
wire   [13:0] p_Result_56_fu_927_p4;
wire   [13:0] res_I_V_32_fu_942_p3;
wire   [11:0] p_Result_27_fu_948_p4;
wire   [29:0] x_l_I_V_33_fu_936_p3;
wire   [12:0] tmp_1_fu_958_p3;
wire   [13:0] p_Result_28_fu_966_p4;
wire   [13:0] zext_ln489_9_fu_976_p1;
wire   [13:0] sub_ln258_9_fu_986_p2;
wire   [0:0] icmp_ln489_10_fu_980_p2;
wire   [29:0] p_Result_57_fu_992_p5;
wire   [13:0] p_Result_58_fu_1004_p4;
wire   [12:0] p_Result_30_fu_1030_p4;
wire   [13:0] tmp_10_fu_1040_p3;
wire   [14:0] p_Result_31_fu_1048_p4;
wire   [14:0] zext_ln489_10_fu_1058_p1;
wire   [29:0] p_Result_59_fu_1074_p5;
wire   [13:0] p_Result_60_fu_1084_p4;
wire   [13:0] res_I_V_34_fu_1099_p3;
wire   [29:0] x_l_I_V_35_fu_1093_p3;
wire   [14:0] tmp_11_fu_1105_p3;
wire   [15:0] trunc_ln640_fu_1113_p1;
wire   [15:0] zext_ln489_11_fu_1117_p1;
wire   [15:0] sub_ln258_11_fu_1127_p2;
wire   [0:0] icmp_ln489_12_fu_1121_p2;
wire   [29:0] p_Result_61_fu_1133_p5;
wire   [13:0] p_Result_62_fu_1145_p4;
wire   [13:0] res_I_V_35_fu_1163_p3;
wire   [27:0] mul_I_V_fu_1171_p3;
wire   [29:0] x_l_I_V_36_fu_1155_p3;
wire   [29:0] zext_ln717_fu_1179_p1;
wire   [0:0] p_Result_s_54_fu_1183_p2;
wire   [13:0] res_I_V_23_fu_1189_p2;
reg   [25:0] x_int_reg;
wire    ap_ce_reg;

always @ (posedge ap_clk) begin
    x_int_reg <= x;
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        icmp_ln489_11_reg_1329 <= icmp_ln489_11_fu_1062_p2;
        icmp_ln489_1_reg_1214 <= icmp_ln489_1_fu_268_p2;
        icmp_ln489_3_reg_1237 <= icmp_ln489_3_fu_434_p2;
        icmp_ln489_5_reg_1260 <= icmp_ln489_5_fu_591_p2;
        icmp_ln489_7_reg_1283 <= icmp_ln489_7_fu_748_p2;
        icmp_ln489_9_reg_1306 <= icmp_ln489_9_fu_905_p2;
        icmp_ln489_reg_1203 <= icmp_ln489_fu_202_p2;
        res_I_V_26_reg_1231 <= res_I_V_26_fu_394_p3;
        res_I_V_28_reg_1254 <= res_I_V_28_fu_551_p3;
        res_I_V_31_reg_1300 <= res_I_V_31_fu_865_p3;
        res_I_V_33_reg_1323 <= res_I_V_33_fu_1022_p3;
        res_I_V_reg_1277 <= res_I_V_fu_708_p3;
        sub_ln258_10_reg_1335 <= sub_ln258_10_fu_1068_p2;
        sub_ln258_2_reg_1243 <= sub_ln258_2_fu_440_p2;
        sub_ln258_4_reg_1266 <= sub_ln258_4_fu_597_p2;
        sub_ln258_6_reg_1289 <= sub_ln258_6_fu_754_p2;
        sub_ln258_8_reg_1312 <= sub_ln258_8_fu_911_p2;
        sub_ln258_reg_1220 <= sub_ln258_fu_274_p2;
        x_l_I_V_25_reg_1208 <= x_l_I_V_25_fu_230_p3;
        x_l_I_V_27_reg_1225 <= x_l_I_V_27_fu_386_p3;
        x_l_I_V_29_reg_1248 <= x_l_I_V_29_fu_543_p3;
        x_l_I_V_30_reg_1271 <= x_l_I_V_30_fu_700_p3;
        x_l_I_V_32_reg_1294 <= x_l_I_V_32_fu_857_p3;
        x_l_I_V_34_reg_1317 <= x_l_I_V_34_fu_1014_p3;
    end
end

assign add_ln258_fu_208_p2 = ($signed(zext_ln489_12_fu_198_p1) + $signed(3'd7));

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage0_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage0_iter4 = ~(1'b1 == 1'b1);

assign ap_block_state6_pp0_stage0_iter5 = ~(1'b1 == 1'b1);

assign ap_block_state7_pp0_stage0_iter6 = ~(1'b1 == 1'b1);

assign ap_return = ((p_Result_s_54_fu_1183_p2[0:0] == 1'b1) ? res_I_V_23_fu_1189_p2 : res_I_V_35_fu_1163_p3);

assign icmp_ln489_10_fu_980_p2 = ((p_Result_28_fu_966_p4 < zext_ln489_9_fu_976_p1) ? 1'b1 : 1'b0);

assign icmp_ln489_11_fu_1062_p2 = ((p_Result_31_fu_1048_p4 < zext_ln489_10_fu_1058_p1) ? 1'b1 : 1'b0);

assign icmp_ln489_12_fu_1121_p2 = ((trunc_ln640_fu_1113_p1 < zext_ln489_11_fu_1117_p1) ? 1'b1 : 1'b0);

assign icmp_ln489_1_fu_268_p2 = ((p_Result_5_fu_254_p4 < zext_ln489_fu_264_p1) ? 1'b1 : 1'b0);

assign icmp_ln489_2_fu_352_p2 = ((p_Result_9_fu_338_p4 < zext_ln489_1_fu_348_p1) ? 1'b1 : 1'b0);

assign icmp_ln489_3_fu_434_p2 = ((p_Result_1_fu_420_p4 < zext_ln489_2_fu_430_p1) ? 1'b1 : 1'b0);

assign icmp_ln489_4_fu_509_p2 = ((p_Result_7_fu_495_p4 < zext_ln489_3_fu_505_p1) ? 1'b1 : 1'b0);

assign icmp_ln489_5_fu_591_p2 = ((p_Result_13_fu_577_p4 < zext_ln489_4_fu_587_p1) ? 1'b1 : 1'b0);

assign icmp_ln489_6_fu_666_p2 = ((p_Result_16_fu_652_p4 < zext_ln489_5_fu_662_p1) ? 1'b1 : 1'b0);

assign icmp_ln489_7_fu_748_p2 = ((p_Result_19_fu_734_p4 < zext_ln489_6_fu_744_p1) ? 1'b1 : 1'b0);

assign icmp_ln489_8_fu_823_p2 = ((p_Result_22_fu_809_p4 < zext_ln489_7_fu_819_p1) ? 1'b1 : 1'b0);

assign icmp_ln489_9_fu_905_p2 = ((p_Result_25_fu_891_p4 < zext_ln489_8_fu_901_p1) ? 1'b1 : 1'b0);

assign icmp_ln489_fu_202_p2 = ((tmp_fu_188_p4 == 2'd0) ? 1'b1 : 1'b0);

assign mul_I_V_fu_1171_p3 = {{14'd0}, {res_I_V_35_fu_1163_p3}};

assign p_Result_12_fu_559_p4 = {{res_I_V_28_fu_551_p3[13:7]}};

assign p_Result_13_fu_577_p4 = {{x_l_I_V_29_fu_543_p3[22:14]}};

assign p_Result_15_fu_634_p4 = {{res_I_V_29_fu_628_p3[13:6]}};

assign p_Result_16_fu_652_p4 = {{x_l_I_V_fu_622_p3[21:12]}};

assign p_Result_18_fu_716_p4 = {{res_I_V_fu_708_p3[13:5]}};

assign p_Result_19_fu_734_p4 = {{x_l_I_V_30_fu_700_p3[20:10]}};

assign p_Result_1_fu_420_p4 = {{x_l_I_V_27_fu_386_p3[24:18]}};

assign p_Result_21_fu_791_p4 = {{res_I_V_30_fu_785_p3[13:4]}};

assign p_Result_22_fu_809_p4 = {{x_l_I_V_31_fu_779_p3[19:8]}};

assign p_Result_24_fu_873_p4 = {{res_I_V_31_fu_865_p3[13:3]}};

assign p_Result_25_fu_891_p4 = {{x_l_I_V_32_fu_857_p3[18:6]}};

assign p_Result_27_fu_948_p4 = {{res_I_V_32_fu_942_p3[13:2]}};

assign p_Result_28_fu_966_p4 = {{x_l_I_V_33_fu_936_p3[17:4]}};

assign p_Result_30_fu_1030_p4 = {{res_I_V_33_fu_1022_p3[13:1]}};

assign p_Result_31_fu_1048_p4 = {{x_l_I_V_34_fu_1014_p3[16:2]}};

assign p_Result_38_fu_218_p5 = {{zext_ln712_fu_184_p1[29:28]}, {sext_ln323_fu_214_p1}, {zext_ln712_fu_184_p1[23:0]}};

assign p_Result_39_fu_287_p5 = {{x_l_I_V_25_reg_1208[29:27]}, {sub_ln258_reg_1220}, {x_l_I_V_25_reg_1208[21:0]}};

assign p_Result_40_fu_297_p4 = {select_ln239_fu_280_p3[14 - 1:12], |(1'd1), select_ln239_fu_280_p3[10:0]};

assign p_Result_41_fu_364_p5 = {{x_l_I_V_26_fu_307_p3[29:26]}, {sub_ln258_1_fu_358_p2}, {x_l_I_V_26_fu_307_p3[19:0]}};

assign p_Result_42_fu_376_p4 = {res_I_V_25_fu_313_p3[14 - 1:11], |(1'd1), res_I_V_25_fu_313_p3[9:0]};

assign p_Result_43_fu_446_p5 = {{x_l_I_V_27_reg_1225[29:25]}, {sub_ln258_2_reg_1243}, {x_l_I_V_27_reg_1225[17:0]}};

assign p_Result_44_fu_456_p4 = {res_I_V_26_reg_1231[14 - 1:10], |(1'd1), res_I_V_26_reg_1231[8:0]};

assign p_Result_45_fu_521_p5 = {{x_l_I_V_28_fu_465_p3[29:24]}, {sub_ln258_3_fu_515_p2}, {x_l_I_V_28_fu_465_p3[15:0]}};

assign p_Result_46_fu_533_p4 = {res_I_V_27_fu_471_p3[14 - 1:9], |(1'd1), res_I_V_27_fu_471_p3[7:0]};

assign p_Result_47_fu_603_p5 = {{x_l_I_V_29_reg_1248[29:23]}, {sub_ln258_4_reg_1266}, {x_l_I_V_29_reg_1248[13:0]}};

assign p_Result_48_fu_613_p4 = {res_I_V_28_reg_1254[14 - 1:8], |(1'd1), res_I_V_28_reg_1254[6:0]};

assign p_Result_49_fu_678_p5 = {{x_l_I_V_fu_622_p3[29:22]}, {sub_ln258_5_fu_672_p2}, {x_l_I_V_fu_622_p3[11:0]}};

assign p_Result_50_fu_690_p4 = {res_I_V_29_fu_628_p3[14 - 1:7], |(1'd1), res_I_V_29_fu_628_p3[5:0]};

assign p_Result_51_fu_760_p5 = {{x_l_I_V_30_reg_1271[29:21]}, {sub_ln258_6_reg_1289}, {x_l_I_V_30_reg_1271[9:0]}};

assign p_Result_52_fu_770_p4 = {res_I_V_reg_1277[14 - 1:6], |(1'd1), res_I_V_reg_1277[4:0]};

assign p_Result_53_fu_835_p5 = {{x_l_I_V_31_fu_779_p3[29:20]}, {sub_ln258_7_fu_829_p2}, {x_l_I_V_31_fu_779_p3[7:0]}};

assign p_Result_54_fu_847_p4 = {res_I_V_30_fu_785_p3[14 - 1:5], |(1'd1), res_I_V_30_fu_785_p3[3:0]};

assign p_Result_55_fu_917_p5 = {{x_l_I_V_32_reg_1294[29:19]}, {sub_ln258_8_reg_1312}, {x_l_I_V_32_reg_1294[5:0]}};

assign p_Result_56_fu_927_p4 = {res_I_V_31_reg_1300[14 - 1:4], |(1'd1), res_I_V_31_reg_1300[2:0]};

assign p_Result_57_fu_992_p5 = {{x_l_I_V_33_fu_936_p3[29:18]}, {sub_ln258_9_fu_986_p2}, {x_l_I_V_33_fu_936_p3[3:0]}};

assign p_Result_58_fu_1004_p4 = {res_I_V_32_fu_942_p3[14 - 1:3], |(1'd1), res_I_V_32_fu_942_p3[1:0]};

assign p_Result_59_fu_1074_p5 = {{x_l_I_V_34_reg_1317[29:17]}, {sub_ln258_10_reg_1335}, {x_l_I_V_34_reg_1317[1:0]}};

assign p_Result_5_fu_254_p4 = {{x_l_I_V_25_fu_230_p3[26:22]}};

assign p_Result_60_fu_1084_p4 = {res_I_V_33_reg_1323[14 - 1:2], |(1'd1), res_I_V_33_reg_1323[0:0]};

assign p_Result_61_fu_1133_p5 = {{x_l_I_V_35_fu_1093_p3[29:16]}, {sub_ln258_11_fu_1127_p2}};

assign p_Result_62_fu_1145_p4 = {res_I_V_34_fu_1099_p3[14-1:1], |(1'd1)};

assign p_Result_6_fu_477_p4 = {{res_I_V_27_fu_471_p3[13:8]}};

assign p_Result_7_fu_495_p4 = {{x_l_I_V_28_fu_465_p3[23:16]}};

assign p_Result_8_fu_320_p4 = {{res_I_V_25_fu_313_p3[13:10]}};

assign p_Result_9_fu_338_p4 = {{x_l_I_V_26_fu_307_p3[25:20]}};

assign p_Result_s_54_fu_1183_p2 = ((x_l_I_V_36_fu_1155_p3 > zext_ln717_fu_1179_p1) ? 1'b1 : 1'b0);

assign p_Result_s_fu_402_p4 = {{res_I_V_26_fu_394_p3[13:9]}};

assign res_I_V_23_fu_1189_p2 = (res_I_V_35_fu_1163_p3 + 14'd1);

assign res_I_V_25_fu_313_p3 = ((icmp_ln489_1_reg_1214[0:0] == 1'b1) ? select_ln239_fu_280_p3 : p_Result_40_fu_297_p4);

assign res_I_V_26_fu_394_p3 = ((icmp_ln489_2_fu_352_p2[0:0] == 1'b1) ? res_I_V_25_fu_313_p3 : p_Result_42_fu_376_p4);

assign res_I_V_27_fu_471_p3 = ((icmp_ln489_3_reg_1237[0:0] == 1'b1) ? res_I_V_26_reg_1231 : p_Result_44_fu_456_p4);

assign res_I_V_28_fu_551_p3 = ((icmp_ln489_4_fu_509_p2[0:0] == 1'b1) ? res_I_V_27_fu_471_p3 : p_Result_46_fu_533_p4);

assign res_I_V_29_fu_628_p3 = ((icmp_ln489_5_reg_1260[0:0] == 1'b1) ? res_I_V_28_reg_1254 : p_Result_48_fu_613_p4);

assign res_I_V_30_fu_785_p3 = ((icmp_ln489_7_reg_1283[0:0] == 1'b1) ? res_I_V_reg_1277 : p_Result_52_fu_770_p4);

assign res_I_V_31_fu_865_p3 = ((icmp_ln489_8_fu_823_p2[0:0] == 1'b1) ? res_I_V_30_fu_785_p3 : p_Result_54_fu_847_p4);

assign res_I_V_32_fu_942_p3 = ((icmp_ln489_9_reg_1306[0:0] == 1'b1) ? res_I_V_31_reg_1300 : p_Result_56_fu_927_p4);

assign res_I_V_33_fu_1022_p3 = ((icmp_ln489_10_fu_980_p2[0:0] == 1'b1) ? res_I_V_32_fu_942_p3 : p_Result_58_fu_1004_p4);

assign res_I_V_34_fu_1099_p3 = ((icmp_ln489_11_reg_1329[0:0] == 1'b1) ? res_I_V_33_reg_1323 : p_Result_60_fu_1084_p4);

assign res_I_V_35_fu_1163_p3 = ((icmp_ln489_12_fu_1121_p2[0:0] == 1'b1) ? res_I_V_34_fu_1099_p3 : p_Result_62_fu_1145_p4);

assign res_I_V_fu_708_p3 = ((icmp_ln489_6_fu_666_p2[0:0] == 1'b1) ? res_I_V_29_fu_628_p3 : p_Result_50_fu_690_p4);

assign select_ln239_fu_280_p3 = ((icmp_ln489_reg_1203[0:0] == 1'b1) ? 14'd0 : 14'd4096);

assign select_ln489_fu_238_p3 = ((icmp_ln489_fu_202_p2[0:0] == 1'b1) ? 2'd0 : 2'd2);

assign sext_ln323_fu_214_p1 = $signed(add_ln258_fu_208_p2);

assign sub_ln258_10_fu_1068_p2 = (p_Result_31_fu_1048_p4 - zext_ln489_10_fu_1058_p1);

assign sub_ln258_11_fu_1127_p2 = (trunc_ln640_fu_1113_p1 - zext_ln489_11_fu_1117_p1);

assign sub_ln258_1_fu_358_p2 = (p_Result_9_fu_338_p4 - zext_ln489_1_fu_348_p1);

assign sub_ln258_2_fu_440_p2 = (p_Result_1_fu_420_p4 - zext_ln489_2_fu_430_p1);

assign sub_ln258_3_fu_515_p2 = (p_Result_7_fu_495_p4 - zext_ln489_3_fu_505_p1);

assign sub_ln258_4_fu_597_p2 = (p_Result_13_fu_577_p4 - zext_ln489_4_fu_587_p1);

assign sub_ln258_5_fu_672_p2 = (p_Result_16_fu_652_p4 - zext_ln489_5_fu_662_p1);

assign sub_ln258_6_fu_754_p2 = (p_Result_19_fu_734_p4 - zext_ln489_6_fu_744_p1);

assign sub_ln258_7_fu_829_p2 = (p_Result_22_fu_809_p4 - zext_ln489_7_fu_819_p1);

assign sub_ln258_8_fu_911_p2 = (p_Result_25_fu_891_p4 - zext_ln489_8_fu_901_p1);

assign sub_ln258_9_fu_986_p2 = (p_Result_28_fu_966_p4 - zext_ln489_9_fu_976_p1);

assign sub_ln258_fu_274_p2 = (p_Result_5_fu_254_p4 - zext_ln489_fu_264_p1);

assign tmp_10_fu_1040_p3 = {{p_Result_30_fu_1030_p4}, {1'd1}};

assign tmp_11_fu_1105_p3 = {{res_I_V_34_fu_1099_p3}, {1'd1}};

assign tmp_1_fu_958_p3 = {{p_Result_27_fu_948_p4}, {1'd1}};

assign tmp_2_fu_246_p3 = {{select_ln489_fu_238_p3}, {1'd1}};

assign tmp_3_fu_330_p3 = {{p_Result_8_fu_320_p4}, {1'd1}};

assign tmp_4_fu_412_p3 = {{p_Result_s_fu_402_p4}, {1'd1}};

assign tmp_5_fu_487_p3 = {{p_Result_6_fu_477_p4}, {1'd1}};

assign tmp_6_fu_569_p3 = {{p_Result_12_fu_559_p4}, {1'd1}};

assign tmp_7_fu_644_p3 = {{p_Result_15_fu_634_p4}, {1'd1}};

assign tmp_8_fu_726_p3 = {{p_Result_18_fu_716_p4}, {1'd1}};

assign tmp_9_fu_801_p3 = {{p_Result_21_fu_791_p4}, {1'd1}};

assign tmp_fu_188_p4 = {{x_int_reg[25:24]}};

assign tmp_s_fu_883_p3 = {{p_Result_24_fu_873_p4}, {1'd1}};

assign trunc_ln640_fu_1113_p1 = x_l_I_V_35_fu_1093_p3[15:0];

assign x_l_I_V_25_fu_230_p3 = ((icmp_ln489_fu_202_p2[0:0] == 1'b1) ? zext_ln712_fu_184_p1 : p_Result_38_fu_218_p5);

assign x_l_I_V_26_fu_307_p3 = ((icmp_ln489_1_reg_1214[0:0] == 1'b1) ? x_l_I_V_25_reg_1208 : p_Result_39_fu_287_p5);

assign x_l_I_V_27_fu_386_p3 = ((icmp_ln489_2_fu_352_p2[0:0] == 1'b1) ? x_l_I_V_26_fu_307_p3 : p_Result_41_fu_364_p5);

assign x_l_I_V_28_fu_465_p3 = ((icmp_ln489_3_reg_1237[0:0] == 1'b1) ? x_l_I_V_27_reg_1225 : p_Result_43_fu_446_p5);

assign x_l_I_V_29_fu_543_p3 = ((icmp_ln489_4_fu_509_p2[0:0] == 1'b1) ? x_l_I_V_28_fu_465_p3 : p_Result_45_fu_521_p5);

assign x_l_I_V_30_fu_700_p3 = ((icmp_ln489_6_fu_666_p2[0:0] == 1'b1) ? x_l_I_V_fu_622_p3 : p_Result_49_fu_678_p5);

assign x_l_I_V_31_fu_779_p3 = ((icmp_ln489_7_reg_1283[0:0] == 1'b1) ? x_l_I_V_30_reg_1271 : p_Result_51_fu_760_p5);

assign x_l_I_V_32_fu_857_p3 = ((icmp_ln489_8_fu_823_p2[0:0] == 1'b1) ? x_l_I_V_31_fu_779_p3 : p_Result_53_fu_835_p5);

assign x_l_I_V_33_fu_936_p3 = ((icmp_ln489_9_reg_1306[0:0] == 1'b1) ? x_l_I_V_32_reg_1294 : p_Result_55_fu_917_p5);

assign x_l_I_V_34_fu_1014_p3 = ((icmp_ln489_10_fu_980_p2[0:0] == 1'b1) ? x_l_I_V_33_fu_936_p3 : p_Result_57_fu_992_p5);

assign x_l_I_V_35_fu_1093_p3 = ((icmp_ln489_11_reg_1329[0:0] == 1'b1) ? x_l_I_V_34_reg_1317 : p_Result_59_fu_1074_p5);

assign x_l_I_V_36_fu_1155_p3 = ((icmp_ln489_12_fu_1121_p2[0:0] == 1'b1) ? x_l_I_V_35_fu_1093_p3 : p_Result_61_fu_1133_p5);

assign x_l_I_V_fu_622_p3 = ((icmp_ln489_5_reg_1260[0:0] == 1'b1) ? x_l_I_V_29_reg_1248 : p_Result_47_fu_603_p5);

assign zext_ln489_10_fu_1058_p1 = tmp_10_fu_1040_p3;

assign zext_ln489_11_fu_1117_p1 = tmp_11_fu_1105_p3;

assign zext_ln489_12_fu_198_p1 = tmp_fu_188_p4;

assign zext_ln489_1_fu_348_p1 = tmp_3_fu_330_p3;

assign zext_ln489_2_fu_430_p1 = tmp_4_fu_412_p3;

assign zext_ln489_3_fu_505_p1 = tmp_5_fu_487_p3;

assign zext_ln489_4_fu_587_p1 = tmp_6_fu_569_p3;

assign zext_ln489_5_fu_662_p1 = tmp_7_fu_644_p3;

assign zext_ln489_6_fu_744_p1 = tmp_8_fu_726_p3;

assign zext_ln489_7_fu_819_p1 = tmp_9_fu_801_p3;

assign zext_ln489_8_fu_901_p1 = tmp_s_fu_883_p3;

assign zext_ln489_9_fu_976_p1 = tmp_1_fu_958_p3;

assign zext_ln489_fu_264_p1 = tmp_2_fu_246_p3;

assign zext_ln712_fu_184_p1 = x_int_reg;

assign zext_ln717_fu_1179_p1 = mul_I_V_fu_1171_p3;

endmodule //eucHW_sqrt_fixed_27_27_s
