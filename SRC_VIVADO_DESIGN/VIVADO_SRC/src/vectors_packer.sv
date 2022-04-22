`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2022 18:54:15
// Design Name: 
// Module Name: vectors_packer
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


module vectors_packer  
    #(parameter NBITS = 8, BR_SIZE = 1024)
    
    (
    input logic   [NBITS-1:0] A [BR_SIZE-1 :0],
    input logic [NBITS-1:0]B[BR_SIZE-1 :0],
    
    input logic A_ce0, B_ce0,
    
    input clk,
    
    output logic [NBITS*BR_SIZE/2-1:0] Awp,
    output logic [NBITS*BR_SIZE/2-1:0] Bwp

    
    );
    
    
            
    logic [NBITS*BR_SIZE-1:0] Awrapped;
    logic [NBITS*BR_SIZE-1:0] Bwrapped;

    genvar k;
        
    generate 
        for (k= 0; k < BR_SIZE ; k++) begin
            always_comb begin
               Awrapped[(k+1)*NBITS-1: NBITS*k] = A[k];
               Bwrapped[(k+1)*NBITS-1: NBITS*k] = B[k];
                
            end
        end
    endgenerate
    
    
    
    
    logic  A_syc, B_syc, A_pre, B_pre;
    
    always_ff @(posedge clk) begin
        A_pre <= A_ce0;
        B_pre <= B_ce0;
		A_syc <= A_pre;
		B_syc <= B_pre;
	end
    
    assign Awp = (A_syc)? Awrapped[NBITS*BR_SIZE/2-1:0]:Awrapped[NBITS*BR_SIZE-1:NBITS*BR_SIZE/2];
    assign Bwp = (B_syc)? Bwrapped[NBITS*BR_SIZE/2-1:0]:Bwrapped[NBITS*BR_SIZE-1:NBITS*BR_SIZE/2];
    
    
endmodule
