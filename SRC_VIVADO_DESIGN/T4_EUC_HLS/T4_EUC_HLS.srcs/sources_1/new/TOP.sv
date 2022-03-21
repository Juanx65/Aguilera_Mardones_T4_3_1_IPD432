`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 23/11/2021
// Design Name: T2 IPD432
// Module Name: TOP
// Autor Name: Juan Aguilera
// 
//////////////////////////////////////////////////////////////////////////////////

module TOP 
#(parameter 
    BR_SIZE = 1024,
    CLK_FREQUENCY = 100000000,
	BAUD_RATE = 115200,
	NBITS = 8
)(
    input logic CLK100MHZ,
    input logic CPU_RESETN,
    input logic UART_RX,
    
    output logic UART_TX,
    output logic [6:0] SEG,
    output logic [7:0] AN
);

    localparam BR_WIDTH = $clog2(BR_SIZE);

    logic [NBITS-1:0] CD_Data; 
    logic [NBITS-1:0] Data; 
    logic enaA, enaB, enaC;
    logic [BR_WIDTH-1:0] addra;

    UART_RX_Logic #(
	    .BR_SIZE(BR_SIZE), //Largo del Vector a almacenar en BRAM
	    .BR_WIDTH(BR_WIDTH),   // clog2(BR_SIZE)
        .CLK_FREQUENCY(CLK_FREQUENCY),
        .BAUD_RATE(BAUD_RATE)
    ) UARTRXLOGIC(
        .clk(CLK100MHZ), 
        .rst(~CPU_RESETN),
        .rx(UART_RX),       // input data que viene desde el host
        .CD_Data(CD_Data),  // output a CommandDecoder
        .Data(Data),    // output a BRAM
        .enaA(enaA),        // enable memory write A
        .enaB(enaB),        // enable memory weite B
        .enaC(enaC),
        .addra(addra)    // direccion en memoria bram
    );
    
    
    //logic [7:0] doutbA, doutbB;
    logic [NBITS-1:0]A[BR_SIZE-1 :0];
    logic [NBITS-1:0]B[BR_SIZE-1 :0];
    
    BRAM #( .WIDTH(BR_SIZE), .NBITS(NBITS),.SIZE(BR_WIDTH)) BRAMA (.clk(CLK100MHZ), .addr(addra), .write(enaA), .din(Data), .out(A));
    BRAM #( .WIDTH(BR_SIZE), .NBITS(NBITS),.SIZE(BR_WIDTH)) BRAMB (.clk(CLK100MHZ), .addr(addra), .write(enaB), .din(Data), .out(B));
    
    
    logic [2:0] operation;
    logic flag_process;
    
    localparam READ_VEC_A = 'd1;
    localparam READ_VEC_B = 'd2;
    localparam SUM_VEC = 'd3;
    localparam AVG_VEC = 'd4;
    localparam MAN_DIST = 'd5;
    localparam EUC_DIST = 'd6;
    
    CommandDecoder CD(
    .clk(CLK100MHZ), 
    .rst(~CPU_RESETN),
    .enaC(enaC),
    .Command(CD_Data),
    .operation(operation),
    .flag_process(flag_process)
    );
    
    logic flag_sent32; // indica que se enviaron los 32 bits correctamente por la uart.
    logic flag_ready32; // indica que uart_tx puede empezar a enviar los 32 bits..
    logic [31:0] data32;
    
    UART_TX_Logic #( 
    .BR_SIZE(BR_SIZE),
    .BR_WIDTH(BR_WIDTH),
    .CLK_FREQUENCY(CLK_FREQUENCY),
	.BAUD_RATE(BAUD_RATE)
    ) UARTTXLOGIC (
    .clk(CLK100MHZ), 
    .rst(~CPU_RESETN),
    .data32(data32),
    .flag_ready32(flag_ready32), 
    .flag_process(flag_process),
    .operation(operation),

    .flag_sent32(flag_sent32),
    .UART_TX(UART_TX)
    );
    
    
    /*
    PocessingCore
   #(
	 .WIDTH(BR_SIZE),
	 .NBITS(NBITS)
   ) PROCESSINGCORE (
    .clk(CLK100MHZ), .rst(~CPU_RESETN),
    .command(operation),
    .A(A), .B(B),
    .flag_process(flag_process), .flag_sent32(flag_sent32),
    .flag_ready32(flag_ready32),
    .process_result(data32)
    );
    */
    
    
    //WRAPPER
    
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
    
    logic [NBITS*BR_SIZE/2-1:0] Awp;
    logic [NBITS*BR_SIZE/2-1:0] Bwp;
    
    logic A_ce0, B_ce0;
    
    assign Awp = (A_ce0)? Awrapped[NBITS*BR_SIZE/2-1:0]:Awrapped[NBITS*BR_SIZE-1:NBITS*BR_SIZE/2];
    assign Bwp = (B_ce0)? Bwrapped[NBITS*BR_SIZE/2-1:0]:Bwrapped[NBITS*BR_SIZE-1:NBITS*BR_SIZE/2];
    
    // instancia IP
    eucHW_0 PROCC (
  .A_ce0(A_ce0),            // output wire A_ce0
  .B_ce0(B_ce0),            // output wire B_ce0
  .C_ap_vld(flag_ready32),      // output wire C_ap_vld
  .ap_clk(CLK100MHZ),          // input wire ap_clk
  .ap_rst(~CPU_RESETN),          // input wire ap_rst
  .ap_start(flag_process),      // input wire ap_start
  .ap_done(),        // output wire ap_done
  .ap_idle(),        // output wire ap_idle
  .ap_ready(),      // output wire ap_ready
  .A_address0(),  // output wire [0 : 0] A_address0
  .A_q0(Awp),              // input wire [4095 : 0] A_q0
  .B_address0(),  // output wire [0 : 0] B_address0
  .B_q0(Bwp),              // input wire [4095 : 0] B_q0
  .C(data32)                    // output wire [31 : 0] C
);
   /*
    eucHW_0 PROCC (
    .C_ap_vld(flag_ready32),  // output wire C_ap_vld
    .ap_clk(CLK100MHZ),      // input wire ap_clk
    .ap_rst(~CPU_RESETN),      // input wire ap_rst
    .ap_start(flag_process),  // input wire ap_start
    .ap_done(),    // output wire ap_done
    .ap_idle(),    // output wire ap_idle
    .ap_ready(),  // output wire ap_ready
    .A(Awrapped),                // input wire [127 : 0] A
    .B(Bwrapped),                // input wire [127 : 0] B
    .C(data32)                // output wire [31 : 0] C
);*/
/*
ila_0 ILA (
	.clk(clk), // input wire clk

	.probe0(flag_process), // input wire [0:0]  probe0  
	.probe1(flag_ready32) // input wire [0:0]  probe1
);
*/
    
    DISP_MOD DISPLAY
    (
        .clk(CLK100MHZ), 
        .rst(~CPU_RESETN),
        .operation(operation),
        .flag_ready32(flag_ready32),
        .data32(data32),
        .SEG(SEG),
        .AN(AN)
    );
    
endmodule