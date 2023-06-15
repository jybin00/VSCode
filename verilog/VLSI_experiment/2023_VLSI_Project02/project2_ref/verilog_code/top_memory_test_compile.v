// stimulus에 들어가는 모듈
// `include "rflp16384x128mx16.v"
// `include "rflp16384x192mx16.v"
`include "DCT_UNIT.v"


module top_memory_test(clk, reset, NWRT_IN, NCE_IN, NWRT_OUT, NCE_OUT, RA_IN, CA_IN, RA_OUT, CA_OUT);
    input clk, reset;
    
    wire [16*12-1:0] X_k_out;
    wire [128-1:0] x_n_in;
    wire [128-1:0] pseudo_mem_in = 0;
    wire [16*12-1:0] pseudo_mem_out;

    output reg NWRT_IN, NCE_IN, NWRT_OUT, NCE_OUT = 1'b0;
    output reg [10-1:0] RA_IN = 10'b0;
    output reg [4-1:0] CA_IN = 4'b0;
    output reg [10-1:0] RA_OUT = 10'b0;
    output reg [4-1:0] CA_OUT = 4'b0;

    wire [14-1:0] count;
    wire [14-1:0] sram_out_addr;
    wire flag;
    wire o_en3, o_en4;

    COUNTER_ROW counter(clk, reset, count, flag);
    COUNTER_COL counter2(clk, reset, sram_out_addr, NWRT_OUT);
    d_ff_128bit dff_in (clk, reset, pseudo_mem_in, x_n_in);
    DCT_UNIT DCT (X_k_out, x_n_in, clk, reset, flag, o_en3, o_en4);
    d_ff_192bit dff_out (clk, reset, pseudo_mem_out, X_k_out);


endmodule

module COUNTER_ROW(clk, reset, count, flag);
    input clk, reset;
    output reg [14-1:0] count;
    output reg flag = 1'b0;
    reg [14-1:0] count_tmp;
    
    always @(posedge clk) begin
        if(!reset) begin
            count <= 1'b0;
            count_tmp <= 1'b0;
            flag <= 1'b0;
        end
        else
            count_tmp <= count_tmp + 1;
            count <= count_tmp;
            if(count[3:0] == 4'b0000) flag <= ~flag;
            
    end
endmodule

module COUNTER_COL(clk, reset, count, NWRT_OUT);
    input clk, reset, NWRT_OUT;
    output reg [14-1:0] count;
    reg [14-1:0] count_tmp;
    
    always @(posedge clk) begin
        if(!reset || NWRT_OUT) begin
            count <= 1'b0;
        end
        else
            count <= count + 1;
    end
endmodule

module d_ff_128bit (clk, reset, d, q);
    input clk, reset;
    input [128-1:0] d;
    output reg [128-1:0] q;
    
    always @(posedge clk) begin
        if(!reset) begin
            q <= 128'b0;
        end
        else
            q <= d;
    end
endmodule

module d_ff_192bit (clk, reset, d, q);
    input clk, reset;
    input [192-1:0] d;
    output reg [192-1:0] q;
    
    always @(posedge clk) begin
        if(!reset) begin
            q <= 192'b0;
        end
        else
            q <= d;
    end
endmodule