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
    wire [14-1:0] sram_out_addr;
    wire flag;
    wire o_en3, o_en4;

    COUNTER_ROW counter(clk, reset, count, flag);
    COUNTER_COL counter2(clk, reset, sram_out_addr, NWRT_OUT);
    rflp16384x128mx16 MEM_IN(x_n_in, pseudo_mem_in, RA_IN, CA_IN, NWRT_IN, NCE_IN, clk);
    DCT_UNIT DCT (X_k_out, x_n_in, clk, reset, flag, o_en3, o_en4);
    rflp16384x192mx16 MEM_OUT(pseudo_mem_out, X_k_out, RA_OUT, CA_OUT, NWRT_OUT, NCE_OUT, clk);

    assign NWRT_IN = 1'b1; assign NWRT_OUT = ~(o_en3 || o_en4);
    assign NCE_IN = 1'b0;  assign NCE_OUT = 1'b0;
    assign CA_IN = count[4-1:0];
    assign RA_IN = count[14-1:4];
    assign CA_OUT = sram_out_addr[4-1:0];
    assign RA_OUT = sram_out_addr[14-1:4];


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