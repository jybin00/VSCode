`include "SRCSA_26bit_pipe.v"
`include "D_FF_26bit.v"
`include "D_FF_27bit.v"

module SRCSA_26bit_pipe_top (sum_output, a_input, b_input, c_in, clk, reset);

    output [27-1:0] sum_output;  // module에서는 input, output이 wire로 선언됨. 
    input [26-1:0] a_input, b_input; // module에서는 reg는 behavior level에서만 사용 할 수 있음.
    input clk, reset;
    input c_in;

    wire [27-1:0] sum;
    wire [26-1:0] a,b ;

    D_FF_26bit dff26_CSA0 ( a, a_input, clk, reset); // 전체 입력 a 보관용 DFF
    D_FF_26bit dff26_CSA1 ( b, b_input, clk, reset); // 전체 입력 b 보관용 DFF

    SRCSA_26bit_pipe CSA_pipe0 (sum, a, b, c_in, clk, reset); // comb circuit

    D_FF_27bit dff27_0 ( sum_output, sum, clk, reset); // 전체 출력 sum_output 보관용 DFF

endmodule
