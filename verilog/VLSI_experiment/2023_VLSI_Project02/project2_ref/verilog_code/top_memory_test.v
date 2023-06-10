// stimulus에 들어가는 모듈
`include "rflp16384x128mx16.v"
//`include "rfsp16384x192mx16.v"
`include "DCT_1D_row_low_cost.v"

module top_memory_test(clk, reset);
    input clk, reset;
    
    wire [176-1:0] X_k_out;
    wire [128-1:0] x_n_in;
    wire [128-1:0] pseudo_mem_in = 0;

    wire NWRT, NCE;
    wire [10-1:0] RA;
    wire [4-1:0] CA;

    wire [14-1:0] count;
    counter counter(clk, reset, count);
    rflp16384x128mx16 MEM_IN(x_n_in, pseudo_mem_in, RA, CA, NWRT, NCE, clk);
    DCT_1D_row DCT (X_k_out, x_n_in, clk, reset);

    assign NWRT = 1'b1;
    assign NCE = 1'b0;
    assign CA = count[4-1:0];
    assign RA = count[14-1:4];
endmodule

module counter(clk, reset, count);
    input clk, reset;
    output reg [14-1:0] count;
    
    always @(posedge clk or negedge reset)
        if(!reset)
            count <= 0;
        else
            count <= count + 1;
endmodule