`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2021 16:52:47
// Design Name: 
// Module Name: clk_divider
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


module clk_divider
#(parameter frec = 1, frec_in = 100000000)
(
input logic clk_in, 
input logic rst,
output logic clk_out
 );
 
 localparam COUNTER_MAX = frec_in/(2*frec);
 localparam BITWIDTH = $clog2(COUNTER_MAX+1);
 
 logic clk_next;
 logic [BITWIDTH-1:0] count;
 logic [BITWIDTH-1:0] count_next; 
 
 always_ff @(posedge clk_in) begin
    clk_out <= clk_next;
    count <= count_next;
 end
 
 always_comb begin
    if (rst) begin
        count_next = 'd0;
        clk_next = 0;
    end
    else begin 
        if (count == COUNTER_MAX -1) begin
            clk_next = ~clk_out;
            count_next = 'd0;
        end
        else begin
            clk_next = clk_out;
            count_next = count + 1;
        end
    end
end
 
endmodule
