// stimulus에 들어가는 모듈
`include "rflp16384x128mx16.v"
`include "rflp16384x192mx16.v"
`include "DCT_UNIT.v"


module top_memory_test(clk, reset);
    input clk, reset;
    
    wire [16*12-1:0] X_k_out;
    wire [128-1:0] x_n_in;
    wire [128-1:0] pseudo_mem_in = 0;
    wire [16*12-1:0] pseudo_mem_out;

    wire NWRT_IN, NCE_IN, NWRT_OUT, NCE_OUT;
    wire [10-1:0] RA_IN;
    wire [4-1:0] CA_IN;
    wire [10-1:0] RA_OUT;
    wire [4-1:0] CA_OUT;

    wire [14-1:0] count;
    wire flag;
    counter counter(clk, reset, count, flag);
    rflp16384x128mx16 MEM_IN(x_n_in, pseudo_mem_in, RA_IN, CA_IN, NWRT_IN, NCE_IN, clk);
    DCT_UNIT DCT (X_k_out, x_n_in, clk, reset, flag);
    rflp16384x192mx16 MEM_OUT(pseudo_mem_out, X_k_out, RA_OUT, CA_OUT, NWRT_OUT, NCE_OUT, clk);

    assign NWRT_IN = 1'b1;
    assign NCE_IN = 1'b0;
    assign CA_IN = count[4-1:0];
    assign RA_IN = count[14-1:4];


endmodule

module counter(clk, reset, count, flag);
    input clk, reset;
    output reg [14-1:0] count;
    output reg flag;
    
    always @(posedge clk) begin
        if(!reset) begin
            count <= 0;
            flag <= 1;
        end
        else
            count <= count + 1;
            if(count[3:0] == 4'b0000) flag <= ~flag;
            
    end
endmodule