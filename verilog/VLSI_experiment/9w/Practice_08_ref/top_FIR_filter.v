// 5 tap FIR filter
`include "rflp256x12mx4.v"
`include "rflp256x22mx4.v"
`include "direct_filter.v"

module top_FIR_filter(clk, rstn, c0, c1, c2, c3, c4 );

    input clk, rstn;
    input [12-1:0] c0, c1, c2, c3, c4;


    rflp256x12mx4 DIRECT_INPUT_MEM(NWRT, DIN, RA, CA, NCE, CLK, DO);
    rflp256x22mx4



endmodule