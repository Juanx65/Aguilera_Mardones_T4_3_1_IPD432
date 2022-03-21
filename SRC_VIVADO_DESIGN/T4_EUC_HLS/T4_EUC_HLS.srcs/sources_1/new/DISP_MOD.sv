`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2022 04:54:57
// Design Name: 
// Module Name: DISP_MOD
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DISP_MOD (
    input logic clk, rst,
    input logic [31:0] data32,
    input logic [2:0] operation,
    input logic flag_ready32,
    
    output logic [6:0] SEG,
    output logic [7:0] AN
    );
    
    localparam READ_VEC_A = 'd1;
    localparam READ_VEC_B = 'd2;
    localparam SUM_VEC = 'd3;
    localparam AVG_VEC = 'd4;
    localparam MAN_DIST = 'd5;
    localparam EUC_DIST = 'd6;
    
    logic [31:0] data_to_display;
    initial data_to_display = 'b0;
    always_ff @(posedge clk)
        if(flag_ready32)
            data_to_display <= data32;
        else
            data_to_display <= data_to_display;
            
    // 7 SEGMENT SECCION
    logic [31:0] data32_bcd; //data converted into bcd
    logic [31:0] data_display;
    logic [7:0] dist_type; 
    logic [7:0] anodo;  //indicate 7seg on/off
    
    assign anodo = (operation > AVG_VEC) ? 8'b1011_1111 : 8'b0;  //Instruction is about  distance
    assign dist_type = operation == EUC_DIST ? 8'b1111_1110: 8'b1101_1100;  //show EU if Euclidian / MA if Manhattan
    
    assign data_display = {dist_type, data32_bcd[23:0]};
    
    unsigned_to_bcd SEGM(   .clk(clk),
                            .trigger(1),
                            .in(data_to_display), //32bit
                            .idle(),
                            .bcd(data32_bcd) //32bit
                            );
            
    display DIS(.clk_in(clk), 
                .rst(rst), 
                .numero(data_display), 
                .an_on(anodo), 
                .sevenSeg(SEG), 
                .anodo(AN)); 
endmodule
