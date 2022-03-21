`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 23/11/2021
// Design Name: T2 IPD432
// Module Name: fsm_rx
// Autor Name: Juan Aguilera
// 
//////////////////////////////////////////////////////////////////////////////////

module fsm_rx_data_in
(
	input  logic clk, rst,
    input  logic [7:0] uart_data,       // from uart_rx, solo para
                                        // identificar entre estados..
    input  logic rx_ready_in,           // from uart_rx
    input  logic ena,                   // from fsm_tx
    input  logic flag_rx,               // from fsm_tx, permitira volver a idel

	output logic enaA, enaB, enaC,    // enable para cada BRAM y CommandDecoder
    output logic flag_tx,               // permite volver a idle luego de un
                                        // ciclo de lectura a fsm_rx
    output logic [7:0] command_data,
    output logic rx_ready_out   // permite iniciar fsm_rx ( write_to_bram_enable)
);

 logic [7:0] FirstByte, FirstByte_nx, command_data_nx;

  /*
  * parametrizaci?n de los comandos enviados por host para
  * controlar a donde van los bytes siguientes
  */
  localparam DATA_BRAM_A = 8'd1;
  localparam DATA_BRAM_B = 8'd2;
  localparam DATA_COMM_D = 8'd3;
  
 //FSM states type:
 typedef enum logic [5:0] {IDLE, FIRST_BYTE, COMM_DATA, SEND_COMM_DATA, WRITE_BRAM, END_WRITE} state;
 state pr_state, nx_state;

 //FSM state register:
 always_ff @(posedge clk)
	if (rst) pr_state <= IDLE;
	else pr_state <= nx_state;
  
  initial enaA = 'b0;
  initial enaB = 'b0;
  initial enaC = 'b0;
  initial flag_tx = 'b0;
  initial rx_ready_out  = 'b0;
  initial command_data  = 'b0;
  initial FirstByte = 'b0;
  
 //FSM combinational logic:
 always_comb begin
    flag_tx         = 'b0;
    enaA            = 'b0;
    enaB            = 'b0;
    enaC            = 'b0;
    rx_ready_out    = 'b0;
    FirstByte_nx    = FirstByte;
    command_data_nx = command_data;
    nx_state        = pr_state;

	case (pr_state)
		IDLE:
        begin
            if(rx_ready_in) begin
                FirstByte_nx = uart_data;
                nx_state = FIRST_BYTE;
            end
        end
        FIRST_BYTE:
        begin
            if(FirstByte == DATA_BRAM_A || FirstByte == DATA_BRAM_B)
                nx_state = WRITE_BRAM;
            else if(FirstByte == DATA_COMM_D)
                nx_state = COMM_DATA;
        end
        COMM_DATA:
        begin
            if(rx_ready_in) begin
                nx_state = SEND_COMM_DATA;
            end
        end
        SEND_COMM_DATA:
        begin
            enaC = 'b1;
            command_data_nx = uart_data;
            nx_state = IDLE;
            flag_tx = 'b1;
        end
        WRITE_BRAM:
        begin
                rx_ready_out  = rx_ready_in;
                if(FirstByte == DATA_BRAM_A)
                    enaA = ena;
                else if(FirstByte == DATA_BRAM_B)
                    enaB = ena;
                if( flag_rx )
                    nx_state = END_WRITE;
        end
        END_WRITE:
        begin
            flag_tx = 'b1;
            nx_state = IDLE;
        end
    endcase
 end

 //Optional output register (if required). It simply delays the combinational outputs to prevent propagation of glitches.
	always_ff @(posedge clk)begin
        command_data <= command_data_nx;
        FirstByte <= FirstByte_nx;
    end
 endmodule