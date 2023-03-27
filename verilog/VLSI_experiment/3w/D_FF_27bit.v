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
endmodule