`include "Square_Root_CSA_26bits.v"
`include "D_FF_26bit.v"
`include "D_FF_27bit.v"

module Square_Root_CSA_26bits_DFF (sum_output, a_input, b_input, c_in, clk, reset);

    output [27-1:0] sum_output;  // module에서는 input, output이 wire로 선언됨. 
    input [26-1:0] a_input, b_input; // module에서는 reg는 behavior level에서만 사용 할 수 있음.
    input clk, reset;
    input c_in;

    wire [27-1:0] sum;
    wire [26-1:0] a,b ;

    D_FF_26bit dff26_CSA0 ( a, a_input, clk, reset);
    D_FF_26bit dff26_CSA1 ( b, b_input, clk, reset);

    Square_Root_CSA_26bits CSA0 (sum, a, b, 1'b0);

    D_FF_27bit dff27_0 ( sum_output, sum, clk, reset);

endmodule
/*
module D_FF_26bit (q, d, clk, reset);

output [26-1:0] q;
input  [26-1:0] d;
input  clk, reset;

reg    [26-1:0] q;

always @ (negedge clk) begin
    if(reset)
        q <= 1'b0;
    else 
	    q <= d;
end
endmodule

module D_FF_27bit (q, d, clk, reset);
output [27-1:0] q;
input  [27-1:0] d;
input  clk, reset;

reg    [27-1:0] q;

always @ (negedge clk) begin
    if(reset)
        q <= 1'b0;
    else 
	q <= d;
end
endmodule */
