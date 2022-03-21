`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 23/11/2021
// Design Name: T2 IPD432
// Module Name: fsm_tx
// Autor Name: Juan Aguilera
// 
//////////////////////////////////////////////////////////////////////////////////

module fsm_rx
#(parameter
	BR_SIZE = 1024,
	BR_WIDTH = 10
)
(
	input  logic clk, rst,
	input  logic [7:0] rx_data,
    input  logic flag_tx,
    input  logic rx_ready,

	output logic ena,
    output logic [BR_WIDTH-1:0] addra, // $clog(BR_SIZE)-1
    output logic [7:0] din,
    output logic flag_rx
);

 logic ena_nx;
 logic [BR_WIDTH-1:0] addra_nx; //$clog(BR_SIZE)-1
 logic [7:0] din_nx;
 logic flag_rx_nx;
 logic [1:0] cont_ciclo,cont_ciclo_nx;
 
 //FSM states type:
 typedef enum logic [3:0] {IDLE, ESCRIBE, AVANZA, ESPERA} state;
 state pr_state, nx_state;

 //FSM state register:
 always_ff @(posedge clk)
	if (rst) pr_state <= IDLE;
	else pr_state <= nx_state;
  
  initial addra = 'b0;
  initial flag_rx = 'b0;
  initial ena = 'b0;
  initial din = 'b0;
  initial cont_ciclo = 'b0;
  
 //FSM combinational logic:
 always_comb begin
    ena_nx     = 'b0;
    addra_nx   = addra;
    din_nx     = rx_data;
    flag_rx_nx = 'b0;
    cont_ciclo_nx = 'b0;
    nx_state = pr_state;
	case (pr_state)
		IDLE:
        begin
            if(rx_ready)
                nx_state = ESCRIBE;
        end

        ESCRIBE:
        begin
            ena_nx = 'b1;
            nx_state = AVANZA;
        end

        AVANZA:
        begin
            addra_nx = addra + 'b1;
            if(addra == BR_SIZE-1)
                nx_state = ESPERA;
            else
                nx_state = IDLE;
        end

        ESPERA:
        begin
            flag_rx_nx = 'b1;
            if(flag_tx)
                nx_state = IDLE;
        end
	endcase
 end

 //Optional output register (if required). It simply delays the combinational outputs to prevent propagation of glitches.
	always_ff @(posedge clk)begin
        ena     <= ena_nx;
		addra   <= addra_nx;
        din     <= din_nx;
        flag_rx <= flag_rx_nx;
        cont_ciclo <= cont_ciclo_nx;
    end
 endmodule