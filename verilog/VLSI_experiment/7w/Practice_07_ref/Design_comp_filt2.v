`include "Filter2.v"

// 디자인 컴파일러에서 실행하기 위한 파일
module Design_comp_filt2(out, in, clk, rstn, c0, c1, c2, c3, c4 );

    output [22-1:0] out;
    input clk, rstn;
    input [12-1:0] in;
    input signed[12-1:0] c0, c1, c2, c3, c4;

    wire [22-1:0] trans_out;

    wire [12-1:0] trans_in;
    // SRAM을 모두 FF으로 바꾼다.
    d_ff_12bit TRANS_INPUT_MEM(trans_in, in, clk, rstn);

    Filter2 Filter2(trans_out, trans_in, clk, rstn, c0, c1, c2, c3, c4);

    d_ff_22bit TRANS_OUTPUT_MEM(out, trans_out, clk, rstn);


endmodule
