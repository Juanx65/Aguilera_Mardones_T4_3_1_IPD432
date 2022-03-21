`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 23/11/2021
// Design Name: T2 IPD432
// Module Name: UART_RX_Logic
// Autor Name: Juan Aguilera
// 
//////////////////////////////////////////////////////////////////////////////////

module UART_RX_Logic
#(parameter
	BR_SIZE = 1024, //Largo del Vector a almacenar en BRAM
	BR_WIDTH = 10,   // log2(BR_SIZE)
	CLK_FREQUENCY = 100000000,
	BAUD_RATE = 115200
)(
    input logic clk, rst,
    input logic rx, // data que viene desde el host
    
    output logic [7:0] CD_Data, // data out a CommandDecoder
    output logic [7:0] Data,  // data out a BRAM
    output logic enaA, // enable memory write A
    output logic enaB, // enable memory weite B
    output logic enaC,
    output logic [BR_WIDTH-1:0] addra // direccion en memoria bram A
);
    logic [7:0] host_byte; // data en bytes proveniente del host
    logic rx_ready, rx_ready_pre, rx_ready_sync; // sincronizaci?n necesaria para obtener correctamente los datos de rx_ready
    
    // solo estamos usando la parte rx para este modulo.
    logic baud8_tick;
    uart_baud_tick_gen #(
		.CLK_FREQUENCY(CLK_FREQUENCY),
		.BAUD_RATE(BAUD_RATE),
		.OVERSAMPLING(8)
	) baud8_tick_blk (
		.clk(clk),
		.enable(1'b1),
		.tick(baud8_tick)
	);
	uart_rx uart_rx_blk (
		.clk(clk),
		.reset(rst),
		.baud8_tick(baud8_tick),
		.rx(rx),
		.rx_data(host_byte),
		.rx_ready(rx_ready_pre)
	);
	
	always @(posedge clk) begin
		rx_ready_sync <= rx_ready_pre;
		rx_ready <= ~rx_ready_sync & rx_ready_pre;
	end
    
    logic flag_rx, flag_tx, ena_fsm, rx_ready_fsm;
    fsm_rx#(.BR_SIZE(BR_SIZE),.BR_WIDTH(BR_WIDTH)) FSMRX
            (.clk(clk), .rst(rst),
	         .rx_data(host_byte),
             .flag_tx(flag_tx),
             .rx_ready(rx_ready_fsm),
             .ena(ena_fsm),
             .addra(addra),
             .din(Data),
             .flag_rx(flag_rx)
    );
    fsm_rx_data_in fsmru (
        .clk(clk), .rst(rst),
        .uart_data(host_byte),       
        .rx_ready_in(rx_ready),
        .ena(ena_fsm), .flag_rx(flag_rx),               
	    .enaA(enaA), .enaB(enaB), .enaC(enaC),    // enable para cada BRAM y CommandDecoder
        .flag_tx(flag_tx),            
        .command_data(CD_Data),
        .rx_ready_out(rx_ready_fsm)
    );
    /**
        // ILA
	ila_0 ila_test (
	   .clk(clk), // input wire clk
	   .probe0(host_byte), // input wire [7:0]  probe0  
	   .probe1(Data), // input wire [0:0]  probe1 
	   .probe2(addra), // input wire [0:0]  probe2
	   .probe3(ena_fsm),
	   .probe4(rx_ready_fsm)
);
*/
endmodule
