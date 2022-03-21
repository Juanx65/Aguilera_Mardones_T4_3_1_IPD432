`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 23/11/2021
// Design Name: T2 IPD432
// Module Name: UART_RX_Logic
// Autor Name: Juan Aguilera
// 
//////////////////////////////////////////////////////////////////////////////////

module CommandDecoder
(
    input logic clk, rst, enaC,
    input logic [7:0] Command,

    output logic [2:0] operation,
    output logic flag_process
);

   assign operation = Command[2:0];

    logic flag_process_pre;
    always_ff @(posedge clk) begin
        flag_process_pre <= enaC;
        flag_process <= flag_process_pre;
    end

endmodule