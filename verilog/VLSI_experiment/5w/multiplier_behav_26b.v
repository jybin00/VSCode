// 26-bit multipler behavior level로 작성하기.

module multiplier_behav_26b(out, a_input, b_input, clk, reset);

    output [52-1:0] out;
    input  [26-1:0] a_input, b_input;
    input  clk, reset;

    wire   [52-1:0] mul_out;
    wire   [26-1:0] a, b;

    D_FF_26bit dff26a (a, a_input, clk, reset);
    D_FF_26bit dff26b (b, b_input, clk, reset);

    assign mul_out = a * b;    // 단순하게 assign 구문으로 곱셈 실행

    D_FF_52bit dff52  (out, mul_out, clk, reset);


endmodule


module D_FF_26bit (q, d, clk, reset);

output [26-1:0] q;
input  [26-1:0] d;
input  clk, reset;

reg    [26-1:0] q;

always @ (posedge clk) begin
    if(~reset)
        q <= 1'b0;
    else 
	    q <= d;
end
endmodule

module D_FF_52bit (q, d, clk, reset);

output [52-1:0] q;
input  [52-1:0] d;
input  clk, reset;

reg    [52-1:0] q;

always @ (posedge clk) begin
    if(~reset)
        q <= 1'b0;
    else 
	    q <= d;
end
endmodule
