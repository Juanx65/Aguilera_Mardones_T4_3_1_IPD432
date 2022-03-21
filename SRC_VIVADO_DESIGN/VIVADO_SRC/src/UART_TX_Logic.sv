`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 5/12/2021
// Design Name: T2 IPD432
// Module Name: UART_TX_Logic
// Autor Name: Juan Aguilera
// 
//////////////////////////////////////////////////////////////////////////////////

module UART_TX_Logic
#(parameter 
    BR_SIZE = 1024,
    BR_WIDTH = 10,
    CLK_FREQUENCY = 100000000,
	BAUD_RATE = 115200
)(
    input logic clk, rst,
    input logic [31:0] data32,
    input logic flag_ready32, flag_process,
    input logic [2:0] operation,

    output logic flag_sent32,
    output logic UART_TX
    );

    logic [7:0] tx_data32;
    logic tx_send32;
    logic tx_busy;

    fsm_send32 SEND32(
       .clk(clk),
       .rst(rst),
	   .data(data32),
       .flag_ready_in(flag_ready32),
       .tx_busy(tx_busy),

       .flag_sent32(flag_sent32),
       .tx_data(tx_data32),
       .tx_send(tx_send32)
   );
    
    // solo estamos usando la parte tx para este modulo.
    logic baud_tick;
    uart_baud_tick_gen #(
		.CLK_FREQUENCY(CLK_FREQUENCY),
		.BAUD_RATE(BAUD_RATE),
		.OVERSAMPLING(1)
	) baud_tick_blk (
		.clk(clk),
		.enable(tx_busy),
		.tick(baud_tick)
	);
	uart_tx uart_tx_blk (
		.clk(clk),
		.reset(rst),
		.baud_tick(baud_tick),
		.tx_start(tx_send32),
		.tx_data(tx_data32),
		.tx(UART_TX),
		.tx_busy(tx_busy)
	);

endmodule
