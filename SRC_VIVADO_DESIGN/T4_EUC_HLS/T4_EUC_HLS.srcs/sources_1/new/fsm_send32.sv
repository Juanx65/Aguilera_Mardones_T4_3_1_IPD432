`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 4/12/2021
// Design Name: T2 IPD432
// Module Name: fsm_send32
// Autor Name: Juan Aguilera
// 
//////////////////////////////////////////////////////////////////////////////////

module fsm_send32
(
	input  logic clk, rst,
	input  logic [31:0] data,
    input  logic flag_ready_in,
    input  logic tx_busy,

    output logic [7:0] tx_data,
    output logic tx_send, flag_sent32
);

 logic [7:0] tx_data_nx;
 logic tx_send_nx;
 logic [1:0] contByte, contByte_nx;
 
 //FSM states type:
 typedef enum logic [3:0] {IDLE, BYTE_READY,SEND, ESPERA} state;
 state pr_state, nx_state;

 //FSM state register:
 always_ff @(posedge clk)
	if (rst) pr_state <= IDLE;
	else pr_state <= nx_state;

  initial tx_data = 'b0;
  initial contByte = 'b0;
  initial tx_send = 'b0;
  initial flag_sent32 = 'b0;
    
 //FSM combinational logic:
 always_comb begin
    tx_data_nx = tx_data;
    contByte_nx = 'b0;
    tx_send_nx = 'b0;
    nx_state = pr_state;
    flag_sent32 = 'b0;
    
	case (pr_state)
		IDLE:
            if(flag_ready_in)
                nx_state = BYTE_READY;
        BYTE_READY:
        begin
            tx_data_nx = data[contByte*8+:8];
            contByte_nx = contByte;
            if(~tx_busy)
                nx_state = SEND;
        end
        SEND:
        begin
            tx_send_nx = 'b1;
            contByte_nx = contByte + 1;
            if(contByte == 'd3) begin
                nx_state = IDLE;
                flag_sent32 = 'b1;
            end else
                nx_state = ESPERA;
        end
        ESPERA:
        begin
            contByte_nx = contByte;
            if(~tx_busy)
                nx_state = BYTE_READY;
        end
	endcase
 end

 //Optional output register (if required). It simply delays the combinational outputs to prevent propagation of glitches.
	always_ff @(posedge clk) begin
        tx_data <= tx_data_nx;
        contByte <= contByte_nx;
        tx_send <= tx_send_nx;
    end
    
endmodule